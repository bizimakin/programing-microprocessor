		LIST P=16F84A
INCLUDE "P16F84A.INC"
__CONFIG _CP_OFF & _WDT_OFF & _PWRTE_ON & _RC_OSC ; Config ayarlar� yap�ld�. RC osilat�r yap�ld�.
SAYAC2 	EQU H'0D' ; Gecikme i�in sayaclar tan�mland�.
SAYAC	EQU H'0C'
SAYAC3	EQU H'0B'
		ORG 0X00 ;Ba�lama adresi
		CLRF PORTB ; PORTB yi temizledik.
		BSF STATUS,5 ; STATUS'un be�inci bitini 1 yaparak BANK1'e ge�tik.
		CLRF TRISB ; PORTB'yi ��k�� olarak tan�mlad�k.
		BCF STATUS,5 ;STATUS'un be�inci bitini 0 yaparak BANK0'a ge�tik.
TEKRAR ; Tekrar birinci ledi yakmas� i�in d�ng� tan�mlad�k
		MOVLW H'01' ; �lk ledi yakt�k
		MOVWF PORTB 
SAG	  ; Birinci ledden 4.lede kayarak gitmesi i�in d�ng� kurduk.
		CALL TIMER ; Gecikme d�ng�s� �a��rd�k
		RLF PORTB,F ; 1.ledden ba�layarak yakt���m�z ledleri 4.lede kadar kayd�ran komut.
		BTFSS PORTB,3 ; RB3'e geldi�imizi kontrol edip SON d�ng�s�ne gidece�imiz komut.
		GOTO SAG ; RB3 ledi yanmad�ysa SAG d�ng�s�ne git.
		GOTO SON ; RB3 ledi yand�ysa SON d�ng�s�ne git.
SON ; Bu d�ng� t�m ledleri s�f�rlar. Ve 8. ledi yakar.
		CALL TIMER ; gecikme d�ng�s�
		MOVLW B'00000000' ; Ledleri s�nd�rd�k.
		MOVWF PORTB
		CALL TIMER
		MOVLW H'80' ; Sola kaymas� i�in 8. Ledi yakt�k.
		MOVWF PORTB
		GOTO SOL
SOL
		CALL TIMER 
		RRF PORTB,F ; 8. Ledden 5. lede kayd�ran komut.
		BTFSS PORTB,4 ; RB4'in yan�p yanmad���n� kontrol ederiz.
		GOTO SOL ; RB4 deki led yanmad�ysa d�ng�ye devam et.
		CALL TIMER
		MOVLW B'00000000' ; RB4 deki led yand�ysa ledleri s�nd�r.
		MOVWF PORTB ; Tekrar d�ng�s�ne git.
		CALL TIMER
		GOTO TEKRAR
TIMER  ; RC osilat�r i�in gecikme d�ng�s�
		MOVLW H'37'
		MOVWF SAYAC
DONGUl
		MOVLW H'37'
		MOVWF SAYAC2
DONGU2
		MOVLW H'37'
		MOVWF SAYAC3
DONGU3
		DECFSZ SAYAC3, F
		GOTO DONGU3
		DECFSZ SAYAC2, F
		GOTO DONGU2
		DECFSZ SAYAC, F
		GOTO DONGUl
		RETURN
		END