#include <iostream>

using namespace std;

unsigned long factorial(unsigned long, unsigned long);

int main() {
    unsigned long n;

    cout << "Insert a number: ";
    cin >> n;

    cout << factorial(n, 1) << endl;

    return 0;
}

unsigned long factorial(unsigned long n, unsigned long acc) {
    acc *= n;
    if (n <= 1) return acc;
    return factorial(n - 1, acc);
}
