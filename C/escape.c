/* Mostra le sequenze di escape utilizzate di frequente */

#include <stdio.h>

#define QUIT 3

int get_menu_choice(void);
void print_report(void);

int main()
{
	int choice = 0;

	while (choice != QUIT)
	{
		choice = get_menu_choice();

		if (choice == 1)
		   printf("\nBeep\a\a\a");
		else
		{
			if (choice == 2)
			   print_report();
		}
	}
	printf("Hai scelto di uscire!\n");

	return 0;
}

int get_menu_choice(void)
{
	int selection = 0;

	do
	{
		printf("\n");
		printf("\n1 - Beep");
		printf("\n2 - Mostra rapporto");
		printf("\n3 - Esci");
		printf("\n");
		printf("\nInserisci un numero:");

		scanf("%d", &selection);
	}while (selection < 1 || selection > 3);

	return selection;
}

void print_report(void)
{
	printf("\nRAPPORTO CAMPIONE");
	printf("\n\nSequenza\tSignificato");
	printf("\n=========\t=======");
	printf("\n\\a\t\tbell (beep)");
	printf("\n\\b\t\tbackspace");
	printf("\n...\t\t...");
}
	
