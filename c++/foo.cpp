#include<cstdlib>
#include<iostream>
#include<string>
#include<vector>
#include<numeric>

// FUNCTION PROTOTYPES 

int main() {
    int age = 42;
    int* pAge = NULL;

    pAge = &age;

    std::cout << "Address: " << pAge << "\n";

    return 0;
}