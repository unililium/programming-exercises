#include <omp.h>
#include <iostream>
#define CHUNKSIZE 100
#define N 1000

using namespace std;

int main() {
    float a[N], b[N], c[N];
#pragma omp parallel
    {
#pragma omp for schedule(dynamic, CHUNKSIZE) nowait
        for (int i = 0; i < N; i++) {
            a[i]++;
            b[i]++;
            c[i] = a[i] + b[i];
            cout << c[i] << endl;
        }
    }  // end of parallel region
}
