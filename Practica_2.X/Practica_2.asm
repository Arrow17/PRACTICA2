


LIST P = 18f45K50 
    #include<p18f45K50.inc> 
    CONFIG WDTEN = OFF		;Disables the Watchdog 
    CONFIG MCLRE = ON		;Enables MCLEAR 
    CONFIG DEBUG = OFF		;Disables Debug mode 
    CONFIG LVP = OFF		;Disables Low-Voltage programming 
    CONFIG FOSC = INTOSCIO	;Enables the internal oscillator 
   
    org 0		; Sets first instruction in address 00 

Start:
    MOVLB 0x0F 
    CLRF ANSELB 
    CLRF PORTB 
    CLRF TRISB 
    MOVLW b'00110011' 
    MOVWF OSCCON 
    MOVLW b'00000111'   ;Channel A1 is selected and the module is enabled 
    MOVWF ADCON0 
    MOVLW b'00000000'   ;Vref-, Vref+ are defined 
    MOVWF ADCON1 
    MOVLW b'00010111'   ;As clock source, the RC oscillator of the converter 
    MOVWF ADCON2	;left justified 
    
MainLoop:
    BSF ADCON0,1	;Starts conversion 

conv:
    BTFSC ADCON0,1	 ;Check for GO/DONE bit to clear 
    GOTO conv		 ;Loop to check for bit 1 of ADCON0 
    MOVFF ADRESH,PORTB	 ;Move ADRESH to PORTB 
    GOTO MainLoop	 ;Jumps to instruction just after MainLoop tag 
    END			 ;End of program 