#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef enum { false, true } boolean;

typedef struct simbolo {
    char car;
    int q;
    struct simbolo *next;
} L;

typedef L *L_PTR;

L_PTR Crea(L_PTR, char);
void Ricerca(L_PTR, char);
void PrintOnStdout(L_PTR, int);

void main() {
    FILE *fp;
    char c, pathname[40];
    boolean first = true;
    int cartot = 0;
    L_PTR list;

    puts("Inserisci il pathname completo del file da analizzare: ");
    fgets(pathname, 100, stdin);
    printf("Hai inserito: %s", pathname);

    fp = fopen(pathname, "r");
    if (fp == NULL) {
        puts("Errore apertura file!");
        exit(-1);
    }
    puts("File aperto\n");

    do {
        c = getc(fp);
        if (first == true) {
            list = malloc(sizeof(L));
            list->car = c;
            list->q = 1;
            list->next = NULL;
            first = false;
        } else if (c != '\n' && c != ' ')
            Ricerca(list, c);

        if (c != '\n' && c != ' ') cartot++;

    } while (c != EOF);

    PrintOnStdout(list, cartot);

    fclose(fp);
}

L_PTR Crea(L_PTR testa, char c) {
    L_PTR temp;

    temp = testa;

    while (temp->next != NULL) temp = temp->next;

    temp->next = (L_PTR)malloc(sizeof(L));
    temp->next->car = c;
    temp->next->q++;

    return testa;
}

void Ricerca(L_PTR testa, char c) {
    L_PTR temp;

    temp = testa;
    while ((temp != NULL) && (temp->car != c)) temp = temp->next;

    if (temp != NULL)
        temp->q += 1;
    else
        testa = Crea(testa, c);
}

void PrintOnStdout(L_PTR testa, int cartot) {
    L_PTR temp;
    float freq, n, d;

    temp = testa;
    while (temp != NULL) {
        n = temp->q * 100;
        d = cartot;
        freq = n / d;
        printf("Carattere: %c   frequenza: %f.3%%\n", temp->car, freq);
        temp = temp->next;
    }
    printf("Caratteri totali: %d\n", cartot);
}