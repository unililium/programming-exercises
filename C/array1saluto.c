#include <stdio.h>
int main()
{
	char nome [10];
	printf("\nCome ti chiami? ");
	gets(nome); //acquisisco il nome
	printf("\nCiao %s!\n\n",nome);
}

