;------------------------------------------------------------------------- KHALIF
system_port_a:  EQU	10H
system_port_b:  EQU	11H
system_port_C:  EQU	12H	
CTRLR:		EQU	13H
	
		ORG	802CH		; RST 5.5
		JMP	ISR_5_5

		ORG	8034H		; RST 6.5
		JMP	ISR_6_5

		ORG	803CH		; RST 7.5
		JMP	ISR_7_5
		
		ORG	8100H
		LXI	SP,0F000H

		MVI 	A, 00001100B	;set mask 
		SIM    			;Set interrupt masking
		EI			;Enable interrupt

		MVI	A,90H ;10010000B -SET PORT A AS INPUT AND PORT B C AS OUTPUT
		OUT	CTRLR



START:		MVI	E, 07H		;INITIATE LCD
		RST	1
		CALL	dlyz
		MVI	E, 09H		;CLEAR LCD
		RST	1
		CALL	dlyz
		CALL	dlyz
		
main:		
		call 	clr7	
		LXI	H, 0000H	;----1STLINE
		MVI	E, 0AH		;GOTO_XY LCD
		RST	1
		LXI	H, MAIN1
		MVI	E, 0BH		;PUTSTRING AT LCD
		RST	1

		LXI	H, 0401H	;----2NDLINE
		MVI	E, 0AH		
		RST	1
		LXI	H, MAIN50
		MVI	E, 0BH		
		RST	1

		LXI	H, 0402H	;----3RDLINE
		MVI	E, 0AH		
		RST	1
		LXI	H, MAIN20
		MVI	E, 0BH		
		RST	1

		LXI	H, 0403H	;----4THLINE
		MVI	E, 0AH		
		RST	1
		LXI	H, MAIN10
		MVI	E, 0BH		
		RST	1
		
meno:			
		mvi	h,00h
		mvi	l,07h
		shld	ctr
		call	scan 
		lda 	key
		cpi	010	;button '1'
		cz	main2	;jump to subroutine main2 when "1" is pressed
		cpi	12h	;button '2'
		cz	main3	;jump to subroutine main3 when "2" is pressed
		cpi	1ah	;button '3'
		cz	main4	;jump to subroutine main4 when "3" is pressed
		jmp	meno

;-------------------------------------------------------------------------

;------------------------------------------------------------------------- 
kosong:		call	clr7
		call	DISPSEVSEG
main2:;50cent	
		;MVI	A,0
		;STA	GP
		;LDA 	GP
		;INR	A
		;STA	GP
		
		mvi	h,00h
		mvi	l,07h
		shld	ctr
		call	scan 
		lda 	key
		cpi	02
		cz	main
		cpi	1DH
		cz	R5

		MVI	E, 07H
		RST	1
		CALL	dlyz
		MVI	E, 09H
		RST	1
		CALL	dlyz
		
		LXI	H, 0500H	;----1stLINE
		MVI	E, 0AH		
		RST	1
		LXI	H, UNIVERSAL
		MVI	E, 0BH		
		RST	1

		LXI	H, 0501H	;----LINE2ND
		MVI	E, 0AH		
		RST	1
		LXI	H, FIFTY
		MVI	E, 0BH		
		RST	1
		

RES0:	MVI 	A, 00001100B	;set mask 
	SIM    			;Set interrupt masking
	EI

	LXI	H, 0500H	;----2NDLINE
	MVI	E, 0AH		
	RST	1
	LXI	H, UNIVERSAL
	MVI	E, 0BH		
	RST	1

	LXI	H, 0501H	;----3RDLINE
	MVI	E, 0AH		
	RST	1
	LXI	H, FIFTY
	MVI	E, 0BH		
	RST	1

	LDA	BUFFER+5
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT+5
	CALL	DISPSEVSEG
	CALL	DLY


	CALL	DISPSEVSEG
	LDA	BUFFER+4
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT+4
	CALL	DISPSEVSEG
	CALL	DLY


	CALL	DISPSEVSEG
	LDA	BUFFER+3
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT+3
	CALL	DISPSEVSEG
	CALL	DLY

	CALL	DISPSEVSEG
	LDA	BUFFER+2
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT+2
	CALL	DISPSEVSEG
	CALL	DLY


	CALL	DISPSEVSEG
	LDA	BUFFER+1
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT+1
	CALL	DISPSEVSEG
	CALL	DLY


	CALL	DISPSEVSEG
	LDA	BUFFER
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT
	CALL	DISPSEVSEG
	CALL	DLY

	CALL	DISPSEVSEG
	CALL	GPIO


	LDA	BUFFER+5
	INR	A
	STA	BUFFER+5
	CPI	10
	jnz	RES0
	CALL	NEW1
	LDA	BUFFER+4
	INR	A
	STA	BUFFER+4
	CPI	10
	jnz	RES0
	CALL 	NEW2
	LDA	BUFFER+3
	INR	A
	STA	BUFFER+3
	CPI	10
	jnz	RES0
	CALL 	NEW3
	LDA	BUFFER+2
	INR	A
	STA	BUFFER+2
	CPI	10
	jnz	RES0
	CALL 	NEW4
	LDA	BUFFER+1
	INR	A
	STA	BUFFER+1
	CPI	10
	jnz	RES0
	CALL 	NEW5
	LDA	BUFFER
	INR	A
	STA	BUFFER
	CPI	10
	jnz	RES0
	CALL 	NEW6
	


	JMP	kosong

;--------------------------------------------------------------------

kosong2:	call	clr7
		call	DISPSEVSEG
main3:	;20cent
		MVI	E, 07H
		RST	1
		CALL	dlyz
		MVI	E, 09H
		RST	1
		CALL	dlyz
		
		mvi	h,00h
		mvi	l,07h
		shld	ctr
		call	scan 
		lda 	key
		cpi	02
		cz	main

		LXI	H, 0500H	;----2NDLINE
		MVI	E, 0AH		
		RST	1
		LXI	H, UNIVERSAL
		MVI	E, 0BH		
		RST	1

		LXI	H, 0501H	;----3RDLINE
		MVI	E, 0AH		
		RST	1
		LXI	H, TWENTY
		MVI	E, 0BH		
		RST	1

		call	dlyz


RES1:	MVI 	A, 00001100B	;set mask 
	SIM    			;Set interrupt masking
	EI

	LXI	H, 0500H	;----2NDLINE
	MVI	E, 0AH		
	RST	1
	LXI	H, UNIVERSAL
	MVI	E, 0BH		
	RST	1

	LXI	H, 0501H	;----3RDLINE
	MVI	E, 0AH		
	RST	1
	LXI	H, TWENTY
	MVI	E, 0BH		
	RST	1
	mvi	h,00h
	mvi	l,07h
	shld	ctr
	call	scan 
	lda 	key
	cpi	1DH
	cz	R5

	LDA	BUFFER+5
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT+5
	CALL	DISPSEVSEG
	CALL	DLY


	CALL	DISPSEVSEG
	LDA	BUFFER+4
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT+4
	CALL	DISPSEVSEG
	CALL	DLY


	CALL	DISPSEVSEG
	LDA	BUFFER+3
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT+3
	CALL	DISPSEVSEG
	CALL	DLY

	CALL	DISPSEVSEG
	LDA	BUFFER+2
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT+2
	CALL	DISPSEVSEG
	CALL	DLY


	CALL	DISPSEVSEG
	LDA	BUFFER+1
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT+1
	CALL	DISPSEVSEG
	CALL	DLY


	CALL	DISPSEVSEG
	LDA	BUFFER
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT
	CALL	DISPSEVSEG
	CALL	DLY

	
	CALL	DISPSEVSEG
	CALL	GPIO

	LDA	BUFFER+5
	INR	A
	STA	BUFFER+5
	CPI	10
	CNZ	RES1
	CALL	NEW1
	LDA	BUFFER+4
	INR	A
	STA	BUFFER+4
	CPI	10
	CNZ	RES1
	CALL 	NEW2
	LDA	BUFFER+3
	INR	A
	STA	BUFFER+3
	CPI	10
	CNZ	RES1
	CALL 	NEW3
	LDA	BUFFER+2
	INR	A
	STA	BUFFER+2
	CPI	10
	CNZ	RES1
	CALL 	NEW4
	LDA	BUFFER+1
	INR	A
	STA	BUFFER+1
	CPI	10
	CNZ	RES1
	CALL 	NEW5
	LDA	BUFFER
	INR	A
	STA	BUFFER
	CPI	10
	CNZ	RES1
	CALL 	NEW6
	
	MVI 	A, 00001100B	;set mask 
		SIM    			;Set interrupt masking
		EI

	JMP	kosong2

kosong4:	call	clr7
		call	DISPSEVSEG
main4:	;10cent
		MVI	E, 07H
		RST	1
		CALL	dlyz
		MVI	E, 09H
		RST	1
		CALL	dlyz
		
		mvi	h,00h
		mvi	l,07h
		shld	ctr
		call	scan 
		lda 	key
		cpi	02
		cz	main

		LXI	H, 0500H	;----2NDLINE
		MVI	E, 0AH		
		RST	1
		LXI	H, UNIVERSAL
		MVI	E, 0BH		
		RST	1

		LXI	H, 0501H	;----3RDLINE
		MVI	E, 0AH		
		RST	1
		LXI	H, TEN
		MVI	E, 0BH		
		RST	1

		call	dlyz

RES4:	MVI 	A, 00001100B	;set mask 
	SIM    			;Set interrupt masking
	EI

	LXI	H, 0500H	;----2NDLINE
	MVI	E, 0AH		
	RST	1
	LXI	H, UNIVERSAL
	MVI	E, 0BH		
	RST	1

	LXI	H, 0501H	;----3RDLINE
	MVI	E, 0AH		
	RST	1
	LXI	H, TEN
	MVI	E, 0BH		
	RST	1
	LDA	BUFFER+5
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT+5
	CALL	DISPSEVSEG
	CALL	DLY


	CALL	DISPSEVSEG
	LDA	BUFFER+4
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT+4
	CALL	DISPSEVSEG
	CALL	DLY


	CALL	DISPSEVSEG
	LDA	BUFFER+3
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT+3
	CALL	DISPSEVSEG
	CALL	DLY

	CALL	DISPSEVSEG
	LDA	BUFFER+2
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT+2
	CALL	DISPSEVSEG
	CALL	DLY


	CALL	DISPSEVSEG
	LDA	BUFFER+1
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT+1
	CALL	DISPSEVSEG
	CALL	DLY


	CALL	DISPSEVSEG
	LDA	BUFFER
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT
	CALL	DISPSEVSEG
	CALL	DLY

	CALL	DISPSEVSEG
	CALL	GPIO


	LDA	BUFFER+5
	INR	A
	STA	BUFFER+5
	CPI	9
	jnz	RES4
	CALL	NEW1
	LDA	BUFFER+4
	INR	A
	STA	BUFFER+4
	CPI	9
	jnz	RES4
	CALL 	NEW2
	LDA	BUFFER+3
	INR	A
	STA	BUFFER+3
	CPI	9
	jnz	RES4
	CALL 	NEW3
	LDA	BUFFER+2
	INR	A
	STA	BUFFER+2
	CPI	9
	jnz	RES4
	CALL 	NEW4
	LDA	BUFFER+1
	INR	A
	STA	BUFFER+1
	CPI	9
	jnz	RES4
	CALL 	NEW5
	LDA	BUFFER
	INR	A
	STA	BUFFER
	CPI	9
	jnz	RES4
	CALL 	NEW6
	


	JMP	kosong4


clr7:	
	call	NEW1
	call	NEW2
	call	NEW3
	call	NEW4
	call	NEW5
	call	NEW6


	LDA	BUFFER+5
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT+5
	CALL	DISPSEVSEG
	CALL	DLY


	CALL	DISPSEVSEG
	LDA	BUFFER+4
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT+4
	CALL	DISPSEVSEG
	CALL	DLY


	CALL	DISPSEVSEG
	LDA	BUFFER+3
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT+3
	CALL	DISPSEVSEG
	CALL	DLY

	CALL	DISPSEVSEG
	LDA	BUFFER+2
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT+2
	CALL	DISPSEVSEG
	CALL	DLY


	CALL	DISPSEVSEG
	LDA	BUFFER+1
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT+1
	CALL	DISPSEVSEG
	CALL	DLY


	CALL	DISPSEVSEG
	LDA	BUFFER
	LXI	H,SEVSEGDATA
	MVI	D,0
	MOV	E,A
	DAD	D
	MOV	A,M
	STA	DIGIT
	CALL	DISPSEVSEG
	CALL	DLY

	CALL	DISPSEVSEG

	ret

;------------------------------------------------------------------

DISPSEVSEG:
	MVI	C,00H      ; DIG0
	MOV	A,C
	ORI	0F0H
	OUT	system_port_c
	LDA	DIGIT;0
	OUT	system_port_b
	CALL	DLY
	MVI	A,0
	OUT 	system_port_b
	;CALL	DLY

	MVI	C,01H     ;DIG1
	MOV	A,C
	ORI	0F0H
	OUT	system_port_c
	LDA	DIGIT+1;1
	OUT	system_port_b
	CALL	DLY
	MVI	A,0
	OUT 	system_port_b
	;CALL	DLY

	MVI	C,02H      ;DIG2
	MOV	A,C
	ORI	0F0H
	OUT	system_port_c
	LDA	DIGIT+2;2
	OUT	system_port_b
	CALL	DLY
	MVI	A,0
	OUT 	system_port_b
	;CALL	DLY

	MVI	C,03H	   ;DIG3
	MOV	A,C
	ORI	0F0H
	OUT	system_port_c
	LDA	DIGIT+3;3
	OUT	system_port_b
	CALL	DLY
	MVI	A,0
	OUT 	system_port_b
	;CALL	DLY

	MVI	C,04H     ;DIG4
	MOV	A,C
	ORI	0F0H
	OUT	system_port_c
	LDA	DIGIT+4;4
	OUT	system_port_b
	CALL	DLY  
	MVI	A,0
	OUT 	system_port_b
	;CALL	DLY


	MVI	C,05H     ;DIG4
	MOV	A,C
	ORI	0F0H
	OUT	system_port_c
	LDA	DIGIT+5
	OUT	system_port_b
	CALL	DLY
	MVI	A,0
	OUT 	system_port_b
	;CALL	DLY

	RET

NEW1:	MVI 	A,0
	STA	BUFFER+5
	RET
NEW2:	MVI 	A,0
	STA	BUFFER+4
	RET
NEW3:	MVI 	A,0
	STA	BUFFER+3
	RET
NEW4:	MVI 	A,0
	STA	BUFFER+2
	RET
NEW5:	MVI 	A,0
	STA	BUFFER+1
	RET
NEW6:	MVI 	A,0
	STA	BUFFER
	RET
	

dly12:	        mvi     E,020h	
LOOPO:		MVI	E,020h	;DELAY//BY LOOPING MANUALLY
LOOPD:		DCR	E
		JNZ	LOOPD
		DCR	D
		JNZ	LOOPO
	        RET

; subroutine scan keyboard and display
; input: hl pointer to buffer
; exit: key = scan code
; -1 no key pressed

scan: 
		push h				; save mem pointer hl
		push b                          ; save reg air bc...bc wasn't used be4, anyway just save
		push d				; save reg pair de ..d reg was used for time out loop counter(25 loop)
;**********************************************
;scan process initialization
;**********************************************
		mvi c,6 			; for 6-digit LED
		mvi e,0 			; digit scan code appears at 4-to-10 decoder
		mvi d,0 			; key position
		mvi a,0ffh 			; put -1 to key
		sta key 			; key = -1
scan1: 
		mov 	a,e             	; set a to zero to start with digit 1
		ori 	0f0h 			; high nibble must be 1111
		out 	system_port_c 		; active digit first
						
		mvi 	b,1			;****************************************************
wait1: 						; delay for transition process
		dcr b				;
		jnz wait1			;****************************************************

		in system_port_a 		; read input port to check if any key is pressed

;*******************************************************************************************************************
; analyse the 8 bit data read from port a; all bits are pulled high initially, therefore bit=0 mean a key is pressed
;*******************************************************************************************************************
		mvi b,8 			; check all 8-row
shift_key: 
		rar 				; rotate right through carry
		jc next_key 			; if carry = 1 then no key pressed
		push psw                        ; save accumulator and flag register into stack
		mov a,d				; copy position counter d to accum.
		sta key 			; save key position and then continue to check the rest of bits
		pop psw				; restore accumulator and flag register
next_key:
		inr d 				; next key position
		dcr b 				; until 8-bit was shifted
		jnz shift_key
;end of the 8 bit analysis

		mvi a,0 			; clear a
		inr e 				; next digit scan code(0,1,2,3,4,5)...4/5 may not used
		dcr c 				; next column(0-5)
		jnz scan1                       ; check keys in the next column
;finish scannig all keys
;key position has been save to key
		
		pop d
		pop b
		pop h
		ret

;-----------------------------------------------------------------
	
ISR_5_5:		
R5:             MVI	E, 07H
		RST	1
		CALL	dlyz
		MVI	E, 09H
		RST	1
		CALL	dlyz
		CALL	DISPSEVSEG

		LXI	H, 0301H	;----2NDLINE
		MVI	E, 0AH		
		RST	1
		LXI	H, PAUSE1
		MVI	E, 0BH		
		RST	1

		LXI	H, 0102H	;----3RDLINE
		MVI	E, 0AH		
		RST	1
		LXI	H, PAUSE2
		MVI	E, 0BH		
		RST	1

		MVI	A,0
		STA	GP
		
ii:		
		CALL	DISPSEVSEG
		
		;LDA	GP
		;CALL 	GPIO1
		;INR	A
		;STA	GP
		;MVI 	A,80H
		;OUT 	33H
		;LDA	GP
		;OUT 	30H
		;cma	
		;OUT 	30H
		;call	dlyz
		EI
		CALL	DISPSEVSEG
		mvi	h,00h
		mvi	l,07h
		shld	ctr
		call	scan 
		lda 	key
		CPI	1DH
		JNZ	ii 
		CALL	DISPSEVSEG
		MVI	E, 07H		;INITIATE LCD
		RST	1
		CALL	dlyz
		MVI	E, 09H		;CLEAR LCD
		RST	1
		CALL	dlyz
		ret

;--------------------------------------------------------------------

ISR_6_5:	MVI	E, 07H
		RST	1
		CALL	dlyz
		MVI	E, 09H
		RST	1
		CALL	dlyz
		call	DISPSEVSEG
		

		LXI	H, 0001H	
		MVI	E, 0AH		
		RST	1
		LXI	H, INT6.5_1
		MVI	E, 0BH		
		RST	1

		LXI	H, 0002H	
		MVI	E, 0AH		
		RST	1
		LXI	H, INT6.5_2
		MVI	E, 0BH		
		RST	1
		
pp:		mvi	h,00h
		mvi	l,07h
		shld	ctr
		call	scan 
		lda 	key
		cpi	02H
		jz	START
		CALL	DISPSEVSEG
		;MVI 	A,80H
		;OUT 	33H
		;LDA	GP
		;OUT 	30H
		;cma	
		;OUT 	30H
		;call	dlyz
		EI
		jmp 	pp
		RET

ISR_7_5:	MVI	A,0FH
		OUT	0
		CALL 	DLYZ
		MVI	A, 0
		OUT	0
		MVI	A,0FH
		OUT	0
		CALL 	DLYZ
		MVI	A, 0
		OUT	0
		EI
		RET

GPIO:	
		MVI A,0fH
		OUT 00H
		call dlyz
		MVI A,00H
		OUT 00H

		RET

GPIO1:	
		CALL	DISPSEVSEG
		LDA	GP
		OUT 	00H
		call 	dlyz
		MVI 	A,00H
		OUT 	00H
		LDA	GP
		CPI	0FH
		CZ	RESGP
		RET

RESGP:		MVI	A,0
		STA	GP
		RET
dlyz:
		LXI H, 10FAH
		MVI E, 01H
		RST	1
		RET

DLY:	MVI	D,02H
LOOPs:	MVI	E,0ffh
LOOPf:	DCR	E
	JNZ	LOOPf
	DCR	D
	JNZ	LOOPs
	RET

		org 0e000h
BUFFER:		dfs 6
DIGIT:		dfs 6
ctr:		dfs 2
key:		dfs 1 
GP:		DFS 1			
SEVSEGDATA:	dfb	3fh,06H,5BH,4FH,66H,6DH,7DH,07H,7FH,6FH,77H,7CH,39H,5EH,79H,71H,00h

WELCOME:	DFB	"WELCOME",00H
MAIN1:		DFB	"SORTING COINS,PRESS:",00H	
MAIN50:		DFB	"( 1 )->50 cents",00H
MAIN20:		DFB	"( 2 )->20 cents",00H
MAIN10:		DFB	"( 3 )->10 cents",00H
UNIVERSAL:	DFB	"SORTING:",00H
FIFTY:		DFB	"50 CENTS",00H
TWENTY:		DFB	"20 CENTS",00H
TEN:		DFB	"10 CENTS",00H	
INT6.5_1:	DFB	"  FINISHED SORTING",00H
INT6.5_2:	DFB	"PRESSED (0) TO RESET",00H
PAUSE1:		DFB	"SYSTEM PAUSE",00H
PAUSE2:		DFB	"PRESS F TO CONTINUE",00H
