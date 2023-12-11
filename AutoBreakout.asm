; *****************************************
; ZX80 (4K ROM) Breakout - Autostart loader
; Dave Curran 2023-12-11
; *****************************************

; Autostart program header - https://problemkaputt.de/zxdocs.htm#zx80zx81cassettefilecontent

        .ORG    $4000
        .FILL   $08, $00                ; 4000h  8 x 00h          ;System area: Zerofilled stuff
        .WORD   $402C                   ; 4008h  402Ch            ;System area: Pointer to VARS
        .WORD   $413D                   ; 400Ah  nn3Dh            ;System area: Pointer to End of file
        .FILL   $1C, $00                ; 400Ch  1Ch x 00h        ;System area: Zerofilled stuff
        .BYTE   $00, $01, $65, $76      ; 4028h  00h,01h,65h,76h  ;BASIC program: Line 0001, LD H,L opcode, NEWLINE
        .BYTE   $80                     ; 402Ch  80h              ;VARS area: End code

; Setup the copy command in the padding before 4040
SETUP:  
        LD BC, $00EB                    ; Copy EB bytes
        LD HL, CODE                     ; From code
        LD DE, $4000                    ; To 4000
        
        JP     COPY                     ; jump to copy routine after data (to avoid being overwritten)

; Autostart entry point
        .ORG    $4040
        DI                              ; disable interrupts to stop drawing the screen until we are ready
        JR      SETUP                   ; setup to copy the program

; Code for 1K Breakout game, assembled to run from $4000, same as the original type in listing   
; Original version from Macronics - http://www.fruitcake.plus.com/Sinclair/ZX80/FlickerFree/ZX80_Breakout.htm
; OUT $FF,A at $405B changed from original OUT $FE,A to work with ZX80 BASIC on the Minstrel 4D as well as on ZX80s.

CODE:

	.BYTE	$72, $2B, $72, $2B, $72, $23, $23, $23, $72, $23, $72, $2B, $2B, $C9, $11, $20	; $4000 - $400F
	.BYTE	$00, $21, $00, $41, $3E, $80, $47, $77, $23, $10, $FC, $47, $36, $14, $23, $10	; $4010 - $401F
	.BYTE	$FB, $77, $23, $77, $23, $10, $FA, $21, $FF, $40, $06, $19, $36, $76, $19, $10	; $4020 - $402F
	.BYTE	$FB, $25, $2C, $0E, $01, $FD, $21, $DB, $40, $FD, $36, $22, $E6, $31, $FA, $40	; $4030 - $403F
	.BYTE	$D9, $21, $00, $25, $E5, $FD, $36, $23, $38, $E1, $2C, $E5, $DB, $FE, $7D, $E6	; $4040 - $404F
	.BYTE	$03, $28, $51, $FE, $02, $20, $1C, $06, $57, $10, $FE, $D3, $FF, $3E, $EC, $06	; $4050 - $405F
	.BYTE	$19, $21, $FF, $C0, $CD, $AD, $01, $3E, $F0, $04, $2B, $FD, $35, $23, $CD, $AD	; $4060 - $406F
	.BYTE	$01, $18, $D2, $FD, $6E, $22, $26, $43, $16, $80, $CD, $00, $40, $06, $E7, $0E	; $4070 - $407F
	.BYTE	$FE, $7D, $ED, $50, $CB, $52, $20, $05, $FE, $FC, $28, $01, $2C, $CB, $62, $20	; $4080 - $408F
	.BYTE	$05, $FE, $E2, $28, $01, $2D, $16, $03, $CD, $00, $40, $FD, $75, $22, $06, $3A	; $4090 - $409F
	.BYTE	$10, $FE, $18, $B7, $D9, $36, $80, $09, $19, $09, $7E, $A7, $ED, $42, $FE, $76	; $40A0 - $40AF
	.BYTE	$20, $07, $78, $2F, $47, $79, $2F, $3C, $4F, $7E, $19, $FE, $14, $28, $19, $7E	; $40B0 - $40BF
	.BYTE	$FE, $03, $28, $14, $7C, $FE, $40, $28, $0F, $A7, $ED, $52, $FE, $44, $20, $10	; $40C0 - $40CF
	.BYTE	$F1, $3D, $F5, $FE, $1B, $CA, $0E, $40, $7A, $2F, $57, $7B, $2F, $3C, $5F, $19	; $40D0 - $40DF
	.BYTE	$F1, $F5, $77, $D9, $06, $45, $10, $FE, $C3, $5B, $40 	                        ; $40E0 - $40EA

; actual copy command located after code 
COPY:
        LDIR                            ; Make it so

        JP $400E                        ; Jump to game entry point

; file padded to be $xx3D bytes long

        .ORG    $413C
        .BYTE   $80

        .END
