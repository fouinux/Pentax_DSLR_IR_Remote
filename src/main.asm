	list p=10f200
#include p10f200.inc

	__config _WDT_OFF & _CP_OFF & _MCLRE_OFF

; Variable definition
	udata
counterMs res 1	

; Constant definition
TRISGPIO_CONFIG EQU 0xFB
OPTION_CONFIG 	EQU 0x5F
BUTTON			EQU	GP0
IR_LED			EQU	GP2

MS_AT_38KHZ		EQU	0x26

	org 0x0000

INIT
	bcf		GPIO, IR_LED	; Off the LED
	movlw	TRISGPIO_CONFIG ; w <- TRIS config
	tris	6 				; GPIO1 -> output
	movlw	OPTION_CONFIG 	; w <- OPTION config
	option					; Wake up on gpio change

MAIN
	btfss	GPIO, BUTTON	;
	sleep					; If the button is push
	
	call 	HIGH_IMPULSION
	call 	HIGH_IMPULSION
	call 	HIGH_IMPULSION
	call 	HIGH_IMPULSION
	call 	HIGH_IMPULSION
	call 	HIGH_IMPULSION
	call 	HIGH_IMPULSION
	call 	HIGH_IMPULSION
	call 	HIGH_IMPULSION
	call 	HIGH_IMPULSION
	call 	HIGH_IMPULSION
	call 	HIGH_IMPULSION
	call 	HIGH_IMPULSION
	
	call 	LOW_IMPULSION
	call 	LOW_IMPULSION
	call 	LOW_IMPULSION
	
	call 	HIGH_IMPULSION
	call 	LOW_IMPULSION
	
	call 	HIGH_IMPULSION
	call 	LOW_IMPULSION
	
	call 	HIGH_IMPULSION
	call 	LOW_IMPULSION
	
	call 	HIGH_IMPULSION
	call 	LOW_IMPULSION
	
	call 	HIGH_IMPULSION
	call 	LOW_IMPULSION
	
	call 	HIGH_IMPULSION
	call 	LOW_IMPULSION
	
	call 	HIGH_IMPULSION
	call 	LOW_IMPULSION
	
	sleep
	
	goto 	MAIN


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;				High Impulsion function
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	Generate an impulsion at 38kHz for 1 ms
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
HIGH_IMPULSION
	movlw	MS_AT_38KHZ
	movwf	counterMs		; Load 38 in counterMs
	
HIMP_REPEAT
	bsf		GPIO, IR_LED	; On the LED
	nop				;Chuck Testa
	nop				;Chuck Testa
	nop				;Chuck Testa
	nop				;Chuck Testa
	nop				;Chuck Testa
	nop				;Chuck Testa
	nop				;Chuck Testa
	nop				;Chuck Testa
	nop				;Chuck Testa
	nop				;Chuck Testa
	nop				;Chuck Testa
	nop				;Chuck Testa
	bcf		GPIO, IR_LED	; Off the LED
	nop				;Chuck Testa
	nop				;Chuck Testa
	nop				;Chuck Testa
	nop				;Chuck Testa
	nop				;Chuck Testa
	nop				;Chuck Testa
	nop				;Chuck Testa
	nop				;Chuck Testa
	nop				;Chuck Testa
	decfsz 	counterMs,1		; Decrement counterMs, skip if 0
	goto HIMP_REPEAT
	retlw	0				; End the call
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;				Low Impulsion function
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	Generate an impulsion at 38kHz for 1 ms
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LOW_IMPULSION
	movlw	MS_AT_38KHZ
	movwf	counterMs		; Load 38 in counterMs
	
LIMP_REPEAT
	bcf		GPIO, IR_LED	; Off the LED
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	decfsz 	counterMs,1		; Decrement counterMs, skip if 0
	goto LIMP_REPEAT
	retlw	0				; End the call

	end
