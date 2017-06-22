// Mostra l'uso di malloc() per allocare spazio in memoria per le stringhe

#include<stdio.h>
#include<stdlib.h>

char count, *ptr, *p;

int main()
{
	// Alloca un blocco di 35 byte.
	// Verifica il successo.

	ptr = malloc(35 * sizeof(char));

	if (ptr == NULL)
	{
		puts("Errore allocazione memoria.");
		return 1;
	}

	/* Riempie la stringa con valori da 65 a 90,
	 * che sono i codici ASCII per A-Z.

	 * p è un puntatore utiliazzato per elaborare la stringa.
	 * Si vuole che ptr punti sempre all'inizio della stringa. */

	p = ptr;

	for (count = 65; count < 91; count++)
		*p++ = count;

	// Aggiunge il carattere nell di terminazione.

	*p = '\0';

	// Visualizza la stringa sullo schermo.

	puts(ptr);

	return 0;
}
