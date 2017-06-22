/* sizeof.c-Programma che indica la dimensione dei tipi di variabile C in byte */

#include <stdio.h>

int main()
{
	
	printf( "\nUn char � %d byte", sizeof( char ));
	printf( "\nUn int � %d byte", sizeof( int ));
	printf( "\nUn short � %d byte", sizeof( short ));
	printf( "\nUn long � %d byte", sizeof( long ));
	printf( "\nUn unsigned char � %d byte", sizeof( unsigned char ));
	printf( "\nUn unsigned int � %d byte", sizeof( unsigned int ));
	printf( "\nUn unsigned short � %d byte", sizeof( unsigned short ));
	printf( "\nUn unsigned long � %d byte", sizeof( unsigned long ));
	printf( "\nUn float � %d byte", sizeof( float ));
	printf( "\nUn double � %d byte", sizeof( double ));

	return 0;
}
