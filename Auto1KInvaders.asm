; ********************************************************************
; ZX80 (4K ROM) 1K Space Invaders / Space Intruders - Autostart loader
; Dave Curran 2023-12-11
; ********************************************************************

; Autostart program header - https://problemkaputt.de/zxdocs.htm#zx80zx81cassettefilecontent

        .ORG    $4000
        .FILL   $08, $00                ; 4000h  8 x 00h          ;System area: Zerofilled stuff
        .WORD   $402C                   ; 4008h  402Ch            ;System area: Pointer to VARS
        .WORD   $423D                   ; 400Ah  nn3Dh            ;System area: Pointer to End of file
        .FILL   $1C, $00                ; 400Ch  1Ch x 00h        ;System area: Zerofilled stuff
        .BYTE   $00, $01, $65, $76      ; 4028h  00h,01h,65h,76h  ;BASIC program: Line 0001, LD H,L opcode, NEWLINE
        .BYTE   $80                     ; 402Ch  80h              ;VARS area: End code

; Setup the copy command in the padding before $4040
SETUP:  
        LD BC, $01F0                    ; Copy $01F0 bytes
        LD HL, CODE                     ; From code
        LD DE, $4000                    ; To $4000
        
        JP      COPY                    ; jump to copy routine after data (to avoid being overwritten)

; Autostart entry point
        .ORG    $4040
        DI                              ; disable interrupts to stop drawing the screen until we are ready
        JR      SETUP                   ; setup to copy the program

; Code for 1K version of the Invaders game, assembled to run from $4000, same as the original type in listing   
; Original version from Macronics - http://www.fruitcake.plus.com/Sinclair/ZX80/FlickerFree/ZX80_SpaceIntruders_1K.htm
; OUT $FF,A at $4081 changed from original OUT $FE,A to work with ZX80 BASIC on the Minstrel 4D as well as on ZX80s.

CODE:

		.BYTE	$FD, $21, $DB, $41, $31, $FF, $43, $11, $1C, $1C, $D5, $11, $80, $80, $06, $2F	; $4000 - $400F
		.BYTE	$D5, $10, $FD, $21, $00, $00, $06, $10, $D5, $E5, $E5, $D5, $10, $FA, $06, $90	; $4010 - $401F
		.BYTE	$D5, $10, $FD, $11, $CB, $50, $D5, $E5, $E5, $E5, $E5, $11, $20, $00, $21, $FF	; $4020 - $402F
		.BYTE	$41, $06, $11, $36, $76, $19, $10, $FB, $2A, $E4, $40, $22, $E0, $43, $21, $FD	; $4030 - $403F
		.BYTE	$42, $0E, $08, $D9, $3E, $02, $21, $21, $42, $06, $04, $36, $07, $2C, $36, $01	; $4040 - $404F
		.BYTE	$2C, $36, $06, $2C, $2C, $2C, $2C, $10, $F2, $2E, $61, $3D, $20, $EB, $FD, $36	; $4050 - $405F
		.BYTE	$20, $08, $11, $20, $00, $0E, $80, $E1, $2C, $E5, $DB, $FE, $7D, $E6, $03, $28	; $4060 - $406F
		.BYTE	$25, $FE, $01, $28, $7A, $FE, $02, $CA, $66, $41, $FE, $03, $CA, $AD, $41, $10	; $4070 - $407F
		.BYTE	$FE, $D3, $FF, $3E, $ED, $06, $11, $21, $FF, $C1, $CD, $AD, $01, $3E, $EB, $04	; $4080 - $408F
		.BYTE	$2B, $CD, $AD, $01, $18, $CC, $D9, $7D, $E6, $20, $28, $05, $11, $FF, $FF, $18	; $4090 - $409F
		.BYTE	$04, $11, $01, $00, $7E, $7E, $0C, $0D, $28, $08, $A7, $ED, $52, $77, $19, $00	; $40A0 - $40AF
		.BYTE	$18, $08, $CB, $E9, $09, $77, $ED, $42, $0E, $00, $19, $7E, $FE, $76, $20, $E6	; $40B0 - $40BF
		.BYTE	$A7, $ED, $52, $A7, $ED, $52, $11, $E0, $FF, $19, $7C, $FE, $41, $20, $0C, $21	; $40C0 - $40CF
		.BYTE	$FD, $42, $0C, $0D, $20, $02, $0E, $09, $0D, $18, $04, $06, $03, $10, $FE, $D9	; $40D0 - $40DF
		.BYTE	$06, $55, $18, $9B, $1C, $1C, $2A, $FD, $43, $22, $E4, $40, $C3, $00, $40, $2A	; $40E0 - $40EF
		.BYTE	$F7, $41, $7C, $A7, $19, $7C, $28, $02, $FE, $44, $28, $0C, $7E, $A7, $28, $0B	; $40F0 - $40FF
		.BYTE	$FE, $0D, $28, $E2, $36, $94, $18, $07, $19, $18, $01, $71, $62, $C5, $C1, $22	; $4100 - $410F
		.BYTE	$F7, $41, $11, $E0, $FF, $2A, $F9, $41, $7C, $A7, $19, $7C, $28, $02, $FE, $41	; $4110 - $411F
		.BYTE	$28, $0F, $7E, $FE, $94, $28, $19, $A7, $28, $1A, $B9, $20, $1A, $36, $AE, $18	; $4120 - $412F
		.BYTE	$06, $06, $04, $10, $FE, $26, $00, $22, $F9, $41, $06, $3D, $10, $FE, $18, $A2	; $4130 - $413F
		.BYTE	$FD, $36, $1D, $00, $71, $18, $EE, $2D, $2D, $06, $05, $71, $2C, $10, $FC, $2A	; $4140 - $414F
		.BYTE	$FD, $43, $24, $7C, $FE, $26, $20, $03, $26, $1C, $2C, $22, $FD, $43, $FD, $35	; $4150 - $415F
		.BYTE	$20, $CA, $3E, $40, $18, $CF, $FD, $6E, $22, $26, $43, $71, $06, $E7, $0E, $FE	; $4160 - $416F
		.BYTE	$7D, $ED, $50, $CB, $52, $20, $07, $FE, $DC, $28, $01, $2C, $18, $03, $34, $35	; $4170 - $417F
		.BYTE	$00, $CB, $62, $20, $07, $FE, $C2, $28, $01, $2D, $18, $03, $34, $35, $00, $FD	; $4180 - $418F
		.BYTE	$75, $22, $36, $0D, $3A, $FA, $41, $A7, $20, $09, $CB, $42, $20, $07, $22, $F9	; $4190 - $419F
		.BYTE	$41, $18, $04, $7E, $7E, $C5, $C1, $06, $3E, $10, $FE, $18, $91, $2A, $F9, $41	; $41A0 - $41AF
		.BYTE	$71, $2A, $F7, $41, $71, $FD, $6E, $22, $26, $42, $19, $FD, $72, $21, $7E, $FE	; $41B0 - $41BF
		.BYTE	$01, $20, $11, $3A, $F8, $41, $A7, $20, $0E, $3A, $FC, $41, $A7, $20, $0D, $22	; $41C0 - $41CF
		.BYTE	$F7, $41, $18, $0F, $C5, $DD, $E1, $7E, $FE, $80, $20, $04, $18, $00, $18, $03	; $41D0 - $41DF
		.BYTE	$FD, $73, $21, $A7, $ED, $52, $7C, $FE, $41, $20, $D3, $06, $F1, $7E, $18, $BB	; $41E0 - $41EF

; actual copy command located after code 
COPY:
        LDIR                            ; Make it so

        JP $4000                        ; Jump to game entry point

; file padded to be $xx3D bytes long

        .ORG    $423C
        .BYTE   $80

        .END
