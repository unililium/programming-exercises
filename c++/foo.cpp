#include<cstdlib>
#include<iostream>
#include<string>
#include<vector>
#include<numeric>

int main() {
    std::vector<int> myVec(10);
    std::iota(std::begin(myVec), std::end(myVec), 1);

    for(auto y: myVec) {
        if(y != 0 && (y % 2) == 0)
            std::cout << y << "\n";
    }

    return 0;
}
