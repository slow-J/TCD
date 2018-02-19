/******************************************************************************
 *
 * (C) John Carbeck 2018
 *
 *****************************************************************************/
                  
#include <LPC213x.H>                    /* LPC213x definitions                */
#include <stdio.h>

extern void start (void);
extern void init_serial (void);		    /* Initialize Serial Interface        */

unsigned long table[] = {0x00003780,0x00000300,0x00009580,0x00008780, 0x0000A300,0x0000A680,0x0000B680,0x00000380,0x0000B780,0x0000A380,0x0000B380,0x0000B600,0x00003480,0x0009700,0x0000B480,0x0000B080};

void delay (void) {
	unsigned int cnt;
	for (cnt = 0; cnt < 5000000; cnt++);
}

long buttons_val;
int table_index = 0;

int main (void) {
	init_serial();
	
	IODIR0 = 0x0001B780;   
	
	while(1) 
	{
		buttons_val = IOPIN1;
		buttons_val &= 0x00F00000;
		buttons_val >>= 20;
		if(buttons_val != 15)
		{
			if(buttons_val == 4 || buttons_val == 8 
				|| (buttons_val >= 0 && buttons_val <=2))
			{
				if(table_index + 1 > 15) table_index = 0;
				else table_index++;
			}
			else
			{
				if(table_index - 1 < 0) table_index = 15;
				else table_index--;
			}
		}
		IOCLR0 = 0x000FFFF0;
		IOSET0 = table[table_index];
		delay();
	}
	//return 0;
}
