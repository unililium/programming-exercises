#include <omp.h>
#include <iostream>

using namespace std;

int main() {
    int tid;

#pragma omp parallel num_threads(3) private(tid)
    {
        tid = omp_get_thread_num();
        cout << "Hello World. I am thread " << tid << endl;
    }

    return 0;
}
