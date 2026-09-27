; plays the Opening sequence, and handles player selection
; in the Title Screen and Start Menu
HandleTitleScreen::
; if last selected item in Start Menu is 0 (Card Pop!)
; then skip straight to the Start Menu
; this makes it so that returning from Card Pop!
; doesn't play the Opening sequence
	;call CheckIfHasSaveData
	; sPlayerName

	; jp .create_profile ; test

	ld a, FALSE
	ld [wP1_Ready], a
	ld [wP2_Ready], a	

	push de
	call EnableSRAM

	ld a, FALSE
	ld [wHasSaveData], a	

	ld hl, sPlayerName
	ld a, [hl]
	; cp $ff
	or a
	jr z, .new
	call LoadPlayerProfileToClient
	ld a, TRUE
.new
	ld [wHasSaveData], a
	call DisableSRAM

	pop de


	ld a, [wHasSaveData]
	cp FALSE ; or a
	jp z, .create_profile

	ld a, [wLastSelectedStartMenuItem]
	cp $ff
	jr nz, .start_menu

.play_opening
	ld a, MUSIC_STOP
	call PlaySong
	call EnableAndClearSpriteAnimations
	call PlayIntroSequence
	call LoadTitleScreenSprites

	xor a
	ld [wTitleScreenOrbCounter], a
	ld a, $3c
	ld [wTitleScreenIgnoreInputCounter], a
.loop
	call DoFrameIfLCDEnabled
	call UpdateRNGSources
	call AnimateRandomTitleScreenOrb
	ld hl, wTitleScreenOrbCounter
	inc [hl]
	call AssertSongFinished
	or a
	jr nz, .song_playing
	; reset back to the opening sequence
	farcall FadeScreenToWhite
	jr .play_opening

.song_playing
	; should we ignore user input?
	ld hl, wTitleScreenIgnoreInputCounter
	ld a, [hl]
	or a
	jr z, .check_keys
	; ignore input, decrement the counter
	dec [hl]
	jr .loop

.check_keys
	ldh a, [hKeysPressed]
	and PAD_A | PAD_START
	jr z, .loop
	ld a, SFX_CONFIRM
	call PlaySFX
	farcall FadeScreenToWhite

.start_menu
	; ld a, [wHasSaveData]
	; cp FALSE ; or a
	; jr z, .create_profile
	; 	farcall LoadGeneralSaveData
; 	farcall ValidateGeneralSaveData
; 	jr nc, .create_profile
; .nop
; 	farcall LoadBackupSaveData
; 	farcall ValidateBackupGeneralSaveData
; 	jr nc, .create_profile
	;good

	call HandleStartMenu
	ret
; .nop
; 	ld a, [wStartMenuChoice]
; 	; cp START_MENU_PROFILE
; 	; jr z, .load_profile

; 	cp START_MENU_DECKBUILDER
; 	jr z, .deckbuilder

; 	cp START_MENU_DECK_VAULT
; 	jr z, .load_vault

; 	cp START_MENU_DUEL
; 	jr nz, .start_menu

; ;.DUEL
; 	call HandleDuelMenuChoice
; 	jr c, .cancel;cancel

; 	ld a, [hCurMenuItem]
; 	or a
; 	jr z, .online

; ;challenge	
; 	farcall GameEvent_ChallengeMachine
; 	ret

; .online
; 	;do online duel
; 	bank1call SetUpAndStartLinkDuel
; 	jp HandleTitleScreen
; 	; scf
; 	; ret	

; .cancel
; 	ld a, SFX_CANCEL
; 	call PlaySFX
; .wait_sfx
; 	call AssertSFXFinished
; 	or a
; 	jr nz, .wait_sfx		
; 	scf
; 	ret

; .load_vault
; 	farcall HandleDeckSaveMachineMenu
; 	ret

; .deckbuilder
; 	call TransitionScreen
; 	farcall PauseMenu_Deck
; 	ret

; .load_profile
; 	; farcall MainMenu_Profile;_PauseMenu_Status
; 	ret

.create_profile
    farcall InitSaveData
	farcall DisplayPlayerNamingScreen
    call ChooseAvatar

    call EnableSRAM
	xor a
	ld [sAnimationsDisabled], a
    ld [wAnimationsDisabled], a
 	ld a, TEXT_SPEED_5
    ld a, [sTextSpeed]
	ld [wTextSpeed], a
    call DisableSRAM

    ld a, MUSIC_STOP
    call PlaySong

    xor a
    ld [wLastSelectedStartMenuItem], a

    farcall SaveGame

    ld a, TRUE
    ld [wHasSaveData], a

    call LoadPlayerProfileToClient

    jr .start_menu


LoadPlayerProfileToClient::
    call EnableSRAM

    ; Name
    ld hl, sPlayerName
    ld de, wPlayerName_
    ld c, NAME_BUFFER_LENGTH
.copy_name
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .copy_name

    ; Portrait
    ld a, [sPlayerPortrait]
    ld [wPlayerPortrait], a

    call DisableSRAM
    ret


ChooseAvatar::
	farcall ChooseAvatar_
	ret
; 	ld a, PLAYER_PIC
; 	ld [wPlayerPortrait], a
; .menu	
; ;tbc
; ;left / right navigation to loop through NUM_PICS -1 (0 is invalid)
	

; 	ld [wPlayerPortrait], a

; 	call DrawPlayerPortrait
; 	jr .menu

; updates wHasSaveData and wHasDuelSaveData
; depending on whether the save data is valid or not
CheckIfHasSaveData:
	farcall ValidateBackupGeneralSaveData
	ld a, TRUE
	jr c, .no_error
	ld a, FALSE
.no_error
	ld [wHasSaveData], a
	cp FALSE ; or a
	jr z, .write_has_duel_data
	bank1call ValidateSavedNonLinkDuelData
	ld a, TRUE
	jr nc, .write_has_duel_data
	ld a, FALSE
.write_has_duel_data
	ld [wHasDuelSaveData], a
	farcall ValidateBackupGeneralSaveData
	ret

TransitionScreen:
	push hl
	push bc
	push de
	;call BackupObjectPalettes
	farcall FadeScreenToWhite
	; ld a, 1 << HIDE_ALL_NPC_SPRITES
	; call SetOverworldNPCFlags
	lb de, $30, $7f
	call SetupText
	farcall Func_12ba7
	call EnableAndClearSpriteAnimations
	call ZeroObjectPositions
	ld a, $1
	ld [wVBlankOAMCopyToggle], a
	call EnableLCD
	call DoFrameIfLCDEnabled
	call DisableLCD
	pop de
	pop bc
	pop hl
	ret

; PauseMenu_Deck:
; 	call TransitionScreen
; 	xor a
; 	ldh [hSCX], a
; 	ldh [hSCY], a
; 	call Set_OBJ_8x16
; 	farcall SetDefaultPalettes
; 	farcall DeckSelectionMenu
; 	call Set_OBJ_8x8
; 	ret

; handles printing the Start Menu
; and getting player input and choice
HandleStartMenu:
.start
	ld a, MUSIC_PC_MAIN_MENU
	call PlaySong
	call DisableLCD
	farcall InitMenuScreen
	lb de, $30, $8f
	call SetupText
	call EnableAndClearSpriteAnimations
	xor a ; DOUBLE_SPACED
	ld [wLineSeparation], a
	call .DrawPlayerPortrait
	call .SetStartMenuParams

	ld a, $ff
	ld [wTitleScreenIgnoreInputCounter], a

	; ld a, [wHasSaveData]
	; cp FALSE ; or a
	; jr z, .create_profile

	; ld a, [wLastSelectedStartMenuItem]
	; cp $4
	; jr c, .init_menu
	; ld a, [wHasSaveData]
	; or a
	; jr z, .init_menu
	; ld a, 1 ; start at second menu option
.init_menu
	ld hl, wStartMenuParams
	xor a
	farcall InitAndPrintMenu
	farcall FlashWhiteScreen

.wait_input
	call DoFrameIfLCDEnabled
	call UpdateRNGSources
	call HandleMenuInput
	push af
	call PrintStartMenuDescriptionText
	pop af
	jr nc, .wait_input
	ldh a, [hCurMenuItem]
	cp e
	jr nz, .wait_input

	ld [wLastSelectedStartMenuItem], a
	; ld a, [wHasSaveData]
	; or a
	; jr nz, .no_adjustment
	; ; New Game is 3rd option
	; ; but when there's no save data,
	; ; it's the 1st in menu list, so adjust it
	; inc e
	; inc e
.no_adjustment
	ld a, e
	ld [wStartMenuChoice], a
	ret

.SetStartMenuParams
	ld hl, .StartMenuParams
	ld de, wStartMenuParams
	ld bc, .StartMenuParamsEnd - .StartMenuParams
	call CopyDataHLtoDE
	ret
	; ld e, 0
	; ld a, [wHasSaveData]
	; or a
	; jr z, .get_text_id ; New Game
	; inc e
	; ld a, 2
	; call .AddItems
	; ld a, [wHasDuelSaveData]
	; or a
	; jr z, .get_text_id ; Continue From Diary
	; inc e
; 	ld e, 2
; 	ld a, 4
; 	; ld c, 4
; 	call .AddItems
; 	; Continue Duel

; .get_text_id
; 	; sla e
; 	; ld d, $00
; 	ld hl, .StartMenuTextIDs
; 	; add hl, de
; 	; set text ID as Start Menu param
; 	ld a, [hli]
; 	ld [wStartMenuParams + 6], a
; 	ld a, [hl]
; 	ld [wStartMenuParams + 7], a
; 	ret

; adds c items to start menu list
; this means adding 2 units per item to the text box height
; and adding to the number of items
; .AddItems
; 	push bc
; 	ld c, a
; 	; number of items in menu
; 	ld a, [wStartMenuParams + 12]
; 	add c
; 	ld [wStartMenuParams + 12], a
; 	; height of text box
; 	sla c
; 	ld a, [wStartMenuParams + 3]
; 	add c
; 	ld [wStartMenuParams + 3], a
; 	pop bc
; 	ret

.StartMenuParams
	db  0, 0 ; start menu coords
	db 14, 10 ; start menu text box dimensions

	db  2, 2 ; text alignment for InitTextPrinting
	tx StartMenuTextItems
	db $ff

	db 1, 2 ; cursor x, cursor y
	db 2 ; y displacement between items
	db 4 ; number of items
	db SYM_CURSOR_R ; cursor tile number
	db SYM_SPACE ; tile behind cursor
	dw NULL ; function pointer if non-0
.StartMenuParamsEnd

; .StartMenuTextIDs
; 	tx StartMenuTextItems;NewGameText
	; tx DuelText;CardPopContinueDiaryNewGameText
	; tx DeckBuilderText;CardPopContinueDiaryNewGameContinueDuelText
	; tx DeckVaultText

.DrawPlayerPortrait
	lb bc, 14, 1
	farcall $4, DrawPlayerPortrait
	ret

; prints the description for the current selected item
; in the Start Menu in the text box
PrintStartMenuDescriptionText:
	push hl
	push bc
	push de
	; don't print if it's already showing
	ld a, [wCurMenuItem]
	ld e, a
	ld a, [wCurHighlightedStartMenuItem]
	cp e
	jr z, .skip
; 	ld a, [wHasSaveData]
; 	or a
; 	jr nz, .has_data
; 	; New Game option is 3rd element
; 	; in function table, so add 2
; 	inc e
; 	inc e
; .has_data
	; inc e
	ld a, e
	push af
	lb de, 0, 10
	lb bc, 20, 8
	call DrawRegularTextBox
	pop af
	ld hl, .StartMenuDescriptionFunctionTable
	call JumpToFunctionInTable
.skip
	ld a, [wCurMenuItem]
	ld [wCurHighlightedStartMenuItem], a
	pop de
	pop bc
	pop hl
	ret

.StartMenuDescriptionFunctionTable
	dw .Profile;CardPop
	dw .Duel;ContinueFromDiary
	dw .DeckBuilder;NewGame
	dw .DeckVault;ContinueDuel

.Profile
	lb de, 1, 12
	call InitTextPrinting
	ldtx hl,ProfileText
	call PrintTextNoDelay
	ret

.Duel
	lb de, 1, 12
	call InitTextPrinting
	ldtx hl,DuelText
	call PrintTextNoDelay
	ret

.DeckBuilder
	lb de, 1, 12
	call InitTextPrinting
	ldtx hl,DeckBuilderText
	call PrintTextNoDelay
	ret

.DeckVault
	lb de, 1, 12
	call InitTextPrinting
	ldtx hl,DeckVaultText
	call PrintTextNoDelay
	ret

; .CardPop
; 	lb de, 1, 12
; 	call InitTextPrinting
; 	ldtx hl, WhenYouCardPopWithFriendText
; 	call PrintTextNoDelay
; 	ret

; .ContinueDuel
; 	lb de, 1, 12
; 	call InitTextPrinting
; 	ldtx hl, TheGameWillContinueFromThePointInTheDuelText
; 	call PrintTextNoDelay
; 	ret

; .NewGame
; 	lb de, 1, 12
; 	call InitTextPrinting
; 	ldtx hl, StartANewGameText
; 	call PrintTextNoDelay
; 	ret

; .ContinueFromDiary
; 	; get OW map name
; 	ld a, [wCurOverworldMap]
; 	add a
; 	ld c, a
; 	ld b, $00
; 	ld hl, OverworldMapNames
; 	add hl, bc
; 	ld a, [hli]
; 	ld [wTxRam2 + 0], a
; 	ld a, [hl]
; 	ld [wTxRam2 + 1], a

; 	; get medal count
; 	ld a, [wMedalCount]
; 	ld [wTxRam3 + 0], a
; 	xor a
; 	ld [wTxRam3 + 1], a

; 	; print text
; 	lb de, 1, 10
; 	call InitTextPrinting
; 	ldtx hl, ContinueFromDiarySummaryText
; 	call PrintTextNoDelay

; 	ld a, [wTotalNumCardsCollected]
; 	ld d, a
; 	ld a, [wTotalNumCardsToCollect]
; 	ld e, a
; 	lb bc, 9, 14
; 	farcall PrintAlbumProgress_SkipGetProgress
; 	lb bc, 10, 16
; 	farcall PrintPlayTime_SkipUpdateTime
; 	ret

; asks the player whether it's okay to delete
; the save data in order to create a new one
; if player answers "yes", delete it
DeleteSaveDataForNewGame:
; exit if there no save data
	ld a, [wHasSaveData]
	or a
	ret z

	call DisableLCD
	farcall InitMenuScreen
	call EnableAndClearSpriteAnimations
	farcall FlashWhiteScreen
	call DoFrameIfLCDEnabled
	ldtx hl, SavedDataAlreadyExistsText
	call PrintScrollableText_NoTextBoxLabel
	ldtx hl, OKToDeleteTheDataText
	call YesOrNoMenuWithText
	ret c ; quit if chose "no"
	farcall InvalidateSaveData
	ldtx hl, AllDataWasDeletedText
	call PrintScrollableText_NoTextBoxLabel
	or a
	ret

; asks the player if the game should resume
; from diary even though there is Duel save data
; returns carry if "no" was selected
AskToContinueFromDiaryWithDuelData:
; return if there's no duel save data
	ld a, [wHasDuelSaveData]
	or a
	ret z

	call DisableLCD
	farcall InitMenuScreen
	call EnableAndClearSpriteAnimations
	farcall FlashWhiteScreen
	call DoFrameIfLCDEnabled
	ldtx hl, DataExistsWhenPowerWasTurnedOFFDuringDuelText
	call PrintScrollableText_NoTextBoxLabel
	ldtx hl, ContinueFromDiaryText
	call YesOrNoMenuWithText
	ret c
	or a
	ret

; shows disclaimer for Card Pop!
; in case player is not playing in CGB
; return carry if disclaimer was shown
ShowCardPopCGBDisclaimer:
; return if playing in CGB
	ld a, [wConsole]
	cp CONSOLE_CGB
	ret z

	lb de, 0, 10
	lb bc, 20, 8
	call DrawRegularTextBox
	lb de, 1,12
	call InitTextPrinting
	ldtx hl, YouCanAccessCardPopOnlyWithGameBoyColorsText
	call PrintTextNoDelay
	lb bc, SYM_CURSOR_D, SYM_BOX_BOTTOM
	lb de, 18, 17
	call SetCursorParametersForTextBox
	call WaitForButtonAorB
	scf
	ret

DrawPlayerPortraitAndPrintNewGameText:
	call DisableLCD
	farcall LoadConsolePaletteData
	farcall InitMenuScreen
	call EnableAndClearSpriteAnimations
	ld hl, HandleAllSpriteAnimations
	call SetDoFrameFunction
	lb bc, 7, 3
	farcall $4, DrawPlayerPortrait
	farcall FadeScreenFromWhite
	call DoFrameIfLCDEnabled
	ldtx hl, IsCrazyAboutPokemonAndPokemonCardCollectingText
	call PrintScrollableText_NoTextBoxLabel
	call ResetDoFrameFunction
	call EnableAndClearSpriteAnimations
	ret
