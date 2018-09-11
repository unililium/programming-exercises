/* EX2-2.c */
#include <stdio.h>

void display_line(void);

int main()
{
	display_line();
	printf("\n Un bel libro sul C!\n");
	display_line();
	
	return 0;
}

/* stampa una riga di asterischi */
void display_line(void)
{
	int counter;

	for( counter = 0; counter < 21; counter++ )
		printf("*" );
}
/* fine del programma */
