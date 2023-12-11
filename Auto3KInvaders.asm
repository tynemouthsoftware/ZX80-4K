; ********************************************************************
; ZX80 (4K ROM) 3K Space Invaders / Space Intruders - Autostart loader
; Dave Curran 2023-12-11
; ********************************************************************

; Autostart program header - https://problemkaputt.de/zxdocs.htm#zx80zx81cassettefilecontent

        .ORG     $4000
        .FILL   $08, $00                ; 4000h  8 x 00h          ;System area: Zerofilled stuff
        .WORD   $402C                   ; 4008h  402Ch            ;System area: Pointer to VARS
        .WORD   $433D                   ; 400Ah  nn3Dh            ;System area: Pointer to End of file
        .FILL   $1C, $00                ; 400Ch  1Ch x 00h        ;System area: Zerofilled stuff
        .BYTE   $00, $01, $65, $76      ; 4028h  00h,01h,65h,76h  ;BASIC program: Line 0001, LD H,L opcode, NEWLINE
        .BYTE   $80                     ; 402Ch  80h              ;VARS area: End code

; Autostart entry point
        .ORG     $4040
        DI                              ; disable interrupts to stop drawing the screen until we are ready
        JP      COPY                    ; jump to copy routine after data (to avoid being overwritten)

; Code for 3K version of the Invaders game, assembled to run from $4000, same as the original type in listing
; Original version from Macronics - http://www.fruitcake.plus.com/Sinclair/ZX80/FlickerFree/ZX80_SpaceIntruders_3K.htm
; OUT $FF,A at $40B0 changed from original OUT $FE,A to work with ZX80 BASIC on the Minstrel 4D as well as on ZX80s.

CODE:
		.BYTE	$31, $E0, $44, $FD, $21, $DB, $44, $FD, $36, $1A, $00, $FD, $36, $1C, $00, $FD	; $4000 - $400F
		.BYTE	$36, $21, $B2, $21, $00, $45, $3E, $80, $06, $00, $77, $23, $77, $23, $77, $23	; $4010 - $401F
		.BYTE	$10, $F8, $21, $E3, $46, $3E, $00, $06, $04, $77, $23, $77, $23, $77, $23, $77	; $4020 - $402F
		.BYTE	$23, $23, $23, $23, $10, $F3, $7D, $FE, $7F, $23, $23, $23, $23, $20, $E6, $00	; $4030 - $403F
		.BYTE	$11, $20, $00, $21, $FF, $44, $06, $19, $36, $76, $19, $10, $FB, $06, $04, $21	; $4040 - $404F
		.BYTE	$FB, $47, $36, $1C, $23, $10, $FB, $01, $04, $00, $21, $6C, $41, $11, $E0, $47	; $4050 - $405F
		.BYTE	$ED, $B0, $21, $BD, $46, $0E, $08, $D9, $11, $88, $08, $3E, $20, $21, $21, $45	; $4060 - $406F
		.BYTE	$CD, $D0, $40, $11, $04, $05, $3D, $2E, $61, $CD, $D0, $40, $11, $08, $88, $3D	; $4070 - $407F
		.BYTE	$2E, $A1, $CD, $D0, $40, $11, $06, $07, $3D, $2E, $E1, $CD, $D0, $40, $FD, $36	; $4080 - $408F
		.BYTE	$1D, $10, $FD, $36, $23, $30, $E1, $2C, $E5, $DB, $FE, $7D, $E6, $03, $CC, $10	; $4090 - $409F
		.BYTE	$41, $FE, $01, $CC, $70, $41, $FE, $02, $CC, $09, $42, $FE, $03, $CC, $5D, $42	; $40A0 - $40AF
		.BYTE	$D3, $FF, $3E, $ED, $06, $19, $21, $FF, $C4, $CD, $AD, $01, $3E, $F0, $04, $2B	; $40B0 - $40BF
		.BYTE	$FD, $35, $23, $CD, $AD, $01, $18, $CA, $00, $36, $80, $DD, $E1, $C3, $62, $40	; $40C0 - $40CF
		.BYTE	$06, $04, $72, $23, $77, $23, $73, $23, $23, $23, $23, $10, $F5, $C9, $06, $04	; $40D0 - $40DF
		.BYTE	$2D, $2D, $7E, $D6, $1C, $FA, $05, $41, $FE, $25, $F2, $05, $41, $11, $FE, $47	; $40E0 - $40EF
		.BYTE	$4F, $1A, $81, $FE, $26, $FA, $04, $41, $D6, $0A, $12, $0E, $01, $1D, $7B, $FE	; $40F0 - $40FF
		.BYTE	$FA, $20, $EE, $1C, $12, $36, $80, $2C, $10, $D8, $FD, $35, $1D, $28, $BA, $C9	; $4100 - $410F
		.BYTE	$D9, $7D, $E6, $20, $28, $05, $11, $FF, $FF, $18, $04, $11, $01, $00, $7E, $7E	; $4110 - $411F
		.BYTE	$FE, $08, $20, $05, $7E, $C6, $80, $18, $07, $FE, $88, $00, $20, $02, $C6, $80	; $4120 - $412F
		.BYTE	$0C, $0D, $28, $08, $A7, $ED, $52, $77, $19, $00, $18, $08, $CB, $E9, $09, $77	; $4130 - $413F
		.BYTE	$ED, $42, $0E, $00, $19, $7E, $FE, $76, $20, $D6, $A7, $ED, $52, $A7, $ED, $52	; $4140 - $414F
		.BYTE	$11, $E0, $FF, $19, $7C, $FE, $44, $20, $0C, $21, $BD, $46, $0C, $0D, $20, $02	; $4150 - $415F
		.BYTE	$0E, $09, $0D, $18, $04, $06, $03, $10, $FE, $D9, $00, $C9, $1C, $1C, $1C, $1C	; $4160 - $416F
		.BYTE	$11, $20, $00, $2A, $F4, $44, $7C, $19, $A7, $20, $06, $06, $04, $10, $FE, $18	; $4170 - $417F
		.BYTE	$2E, $FE, $47, $20, $0A, $7D, $FE, $BF, $38, $08, $C5, $C1, $D8, $18, $22, $7E	; $4180 - $418F
		.BYTE	$7E, $00, $7E, $A7, $28, $19, $CB, $BF, $FE, $0D, $20, $0F, $C1, $01, $04, $00	; $4190 - $419F
		.BYTE	$21, $FB, $47, $11, $6C, $41, $ED, $B0, $C3, $00, $40, $36, $94, $18, $07, $36	; $41A0 - $41AF
		.BYTE	$80, $62, $6A, $C5, $C1, $00, $22, $F4, $44, $2A, $F6, $44, $7C, $A7, $20, $06	; $41B0 - $41BF
		.BYTE	$06, $07, $10, $FE, $18, $1F, $ED, $52, $7C, $FE, $44, $20, $06, $DD, $29, $06	; $41C0 - $41CF
		.BYTE	$02, $18, $EF, $7E, $FE, $94, $20, $06, $FD, $36, $1A, $00, $18, $05, $DD, $29	; $41D0 - $41DF
		.BYTE	$A7, $20, $07, $36, $80, $6A, $62, $00, $18, $0F, $FE, $80, $28, $09, $CD, $DE	; $41E0 - $41EF
		.BYTE	$40, $36, $80, $26, $00, $18, $07, $36, $AE, $00, $06, $20, $10, $FE, $22, $F6	; $41F0 - $41FF
		.BYTE	$44, $7E, $06, $25, $10, $FE, $10, $FE, $C9, $FD, $6E, $21, $26, $47, $36, $80	; $4200 - $420F
		.BYTE	$06, $E7, $0E, $FE, $7D, $ED, $50, $CB, $52, $20, $07, $FE, $BC, $28, $01, $2C	; $4210 - $421F
		.BYTE	$18, $03, $34, $35, $00, $CB, $62, $20, $07, $FE, $A2, $28, $01, $2D, $18, $03	; $4220 - $422F
		.BYTE	$34, $35, $00, $FD, $75, $21, $36, $8D, $3A, $F7, $44, $A7, $28, $04, $23, $2B	; $4230 - $423F
		.BYTE	$18, $04, $36, $0D, $CB, $42, $20, $09, $CB, $AD, $36, $AE, $22, $F6, $44, $18	; $4240 - $424F
		.BYTE	$05, $34, $35, $DD, $29, $00, $06, $4B, $10, $FE, $10, $FE, $C9, $2A, $F6, $44	; $4250 - $425F
		.BYTE	$36, $80, $2A, $F4, $44, $36, $80, $11, $20, $00, $FD, $6E, $21, $26, $46, $FD	; $4260 - $426F
		.BYTE	$36, $20, $00, $7E, $D6, $1C, $CB, $7F, $20, $1B, $D6, $0A, $CB, $7F, $28, $17	; $4270 - $427F
		.BYTE	$3A, $F5, $44, $A7, $20, $14, $3A, $FB, $44, $A7, $20, $11, $19, $22, $F4, $44	; $4280 - $428F
		.BYTE	$A7, $ED, $52, $18, $17, $34, $35, $C5, $DD, $E1, $C5, $DD, $E1, $7E, $FE, $80	; $4290 - $429F
		.BYTE	$20, $04, $18, $00, $18, $04, $FD, $36, $20, $FF, $00, $00, $A7, $ED, $52, $7C	; $42A0 - $42AF
		.BYTE	$FE, $44, $20, $BF, $21, $BF, $46, $06, $1F, $23, $7E, $FE, $80, $C2, $9D, $41	; $42B0 - $42BF
		.BYTE	$10, $F7, $06, $19, $10, $FE, $C9												; $42C0 - $42C6

; copy routine located after code 
COPY:
        LD BC, $02C7                    ; Copy $02C7 bytes
        LD HL, CODE                     ; From CODE
        LD DE, $4000                    ; To $4000
        LDIR                            ; Make it so

        JP $4000                        ; Jump to game entry point

; file padded to be $xx3D bytes long

        .ORG     $433C
        .BYTE   $80

        .END

	