; _ProfileMenu:
; 	; ld a, [wd291]
; 	; push af
; 	call InitMenuScreen
; 	lb de,  0,  0
; 	lb bc, 20, 12
; 	call DrawRegularTextBox
; 	ld hl, DiaryScreenLabels
; 	call PrintLabels
; 	lb bc, 1, 3
; 	call DrawPauseMenuPlayerPortrait
; 	; lb bc, 12, 8
; 	; call PrintAlbumProgress
; 	lb bc, 13, 10
; 	call PrintPlayTime
; 	lb bc, 16, 6
; 	;call PrintMedalCount
; 	call FlashWhiteScreen
; ; 	ldtx hl, PlayerDiarySaveQuestionText
; ; 	call YesOrNoMenuWithText_SetCursorToYes
; ; 	jr c, .cancel
; ; 	farcall BackupPlayerPosition
; ; 	call SaveAndBackupData
; ; 	ld a, SFX_SAVE_GAME
; ; 	call PlaySFX
; ; 	ldtx hl, PlayerDiarySaveConfirmText
; ; 	jr .print_result_text
; ; .cancel
; ; 	ldtx hl, PlayerDiarySaveCancelText
; ; .print_result_text
; ; 	call PrintScrollableText_NoTextBoxLabel
; 	; pop af
; 	; ld [wd291], a
; 	call HandleProfileMenuInput;PrintProfileMenuAndHandleInput
; 	ret 

; DiaryScreenLabels:
; 	db 5, 1
; 	tx PlayerDiaryTitleText

; 	db 7, 4
; 	tx PlayerStatusNameText

; 	db 7, 6
; 	tx PlayerOnlineWinsText

; 	db 7, 8
; 	tx PlayerOnlineLossesText

; 	db 7, 10
; 	tx PlayerStatusPlayTimeText

; 	db $ff

; ; PrintProfileMenuAndHandleInput:
; ; 	; call DrawWideTextBox
; ; 	ld hl, ProfileMenuTextData
; ; 	call PlaceTextItems
; ; .menu_items_printed
; ; 	; call SaveDuelData
; ; 	; ld a, [wDuelFinished]
; ; 	; or a
; ; 	; ret nz
; ; 	ld a, [wCurrentDuelMenuItem]
; ; 	call SetMenuItem

; ; .handle_input
; ; 	call DoFrame
; ; 	ldh a, [hKeysPressed]
; ; 	and PAD_B
; ; 	ret z; b_pressed
; ; 	and PAD_A
; ; 	jr nz, .a_pressed
; ; 	jr .handle_input
; ; 	; ldh a, [hKeysPressed]
; ; 	; bit B_PAD_UP, a
; ; 	; jr nz, DuelMenuShortcut_OpponentPlayArea
; ; 	; bit B_PAD_DOWN, a
; ; 	; jr nz, DuelMenuShortcut_PlayerPlayArea
; ; 	; bit B_PAD_LEFT, a
; ; 	; jr nz, DuelMenuShortcut_PlayerDiscardPile
; ; 	; bit B_PAD_RIGHT, a
; ; 	; jr nz, DuelMenuShortcut_OpponentDiscardPile
; ; 	; bit B_PAD_START, a
; ; 	; jp nz, DuelMenuShortcut_OpponentActivePokemon

; ; .a_pressed
; ; 	call HandleProfileMenuInput
; ; 	ld a, e
; ; 	ld [wCurrentDuelMenuItem], a
; ; 	jr nc, .handle_input
; ; 	ldh a, [hCurMenuItem]
; ; 	ld hl, DuelMenuFunctionTable
; ; 	jp JumpToFunctionInTable

; ; ProfileMenuFunctionTable:
; ; 	dw DuelMenu_Change_name
; ; 	dw DuelMenu_Change_Avatar	

; ; ProfileMenuTextData:
; ; 	; x, y, text id
; ; 	textitem 3,  14, HandText
; ; 	textitem 9,  14, CheckText
; ; 	db $ff

; ; DuelMenu_Change_name:


; ; DuelMenu_Change_Avatar:

; ; 	ret

; ; ChangeProfileText

; ; ; handle input for the 2-row 3-column duel menu.
; ; ; only handles input not involving the B, PAD_START, or PAD_SELECT buttons, that is,
; ; ; navigating through the menu or selecting an item with the A button.
; ; ; other input in handled by PrintProfileMenuAndHandleInput.handle_input
; HandleProfileMenuInput::
; ; 	ldh a, [hDPadHeld]
; ; 	or a
; ; 	jr z, .blink_cursor
; ; 	ld b, a
; ; 	ld hl, wCurMenuItem
; ; 	and PAD_UP | PAD_DOWN
; ; 	jr z, .check_left
; ; 	ld a, [hl]
; ; 	xor 1 ; move to the other menu item in the same column
; ; 	jr .dpad_pressed
; ; .check_left
; ; 	bit B_PAD_LEFT, b
; ; 	jr z, .check_right
; ; 	ld a, [hl]
; ; 	sub 2
; ; 	jr nc, .dpad_pressed
; ; 	; wrap to the rightmost item in the same row
; ; 	and 1
; ; 	add 4
; ; 	jr .dpad_pressed
; ; .check_right
; ; 	bit B_PAD_RIGHT, b
; ; 	jr z, .dpad_not_pressed
; ; 	ld a, [hl]
; ; 	add 2
; ; 	cp 6
; ; 	jr c, .dpad_pressed
; ; 	; wrap to the leftmost item in the same row
; ; 	and 1
; ; .dpad_pressed
; ; 	push af
; ; 	ld a, SFX_CURSOR
; ; 	call PlaySFX
; ; 	call .erase_cursor
; ; 	pop af
; ; 	ld [wCurMenuItem], a
; ; 	ldh [hCurMenuItem], a
; ; 	xor a
; ; 	ld [wCursorBlinkCounter], a
; ; 	jr .blink_cursor
; ; .dpad_not_pressed
; ; 	ldh a, [hDPadHeld]
; ; 	and PAD_A
; ; 	jp nz, HandleMenuInput.A_pressed
; ; .blink_cursor
; ; 	; blink cursor every 16 frames
; ; 	ld hl, wCursorBlinkCounter
; ; 	ld a, [hl]
; ; 	inc [hl]
; ; 	and $f
; ; 	ret nz
; ; 	ld a, SYM_CURSOR_R
; ; 	bit 4, [hl]
; ; 	jr z, .draw_cursor
; ; .erase_cursor
; ; 	ld a, SYM_SPACE
; ; .draw_cursor
; ; 	ld e, a
; ; 	ld a, [wCurMenuItem]
; ; 	add a
; ; 	ld c, a
; ; 	ld b, $0
; ; 	ld hl, ProfileMenuCursorCoords
; ; 	add hl, bc
; ; 	ld b, [hl]
; ; 	inc hl
; ; 	ld c, [hl]
; ; 	ld a, e
; ; 	call WriteByteToBGMap0
; ; 	ld a, [wCurMenuItem]
; ; 	ld e, a
; ; 	or a
; ; 	ret

; ; ProfileMenuCursorCoords::
; ; 	db  2, 14 ; avatar
; ; 	db  2, 16 ; name


; ; .wait_A_or_B_loop
; ; 	call DoFrame
; ; 	; call RefreshMenuCursor
; ; 	ldh a, [hKeysPressed]
; ; 	and PAD_A | PAD_B
; ; 	jr z, .wait_A_or_B_loop


; 	ldtx hl, ChangeProfileText
; 	call TwoItemHorizontalMenu_cancel
; 	ret c

; 	ld a, [hCurMenuItem]
; 	or a
; 	jr z, .option1
; 	;option2
; 	ret
; .option1
;     farcall DisplayPlayerNamingScreen	
; 	ret

; 	; ldh a, [hCurMenuItem]
; 	; ldh [hTempList], a ; store selection in first position in list
; 	; or a
; 	; jr z, .turn_duelist	
