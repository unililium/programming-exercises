#include <stdio.h>
#include <stdlib.h>

int main()
{
    int a, divisorea, divisoreb;                                         //dichiarazione variabili
    printf("Inserisci il numero di cui vuoi calcolare i divisori: ");    //dati in ingresso
    scanf ("%d", &a);
    divisorea = 2;
    printf ("I divisori fino al dieci del numero inserito sono\n\n");                  //noi si che siamo user friendly
    printf ("1");                                                        //� sempre divisibile per uno
    do  {                                                                //fai
    if ((a % divisorea) == 0)                                            //se il resto � zero
    {
        printf (", %d", divisorea);                                       //scrivi il divisore
        divisorea++;                                                     //incremento
        break;                                                           //e fermo il ciclo
    }
    else                                                                 //altrimenti
    divisorea = (divisorea + 1);                                         //incremento di uno
    } while ((a % divisorea) == 0);                                      //fintantoch� il resto non � zero
    divisoreb = divisorea;
    do{                                                                  //fai
    if ((a % divisoreb) == 0)                                            //se il resto � zero
    {
        printf (", %d",divisoreb);                                        //scrivi ",divisore"
    }
    divisoreb++;                                                         //incremento la variabile
    } while (divisoreb <= 10);                                           //fintantoch� il divisore � <= 10
    printf (".");                                                        //aggiungo il punto alla fine.

    return 0;
}
