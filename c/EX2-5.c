/* EX2-5.c */
#include <stdio.h>
#include <string.h>
int main()
{
	char buffer[256];

	printf( "Inserire il nome e premere <Invio>:\n");
	gets( buffer );

	printf( "\nIl tuo nome contiene %d caratteri e spazi!",
			strlen( buffer ));

	return 0;
}
