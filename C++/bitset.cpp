#include <bitset>
#include <iostream>

int main() {
    char a = -58;
    std::bitset<8> x(a);
    std::cout << x;
    return 0;
}