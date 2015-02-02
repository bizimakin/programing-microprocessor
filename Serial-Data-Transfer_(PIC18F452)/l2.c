#pragma config[1] = 0xF1 // Osilat�r: XT
#pragma config[2] = 0xFE & 0xF9 // PWRT a��k, BOR kapal�
#pragma config[3] = 0xFE // WatchdogTimer kapal�

void ayarlar();
void seriTXayar();
void seriRXayar();
void serigonder(unsigned deger);
void bekle(unsigned long t);	// t milisaniye gecikme sa�layan fonksiyon tan�m�
unsigned char serial(void);

void main()
{	
	unsigned sayi='0',x='0';
	ayarlar();

//-----------------------------------------------	
anadongu:
	x=serial();
	serigonder(x);
	bekle(100);
goto anadongu;
//-----------------------------------------------	
}

//////////////////////////////////////////////////////////////////////////////////////////////////

void ayarlar()	// B�t�n ba�lang�� ayarlar�n�n tamamland��� k�s�m
{	
	GIE=0;			// B�t�n kesmeleri kapat
	TRISA=0xFF;
	TRISB=0;
	TRISC=0;	
	TRISD=0;
	TRISE.0=1;
	TRISE.1=1;
	TRISE.2=1;
	
	PORTC=0;		
	PORTD=0;
	PORTB=0;
	
	seriTXayar();
	seriRXayar();

	
}
//////////////////////////////////////////////////////////////////////////////////


void serigonder(unsigned deger)	// Seri porttan veri g�nderir
{	
	while(!TXIF);
	nop(); nop(); nop(); nop();
	TXREG=deger;
	
}


//////////////////////////////////////////////////////////////////////////////////


void seriTXayar()	// Seri Portu veri g�ndermeye haz�r hale getirir
{
	TRISC.6=0;
	TRISC.7=1;
	SPBRG=25;	// Baud Rate=9.6k
	BRGH=1;		// Y�ksek H�z
	SYNC=0;		// Asenkron mod
	SPEN=1;		// Seri port etkin
	TXIE=0;
	TX9=0;		// 8 bit Veri G�nderme
	TXEN=1;	// G�nderme etkin	
}

//////////////////////////////////////////////////////////////////////////////////////////////////

void bekle(unsigned long t)	//t milisaniye gecikme sa�lar
{
	unsigned x;
	
	for(;t>0;t--)
		for(x=80;x>0;x--)
			nop();
}

//////////////////////////////////////////////////////////////////////////////////////////////////

unsigned char serial(void)
{
	while(!RCIF);
nop(); nop(); nop(); nop();
	return RCREG;
}
void seriRXayar()	// Seri Portu veri almaya haz�r hale getirir
{
	TRISC.6=0;
	TRISC.7=1;
	SPBRG=25;	// Baud Rate=9.6k
	BRGH=1;		// Y�ksek H�z
	SYNC=0;		// Asenkron mod
	SPEN=1;		// Seri port etkin
	RCIE=0;
	RX9=0;		// 8 bit Veri Alma
	CREN=1;	// Alma etkin	
}

