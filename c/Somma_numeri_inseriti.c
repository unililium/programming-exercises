#include <stdio.h>

int n, k, i, tmp;

int main()
{
	k = 0;
	n = 0;
	tmp = 1;
	puts("\nper uscire 0");
	for(i = 0; tmp != 0 ;i++)
	{
	    printf("inserire un numero: ");
	    scanf("%d%", &n);
	   	k = n+k;
		if(n == 0)
			tmp = 0;
	}

	if(i != 0)
		n = k/i;
	printf("\n%d", n);

	return 0;
}
