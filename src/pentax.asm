; Add this line in the project properties box "pic-as Global Options -> Additional options":
; -Wa,-a -Wl,-DCODE=2,-pStartCode=0h,-pResetVec=1ffh
    
    PROCESSOR 10F202

#include <xc.inc>

; CONFIG
  CONFIG  WDTE = OFF            ; Watchdog Timer (WDT disabled)
  CONFIG  CP = OFF              ; Code Protect (Code protection off)
  CONFIG  MCLRE = OFF           ; Master Clear Disable (GP3/MCLR pin fuction is digital I/O, MCLR internally tied to VDD)

; Variable definition
PSECT udata
cycleCnt:
    DS	1
loop:
    DS	1

; Constant definition
#define IR_LED		GP2	; Define Infrared GPIO
#define TRISGPIO_CONFIG	0xFB	; GP2 as output
#define OPTION_CONFIG	0xDF	; Default config


PSECT   StartCode,class=CODE,delta=2
    global  Start
Start:
    movwf	OSCCAL			; Set OSCCAL with calibrated value
    bcf		IR_LED			; Off the LED
    movlw	TRISGPIO_CONFIG		; w <- TRIS config
    tris	GPIO 			; Write TRIS register
    movlw	OPTION_CONFIG		; w <- OPTION config
    option				; Write OPTION register

Main:
    movlw	0xfa	; 250 cycles : 6.5ms
    call 	High_Impulsion
    movlw	0xfa	; 250 cycles : 6.5ms
    call 	High_Impulsion
	
    movlw	0x73	; 115 cycles  : 3ms
    call 	Low_Impulsion
	
    movlw	0x26	; 38 cycles : 1 ms
    call 	High_Impulsion
    movlw	0x26	; 38 cycles : 1 ms
    call 	Low_Impulsion
	
    movlw	0x26	; 38 cycles : 1 ms
    call 	High_Impulsion
    movlw	0x26	; 38 cycles : 1 ms
    call 	Low_Impulsion
	
    movlw	0x26	; 38 cycles : 1 ms
    call 	High_Impulsion
    movlw	0x26	; 38 cycles : 1 ms
    call 	Low_Impulsion
	
    movlw	0x26	; 38 cycles : 1 ms
    call 	High_Impulsion
    movlw	0x26	; 38 cycles : 1 ms
    call 	Low_Impulsion
	
    movlw	0x26	; 38 cycles : 1 ms
    call 	High_Impulsion
    movlw	0x26	; 38 cycles : 1 ms
    call 	Low_Impulsion
	
    movlw	0x26	; 38 cycles : 1 ms
    call 	High_Impulsion
    movlw	0x26	; 38 cycles : 1 ms
    call 	Low_Impulsion
	
    movlw	0x26	; 38 cycles : 1 ms
    call 	High_Impulsion
    movlw	0x26	; 38 cycles : 1 ms
    call 	Low_Impulsion
	
    goto 	$	; Endless loop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   Modulation routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   Generate n cycles of 38kHz modulation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
High_Impulsion:
    movwf	cycleCnt	; Load cycle counter from w
	
High_Repeat:
    bsf		IR_LED		; On the LED
    movlw	3		; Wait for 12µs
    movwf	loop
    decfsz 	loop,1
    goto	$-1
    goto	$+1
    bcf		IR_LED		; Off the LED
    goto	$+1
    goto	$+1
    decf	cycleCnt, 1
    btfsc	ZERO
    retlw	0		; End the call
    goto	$+1
    nop
    goto	High_Repeat

	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   Delay routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   Delay n cycles of 38kHz modulation equivalent
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Low_Impulsion:
    movwf	cycleCnt	; Load cycle counter from w
    
Low_Repeat:
    movlw	5		; Wait for 18µs
    movwf	loop
    decfsz 	loop,1
    goto	$-1
    goto	$+1
    decf	cycleCnt, 1
    btfsc	ZERO
    retlw	0		; End the call
    goto	$+1
    nop
    goto	Low_Repeat
    
PSECT ResetVec,class=CODE,delta=2
    global  ResetVector
ResetVector:

    end     ResetVector 