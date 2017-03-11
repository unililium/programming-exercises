#include <iostream>
#include <vector>

#define SIZE 5

using namespace std;

void insert_sort(int* a, int alength) {
    for (int i = 1; i <= alength; i++) {
        int key = a[i];
        int j = i - 1;

        while (j >= 0 && a[j] > key) {
            a[j + 1] = a[j];
            j = j - 1;
        }
        a[j + 1] = key;
    }
}

void print_array(int* a, int alength) {
    cout << "{ ";
    for (int i = 0; i < alength; i++) {
        cout << a[i] << " ";
    }
    cout << "}" << endl;
}

int main() {
    int a[SIZE] = {2, 6, 1, 23, -6};
    print_array(a, SIZE);
    insert_sort(a, SIZE);
    print_array(a, SIZE);
}
