; usually, the game doesn't loop here at all, since as soon as a main menu option
; is selected, there is no need to come back to the menu.
; the only exception is after returning from Card Pop!
_GameLoop::
	; ld a, 1
	; ld [wPlayTimeCounterEnable], a

	call ZeroObjectPositions
	ld hl, wVBlankOAMCopyToggle
	inc [hl]
	farcall SetIntroSGBBorder
	; ld a, $ff
	; ld [wLastSelectedStartMenuItem], a

.main_menu_loop
	ld a, PLAYER_TURN
	ldh [hWhoseTurn], a
	call Zero_start_vars
	farcall HandleTitleScreen	
	
	ld a, [wStartMenuChoice]
	ld hl, MainMenuFunctionTable
	call JumpToFunctionInTable
	jr c, .cancel;main_menu_loop ; return to main menu
	jr _GameLoop ; virtually restart game

.cancel
	ld a, SFX_CANCEL
	call PlaySFX
	jr .main_menu_loop	

MainMenuFunctionTable:
	dw MainMenu_Profile;MainMenu_CardPop
	dw MainMenu_Duel;MainMenu_ContinueFromDiary
	dw MainMenu_DeckBuilder;MainMenu_NewGame
	dw MainMenu_DeckVault;MainMenu_ContinueDuel

ChooseAvatar_::
	call InitMenuScreen
	lb de,  0,  0
	lb bc, 20, 12
	call DrawRegularTextBox
	; ld hl, DiaryScreenLabels
	; call PrintLabels
	lb bc, 1, 3
	ld a, 1
	ld a,  [wPlayerPortrait]
	call DrawPauseMenuPlayerPortrait

	lb de, 8, 2
	call InitTextPrinting
	ldtx hl, ChooseAvatarText
	call PrintTextNoDelay
	
	; lb bc, 12, 8
	; call PrintAlbumProgress
	; lb bc, 13, 10
	; call PrintPlayTime
	; lb bc, 16, 6
	;call PrintMedalCount
	call FlashWhiteScreen
.no_cancel
	call ChangeAvatar
	jr c, .no_cancel
	ret

MainMenu_Profile:
	; ld a, [wd291]
	; push af
	call InitMenuScreen
	lb de,  0,  0
	lb bc, 20, 12
	call DrawRegularTextBox
	ld hl, DiaryScreenLabels
	call PrintLabels
	lb bc, 1, 3
	ld a,  [wPlayerPortrait]
	call DrawPauseMenuPlayerPortrait
	; lb bc, 12, 8
	; call PrintAlbumProgress
	lb bc, 13, 10
	call PrintPlayTime
	lb bc, 16, 6
	;call PrintMedalCount
	call FlashWhiteScreen

.wait_A_or_B_loop
 	call DoFrame
	ldh a, [hKeysPressed]
	and PAD_A | PAD_B
	jr z, .wait_A_or_B_loop

	ldh a, [hKeysPressed]
	and PAD_B
	ret nz

	ld a, SFX_CURSOR
	call PlaySFX
	call HandleProfileMenuInput
	ret 

DiaryScreenLabels:
	db 5, 1
	tx PlayerDiaryTitleText

	db 7, 4
	tx PlayerStatusNameText

	db 7, 6
	tx PlayerOnlineWinsText

	db 7, 8
	tx PlayerOnlineLossesText

	db 7, 10
	tx PlayerStatusPlayTimeText

	db $ff

HandleProfileMenuInput::
	ldtx hl, ChangeProfileText
	call TwoItemHorizontalMenu_cancel
	ret c
	ld a, [hCurMenuItem]
	or a
	jr z, .option1
	;option2
	call ChangeAvatar	
	; ld a, SFX_CANCEL
	; call PlaySFX
	ret

.option1
    farcall DisplayPlayerNamingScreen	
	ret

ChangeAvatar::
	ldtx hl, ChangeAvatarText
	call DrawWideTextBox_PrintTextNoDelay
	; call PrintTextNoDelay
	ld a, 1
	ldh [hTempList], a

.loop
	call DoFrame
	ldh a, [hKeysPressed]
	and PAD_A
	jr nz, .a_pressed

	ldh a, [hKeysPressed]	
	and PAD_B
	jr nz, .cancel	

	ldh a, [hKeysPressed]	
	and PAD_LEFT
	jr nz, .left_pressed	

	ldh a, [hKeysPressed]	
	and PAD_RIGHT
	jr nz, .right_pressed

	jr .loop

.left_pressed	
	ld a, [hTempList]
	dec a
	or a 
	jr z, .wrap_end
	ld [hTempList], a
	jr .input	
.wrap_end
	ld a, $29
	ld [hTempList], a
	jr .input

.right_pressed
	ld a, [hTempList]
	inc a
	cp $2a
	jr z, .wrap_start
	ld [hTempList], a	
	jr .input		

.wrap_start
	ld a, 1
	ld [hTempList], a
	;jr .input	

.input	
	ld a, SFX_CURSOR
	call PlaySFX
	lb bc, 1, 3

	ldh a, [hTempList]
	ld [wPlayerPortrait], a
	call DrawPlayerPortrait
	jr .loop

.a_pressed
    call EnableSRAM
    ld a, [wPlayerPortrait]
    ld [sPlayerPortrait], a
    call DisableSRAM	

	ld a, SFX_SAVE_GAME
	call PlaySFX
.wait_sfx
	call AssertSFXFinished
	or a
	jr nz, .wait_sfx
	ret	

.cancel	
	ld a, SFX_CANCEL
	call PlaySFX
	call .wait_sfx
	scf
	ret

MainMenu_Duel:
	call HandleDuelMenuChoice
	ret c
	ld a, [hCurMenuItem]
	or a
	jr z, .online

;challenge	
	call GameEvent_ChallengeMachine
	ret

.online
	;do online duel
	call GameEvent_BattleCenter
	; bank1call SetUpAndStartLinkDuel
	ret


	; ld a, MUSIC_STOP
	; call PlaySong
	; ;farcall ClearEvents
	; farcall $04, LoadGeneralSaveData	

MainMenu_DeckBuilder:
	farcall TransitionScreen
	farcall PauseMenu_Deck
	ret

MainMenu_DeckVault:
	farcall HandleDeckSaveMachineMenu
	ret

; MainMenu_NewGame:
; 	farcall Func_c1b1 ;setup gamestart freaquence
; 	call DisplayPlayerNamingScreen
; 	farcall InitSaveData
; 	call EnableSRAM
; 	ld a, [sAnimationsDisabled]
; 	ld [wAnimationsDisabled], a
; 	ld a, [sTextSpeed]
; 	ld [wTextSpeed], a
; 	call DisableSRAM
; 	ld a, MUSIC_STOP
; 	call PlaySong
; 	farcall SetMainSGBBorder
; 	ld a, MUSIC_OVERWORLD
; 	ld [wDefaultSong], a
; 	call PlayDefaultSong
; 	farcall DrawPlayerPortraitAndPrintNewGameText
; 	ld a, GAME_EVENT_OVERWORLD
; 	ld [wGameEvent], a
; 	farcall $03, ExecuteGameEvent
; 	or a
; 	ret

; MainMenu_ContinueFromDiary:
; 	ld a, MUSIC_STOP
; 	call PlaySong
; 	call ValidateBackupGeneralSaveData
; 	jr nc, MainMenu_NewGame
; 	farcall Func_c1ed
; 	farcall SetMainSGBBorder
; 	call EnableSRAM
; 	xor a
; 	ld [sPlayerInChallengeMachine], a
; 	call DisableSRAM
; 	ld a, GAME_EVENT_OVERWORLD
; 	ld [wGameEvent], a
; 	farcall $03, ExecuteGameEvent
; 	or a
; 	ret

; MainMenu_CardPop:
; 	ld a, MUSIC_CARD_POP
; 	call PlaySong
; 	bank1call DoCardPop
; 	farcall WhiteOutDMGPals
; 	call DoFrameIfLCDEnabled
; 	ld a, MUSIC_STOP
; 	call PlaySong
; 	scf
; 	ret

MainMenu_ContinueDuel:
	ld a, MUSIC_STOP
	call PlaySong
	;farcall ClearEvents
	farcall $04, LoadGeneralSaveData
	farcall SetMainSGBBorder
	ld a, GAME_EVENT_CONTINUE_DUEL
	ld [wGameEvent], a
	farcall $03, ExecuteGameEvent
	or a
	ret

Zero_start_vars:
	xor a
	ld [wSelectedPauseMenuItem], a
	ld [wSelectedPCMenuItem], a
	ld [wSelectedGiftCenterMenuItem], a
	ld [wConfigCursorYPos], a
	ld [wActiveGameEvent], a
	ld [wDefaultSong], a
	ld [wSongOverride], a
	ld [wRonaldIsInMap], a
	call EnableSRAM
	ld a, [sAnimationsDisabled]
	ld [wAnimationsDisabled], a
	ld a, [sTextSpeed]
	ld [wTextSpeed], a
	call DisableSRAM
	; farcall InitPCPacks
	ret