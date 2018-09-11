#include <iostream>
#include <string>
#include <vector>

using std::vector;

int main() {
    vector<std::string> articles{10, "the"};
    for (auto i : articles) {
        std::cout << i << std::endl;
    }
    return 0;
}
