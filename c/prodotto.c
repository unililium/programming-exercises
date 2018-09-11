/* Programma che calcola il prodotto di due numeri. */
#include <stdio.h>

int a,b,c;

int product(int x, int y);

int main()
{
	/* Ottiene il primo numero */
	printf("Inserire un numero compreso tra 1 e 100: ");
	scanf("%d", &a);
	
	/* Ottiene il secondo numero */
	printf("inserire un altro numero compreso tra 1 e 100: ");
	scanf("%d", &b);
	
	/* Calcola e visualizza il prodotto */
	c = product(a, b);
	printf ("%d per %d = %d/n", a, b, c);
	
	return 0;
}

/*	La funzione restituisce il prodotto dei due valori forniti */
int product(int x, int y)
{
	return (x * y);
}	