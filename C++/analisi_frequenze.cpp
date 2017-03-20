#include <fstream>
#include <iostream>
#include <string>

using namespace std;

class Symbol {
    char car;
    int q;

   public:
    Symbol(char car, int q) : car(car), q(q) {}
};

int main() {
    ofstream file;
    string pathname;

    cout << "Insert the full pathname of the file: " << endl;
    getline(cin, pathname);
    file.open(pathname);
    if (file.is_open()) {
    } else {
        cout << "error" << endl;
    }
    file.close();

    return 1;
}
