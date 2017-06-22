#include <stdio.h>

int radius, area;

int main()
{
    printf( "Immettere raggio (ad. es. 10): " );
    scanf( "%d", &radius );
    area = (int) (3.14159*radius*radius);
    printf( "\n\nArea = %d\n", area );
    return 0;
}
