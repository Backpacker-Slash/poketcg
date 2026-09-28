; ; called at roughly 240Hz by TimerHandler
; SerialTimerHandler::
; 	ld a, [wSerialOp]
; 	cp $29
; 	jr z, .begin_transfer
; 	cp $12
; 	jr z, .check_for_timeout
; 	ret
; .begin_transfer
; 	ldh a, [rSC]         ;
; 	add a                ; make sure that no serial transfer is active
; 	ret c                ;
; 	ld a, SC_INTERNAL
; 	ldh [rSC], a         ; use internal clock
; 	ld a, SC_START | SC_INTERNAL
; 	ldh [rSC], a         ; use internal clock, set transfer start flag
; 	ret
; .check_for_timeout
; 	; sets bit7 of [wSerialFlags] if the serial interrupt hasn't triggered
; 	; within four timer interrupts (60Hz)
; 	ld a, [wSerialCounter]
; 	ld hl, wSerialCounter2
; 	cp [hl]
; 	ld [hl], a
; 	ld hl, wSerialTimeoutCounter
; 	jr nz, .clear_timeout_counter
; 	inc [hl]
; 	ld a, [hl]
; 	cp 4
; 	ret c
; 	ld hl, wSerialFlags
; 	set 7, [hl]
; 	ret
; .clear_timeout_counter
; 	ld [hl], $0
; 	ret

; Func_0cc5::
; 	ld hl, wSerialRecvCounter
; 	or a
; 	jr nz, .asm_cdc
; 	ld a, [hl]
; 	or a
; 	ret z
; 	ld [hl], $00
; 	ld a, [wSerialRecvBuf]
; 	ld e, $12
; 	cp $29
; 	jr z, .asm_cfa
; 	xor a
; 	scf
; 	ret
; .asm_cdc
; 	ld a, $29
; 	ldh [rSB], a
; 	ld a, SC_INTERNAL
; 	ldh [rSC], a
; 	ld a, SC_START | SC_INTERNAL
; 	ldh [rSC], a
; .asm_ce8
; 	ld a, [hl]
; 	or a
; 	jr z, .asm_ce8
; 	ld [hl], $00
; 	ld a, [wSerialRecvBuf]
; 	ld e, $29
; 	cp $12
; 	jr z, .asm_cfa
; 	xor a
; 	scf
; 	ret
; .asm_cfa
; 	xor a
; 	ld [wSerialSendBufIndex], a
; 	ld [wcb80], a
; 	ld [wSerialSendBufToggle], a
; 	ld [wSerialSendSave], a
; 	ld [WSerialbufferReadIndex], a
; 	ld [wSerialRecvIndex], a
; 	ld [wSerialRecvCounter], a
; 	ld [wSerialLastReadCA], a
; 	ld a, e
; 	cp $29
; 	jr nz, .asm_d21
; 	ld bc, $800
; .asm_d1b
; 	dec bc
; 	ld a, c
; 	or b
; 	jr nz, .asm_d1b
; 	ld a, e
; .asm_d21
; 	ld [wSerialOp], a
; 	scf
; 	ret

SerialHandler::
	ret
; 	push af
; 	push hl
; 	push de
; 	push bc
; 	ld a, [wPrinterPacketSequence] ;
; 	or a                           ;
; 	; jr z, .not_printer_sequence    ; if [wPrinterPacketSequence] nonzero:
; 	; call ExecutePrinterPacketSequence
; 	; jr .done                       ; return
; .not_printer_sequence
; 	ld a, [wSerialOp]    ;
; 	or a                 ;
; 	jr z, .asm_d55       ; skip ahead if [wSerialOp] zero
; 	; send/receive a byte
; 	ldh a, [rSB]
; 	call SerialHandleRecv
; 	call SerialHandleSend ; returns byte to actually send
; 	push af
; .wait_for_completion
; 	ldh a, [rSC]
; 	add a
; 	jr c, .wait_for_completion
; 	pop af
; 	; end send/receive
; 	ldh [rSB], a         ; prepare sending byte (from Func_0dc8?)
; 	ld a, [wSerialOp]
; 	cp $29
; 	jr z, .done          ; if [wSerialOp] != $29, use external clock
; 	jr .asm_d6a          ; and prepare for next byte. either way, return
; .asm_d55
; 	ld a, $1
; 	ld [wSerialRecvCounter], a
; 	ldh a, [rSB]
; 	ld [wSerialRecvBuf], a
; 	ld a, $ac
; 	ldh [rSB], a
; 	ld a, [wSerialRecvBuf]
; 	cp $12               ; if [wSerialRecvBuf] != $12, use external clock
; 	jr z, .done          ; and prepare for next byte. either way, return
; .asm_d6a
; 	ld a, SC_START | SC_EXTERNAL
; 	ldh [rSC], a         ; transfer start, use external clock
; .done
; 	ld hl, wSerialCounter
; 	inc [hl]
; 	pop bc
; 	pop de
; 	pop hl
; 	pop af
; 	reti

; handles a byte read from serial transfer by decoding it and storing it into
; the receive buffer
; SerialHandleRecv::
; 	ld hl, wSerialLastReadCA
; 	ld e, [hl]
; 	dec e
; 	jr z, .last_was_ca
; 	cp $ac
; 	ret z ; return if read_data == $ac
; 	cp $ca
; 	jr z, .read_ca
; 	or a
; 	jr z, .read_00_or_ff
; 	cp $ff
; 	jr nz, .read_data
; .read_00_or_ff
; 	ld hl, wSerialFlags
; 	set 6, [hl]
; 	ret
; .read_ca
; 	inc [hl] ; inc [wSerialLastReadCA]
; 	ret
; .last_was_ca
; 	; if last byte read was $ca, flip all bits of data received
; 	ld [hl], $0
; 	cpl
; 	jr .handle_byte
; .read_data
; 	; flip top2 bits of data received
; 	xor $c0
; .handle_byte
; 	push af
; 	ld a, [wSerialRecvIndex]
; 	ld e, a
; 	ld a, [WSerialbufferReadIndex]
; 	dec a
; 	and $1f
; 	cp e
; 	jr z, .set_flag_and_return
; 	ld d, $0
; 	; store into receive buffer
; 	ld hl, wSerialRecvBuf
; 	add hl, de
; 	pop af
; 	ld [hl], a
; 	; increment buffer index (mod 32)
; 	ld a, e
; 	inc a
; 	and $1f
; 	ld [wSerialRecvIndex], a
; 	; increment received bytes counter & clear flags
; 	ld hl, wSerialRecvCounter
; 	inc [hl]
; 	xor a
; 	ld [wSerialFlags], a
; 	ret
; .set_flag_and_return
; 	pop af
; 	ld hl, wSerialFlags
; 	set 0, [hl]
; 	ret

; ; prepares a byte to send over serial transfer, either from the send-save byte
; ; slot or the send buffer
; SerialHandleSend::
; 	ld hl, wSerialSendSave
; 	ld a, [hl]
; 	or a
; 	jr nz, .send_saved
; 	ld hl, wSerialSendBufToggle
; 	ld a, [hl]
; 	or a
; 	jr nz, .send_buf
; 	; no more data--send $ac to indicate this
; 	ld a, $ac
; 	ret
; .send_saved
; 	ld a, [hl]
; 	ld [hl], $0
; 	ret
; .send_buf
; 	; grab byte to send from send buffer, increment buffer index
; 	; and decrement to-send length
; 	dec [hl]
; 	ld a, [wSerialSendBufIndex]
; 	ld e, a
; 	ld d, $0
; 	ld hl, wSerialSendBuf
; 	add hl, de
; 	inc a
; 	and $1f
; 	ld [wSerialSendBufIndex], a
; 	ld a, [hl]
; 	; flip top2 bits of sent data
; 	xor $c0
; 	cp $ac
; 	jr z, .send_escaped
; 	cp $ca
; 	jr z, .send_escaped
; 	cp $ff
; 	jr z, .send_escaped
; 	or a
; 	jr z, .send_escaped
; 	ret
; .send_escaped
; 	; escape tricky data by prefixing it with $ca and flipping all bits
; 	; instead of just top2
; 	xor $c0
; 	cpl
; 	ld [wSerialSendSave], a
; 	ld a, $ca
; 	ret

; ; store byte at a in wSerialSendBuf for sending
; SerialSendByte::
; 	push hl
; 	push de
; 	push bc
; 	push af
; .asm_e0e
; 	ld a, [wcb80]
; 	ld e, a
; 	ld a, [wSerialSendBufIndex]
; 	dec a
; 	and $1f
; 	cp e
; 	jr z, .asm_e0e
; 	ld d, $0
; 	ld a, e
; 	inc a
; 	and $1f
; 	ld [wcb80], a
; 	ld hl, wSerialSendBuf
; 	add hl, de
; 	pop af
; 	ld [hl], a
; 	ld hl, wSerialSendBufToggle
; 	inc [hl]
; 	pop bc
; 	pop de
; 	pop hl
; 	ret

; return in a byte in wSerialRecvBuf 
; return c, if data is not ready yet
; resets wSerialRecvCounter to 0
SerialRecvByte::
    ld a, [wSerialRecvCounter]
	or a
	jr z, .no_data

    ; packet is available
	xor a
	ld [wSerialRecvCounter], a
	ld a, PACKET_CONSUMED
	ld [wSerialRecvState], a
	ld a, [wSerialRecvBuf]
	or a
	ret 

.no_data
	scf
	ret

; store byte at a in wSerialSendBuf for sending
SerialSendByte::
    ld [wSerialSendBuf], a
	push af
    ld a, 1
    ld [wSerialSendBufToggle], a

	call wait_byte_exchange
	pop af
	ret
	
; sets carry if [wSerialRecvCounter] nonzero
Check_SerialRecvCounter::
	ld a, [wSerialRecvCounter]
	or a
	ret z
	scf
	ret

; serial send 8 bytes at f, a, l, h, e, d, c, b
; only during a duel against a link opponent
SerialSend8Bytes::
	push hl
	push af
	ld a, DUELVARS_DUELIST_TYPE
	call GetNonTurnDuelistVariable
	cp DUELIST_TYPE_LINK_OPP
	jr z, .link
	pop af
	pop hl
	ret

.link
	pop af
	pop hl
	push af
	push hl
	push de
	push bc
	push de
	push hl
	push af
	ld hl, wTempSerialBuf
	pop de
	ld [hl], e
	inc hl
	ld [hl], d
	inc hl
	pop de
	ld [hl], e
	inc hl
	ld [hl], d
	inc hl
	pop de
	ld [hl], e
	inc hl
	ld [hl], d
	inc hl
	ld [hl], c
	inc hl
	ld [hl], b
	ld hl, wTempSerialBuf
	ld bc, 8

	call SerialSendBytes

	call wait_byte_exchange

	; jp c, DuelTransmissionError
	pop bc
	pop de
	pop hl
	pop af
	ret

wait_byte_exchange::
	push af
	ld a, [wDuelType]
	cp DUELTYPE_LINK
	jr z, .confirm_received
	pop af
	ret

.confirm_received	
	ld a, [wSerialSendState]
	cp PACKET_RECEIVED_BY_OPP
	jr z, .done
	call DoFrame
	jr .confirm_received

.done	
	;package idle is set by JS
	xor a ;ld a, PACKET_IDLE
	ld [wSerialSendState], a
	pop af
	ret

; serial recv 8 bytes to f, a, l, h, e, d, c, b
SerialRecv8Bytes::
	ld hl, wTempSerialBuf
	ld bc, 8
	push hl
	call SerialRecvBytes
	; jp c, DuelTransmissionError
	pop hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push de
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push de
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld c, [hl]
	inc hl
	ld b, [hl]
	pop hl
	pop af
	ret

; 	push hl
; 	ld bc, 1
; 	call SerialRecvBytes
; 	ret

; 	ld BC, $1
; 	push hl
; 	ld hl, wSerialRecvCounter
; 	ld a, [hl]
; 	or a
; 	jr nz, .data_found
; 	pop hl
; 	; ld a, [wSerialFlags]
; 	; or a
; 	; ret nz
; 	scf
; 	ret
; .data_found
; 	ld 

	; push de
	; dec [hl]
	; ld a, [WSerialbufferReadIndex]
	; ld e, a
	; ld d, $0
	; ld hl, wSerialRecvBuf
	; add hl, de
	; ld a, [hl]
	; push af
	; ld a, e
	; inc a
	; and $1f
	; ld [WSerialbufferReadIndex], a
	; pop af
	; pop de
	; pop hl
	; or a
	; ret

; ; exchange c bytes. send bytes at hl and store received bytes in de
; SerialExchangeBytes::
; 	ld b, c
; .asm_e64
; 	ld a, b
; 	sub c
; 	jr c, .asm_e6c
; 	cp $1f
; 	jr nc, .asm_e75
; .asm_e6c
; 	inc c
; 	dec c
; 	jr z, .asm_e75
; 	ld a, [hli]
; 	call SerialSendByte
; 	dec c
; .asm_e75
; 	inc b
; 	dec b
; 	jr z, .asm_e81
; 	call SerialRecvByte
; 	jr c, .asm_e81
; 	ld [de], a
; 	inc de
; 	dec b
; .asm_e81
; 	ld a, [wSerialFlags]
; 	or a
; 	jr nz, .asm_e8c
; 	ld a, c
; 	or b
; 	jr nz, .asm_e64
; 	ret
; .asm_e8c
; 	scf
; 	ret

; ==============================================================================
; SerialSendBytes // HL to wSerialSendBuf // c to wSerialSendBufToggle // Does not wait //
; Queue BC bytes from HL as ONE packet for the external transport.
;
; wSerialSendBuf       = packet data
; wSerialSendBufToggle = packet length / pending flag
;
; JS reads wSerialSendBufToggle > 0 as package ready and sends wSerialSendBuf & wSerialSendBufToggle to peer
; The JS transport sends the packet and clears the toggle.
; ==============================================================================
SerialSendBytes::
    push bc
    push de

    ld de, wSerialSendBuf

.copy
    ld a, [hli]
    ld [de], a
    inc de

    dec bc
    ld a, b
    or c
    jr nz, .copy

    pop de
    pop bc
	ld b, $0
    ; Reset send state to PACKET_IDLE before signaling new packet
    xor a
    ld [wSerialSendState], a
    ; Signal packet ready.
    ; BC still contains original packet length.
    ld a, c
    ld [wSerialSendBufToggle], a

    ret

; ==============================================================================
; SerialExchangeBytes
; Exchanges 'c' bytes. Sends 'c' bytes from [hl] and writes received bytes to [de].
; ==============================================================================
SerialExchangeBytes::
    ; push bc 
    ; push de
    push hl

    ; --- PHASE 1: QUEUE OUTGOING PACKET ONCE ---
; .send_loop
;     ld a, [hli]
;     call SerialSendByte
;     dec c
;     jr nz, .send_loop

	call SerialSendBytes

; .confirm_received	
; 	ld a, [wSerialFlags]
; 	cp PACKET_RECEIVED_BY_OPP
; 	jr z, .done
; 	call DoFrame
; 	jr .confirm_received

; .done	
; 	xor a ;ld a, PACKET_IDLE
; 	ld [wSerialFlags], a
	pop hl
    ; pop de
    ; pop bc

    ; --- PHASE 2: RECEIVE PACKET SMOOTHLY ---
    push de
    pop hl              ; hl = destination buffer (de)
    ; ld b, $00           ; bc = length (c) 
    ;fallthrough ;jp SerialRecvBytes  ; jump directly into smooth receive loop


; ==============================================================================
; SerialRecvBytes
; Receives 'bc' bytes into [hl]. Calls DoFrame while waiting for network packets.
    ; BC = expected packet length
    ; HL = destination
; ==============================================================================
SerialRecvBytes::
	push bc
	push de
;waiting for JS package to arrive	
; when JS serial_packet received, it fills wSerialRecvBuf and sets wSerialRecvCounter to incoming wSerialSendBufToggle
.wait
    ld a, [wSerialRecvCounter]
    ; cp c
	or a
    jr z, .wait_DoFrame ; no package yet

    ; packet is available
    ld de, wSerialRecvBuf

.copy
    ld a, [de]
    ld [hli], a
    inc de

    dec bc
    ld a, b
    or c
    jr nz, .copy

    xor a
    ld [wSerialRecvCounter], a

	ld a, PACKET_CONSUMED
	ld [wSerialRecvState], a	
	pop de
	pop bc
	ret

.wait_DoFrame
    call DoFrame
	jr .wait



;     push bc
; .recv_loop
;     call SerialRecvByte
;     jr nc, .save_byte

;     ; No data ready yet: yield 1 frame to keep engine rendering smoothly at 60 FPS
;     push bc
;     push hl
;     call DoFrame
;     pop hl
;     pop bc
;     jr .recv_loop

; .save_byte
;     ld [hli], a
;     ld a, [wSerialFlags]
;     or a
;     jr nz, .done
;     dec bc
;     ld a, c
;     or b
;     jr nz, .recv_loop
;     pop bc
;     or a
;     ret

; .done
;     pop bc
;     scf
;     ret	


; ; go into slave mode (external clock) for serial transfer?
; Func_0e8e::
; 	call ClearSerialData
; 	ld a, $12
; 	ldh [rSB], a         ; send $12
; 	ld a, SC_START | SC_EXTERNAL
; 	ldh [rSC], a         ; use external clock, set transfer start flag
; 	ldh a, [rIF]
; 	and ~IE_SERIAL
; 	ldh [rIF], a         ; clear serial interrupt flag
; 	ldh a, [rIE]
; 	or IE_SERIAL         ; enable serial interrupt
; 	ldh [rIE], a
; 	ret

; disable serial interrupt, and clear rSB, rSC, and serial registers in WRAM
ResetSerial::
	; ldh a, [rIE]
	; and ~IE_SERIAL
	; ldh [rIE], a
	; xor a
	; ldh [rSB], a
	; ldh [rSC], a
;	fallthrough

; zero serial registers in WRAM
ClearSerialData::
	ld hl, wSerialOp
	ld bc, wSerialEnd - wSerialOp
.loop
	xor a
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, .loop
	ret

; ; store bc bytes from hl in wSerialSendBuf for sending
; SerialSendBytes::
; 	push bc
; .send_loop
; 	ld a, [hli]
; 	call SerialSendByte
; 	ld a, [wSerialFlags]
; 	or a
; 	jr nz, .done
; 	dec bc
; 	ld a, c
; 	or b
; 	jr nz, .send_loop
; 	pop bc
; 	or a
; 	ret
; .done
; 	pop bc
; 	scf
; 	ret


; ; receive bc bytes in wSerialRecvBuf and save them to hl
; SerialRecvBytes::
; 	push bc
; .recv_loop
; 	call SerialRecvByte
; 	jr nc, .save_byte
; 	halt
; 	nop
; 	jr .recv_loop
; .save_byte
; 	ld [hli], a
; 	ld a, [wSerialFlags]
; 	or a
; 	jr nz, .done
; 	dec bc
; 	ld a, c
; 	or b
; 	jr nz, .recv_loop
; 	pop bc
; 	or a
; 	ret
; .done
; 	pop bc
; 	scf
; 	ret

; Func_0ef1::
; 	ld de, wcb79
; 	ld hl, sp+$fe
; 	ld a, l
; 	ld [de], a
; 	inc de
; 	ld a, h
; 	ld [de], a
; 	inc de
; 	pop hl
; 	push hl
; 	ld a, l
; 	ld [de], a
; 	inc de
; 	ld a, h
; 	ld [de], a
; 	or a
; 	ret

; Func_0f05::
; 	push hl
; 	ld hl, wcb7b
; 	ld a, [hli]
; 	or [hl]
; 	pop hl
; 	ret z
; 	ld hl, wcb79
; 	ld a, [hli]
; 	ld h, a
; 	ld l, a
; 	ld sp, hl
; 	ld hl, wcb7b
; 	ld a, [hli]
; 	ld h, [hl]
; 	ld l, a
; 	push hl
; 	scf
; 	ret

; frame function during Link Opponent's turn
; if opponent makes a decision, jump directly
; to the address in wLinkOpponentTurnReturnAddress
LinkOpponentTurnFrameFunction::
	; ld a, [wSerialFlags]
	; or a
	; jr nz, .return
	call Check_SerialRecvCounter
	ret nc
.return
	ld a, $01
	call BankswitchROM
	ld hl, wLinkOpponentTurnReturnAddress
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld sp, hl
	scf
	ret

; load the number at wSerialFlags (error code?) to TxRam3, print
; TransmissionErrorText, exit the duel, and reset serial registers.
DuelTransmissionError::
	; ld a, [wSerialFlags]
	; ld l, a
	; ld h, 0
	; call LoadTxRam3
	; ldtx hl, TransmissionErrorText
	; call DrawWideTextBox_WaitForInput
	; ld a, -1
	; ld [wDuelResult], a
	; ld hl, wDuelReturnAddress
	; ld a, [hli]
	; ld h, [hl]
	; ld l, a
	; ld sp, hl
	; xor a ; MUSIC_STOP
	; call PlaySong
	; call ResetSerial
	ret

; exchange RNG during a link duel between both games
; Synchronized cleanly via WebRTC / JavaScript transport
ExchangeRNG::
	ret

; sets hOppActionTableIndex to an AI action specified in register a.
; send 10 bytes of data to the other game from hOppActionTableIndex, hTempCardIndex_ff9f,
; hTemp_ffa0, and hTempPlayAreaLocation_ffa1, and hTempRetreatCostCards.
; finally exchange RNG data.
; the receiving side will use this data to read the OPPACTION_* value in
; [hOppActionTableIndex] and match it by calling the corresponding OppAction* function
SetOppAction_SerialSendDuelData::
	push hl
	push bc
	ldh [hOppActionTableIndex], a
	ld a, DUELVARS_DUELIST_TYPE
	call GetNonTurnDuelistVariable
	cp DUELIST_TYPE_LINK_OPP
	jr nz, .not_link
	ld hl, hOppActionTableIndex
	ld bc, 10
	call SerialSendBytes
	call wait_byte_exchange
.not_link
	pop bc
	pop hl
	ret

; receive 10 bytes of data from wSerialRecvBuf and store them into hOppActionTableIndex,
; hTempCardIndex_ff9f, hTemp_ffa0, and hTempPlayAreaLocation_ffa1,
; and hTempRetreatCostCards. also exchange RNG data.
SerialRecvDuelData::
	push hl
	push bc
	ld hl, hOppActionTableIndex
	ld bc, 10
	call SerialRecvBytes
	pop bc
	pop hl
	ret
