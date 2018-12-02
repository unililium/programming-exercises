#include<cstdlib>
#include<iostream>
#include<string>
#include<vector>
#include<numeric>

// FUNCTION PROTOTYPES 

double AddNumbers(double num1, double num2);

int main() {
    std::vector<int> myVec(10);
    std::iota(std::begin(myVec), std::end(myVec), 1);

    for(auto y: myVec) {
        if(y != 0 && (y % 2) == 0)
            std::cout << y << "\n";
    }

    double num1, num2;
    std::cout << "Enter num 1: ";
    std::cin >> num1;
    std::cout << "Enter num 2: ";
    std::cin >> num2;
    printf("%.1f + %.1f = %.1f\n", num1, num2, AddNumbers(num1, num2));

    return 0;
}

// FUNCTIONS
double AddNumbers(double num1, double num2) {
    return num1 + num2;
}
