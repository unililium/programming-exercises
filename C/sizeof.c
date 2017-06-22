/* sizeof.c-Programma che indica la dimensione dei tipi di variabile C in byte */

#include <stdio.h>

int main()
{
	
	printf( "\nUn char ши %d byte", sizeof( char ));
	printf( "\nUn int ши %d byte", sizeof( int ));
	printf( "\nUn short ши %d byte", sizeof( short ));
	printf( "\nUn long ши %d byte", sizeof( long ));
	printf( "\nUn unsigned char ши %d byte", sizeof( unsigned char ));
	printf( "\nUn unsigned int ши %d byte", sizeof( unsigned int ));
	printf( "\nUn unsigned short ши %d byte", sizeof( unsigned short ));
	printf( "\nUn unsigned long ши %d byte", sizeof( unsigned long ));
	printf( "\nUn float ши %d byte", sizeof( float ));
	printf( "\nUn double ши %d byte", sizeof( double ));

	return 0;
}
