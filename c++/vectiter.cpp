#include <iostream>
#include <string>
#include <vector>

using namespace std;

int main() {
    vector<int> v(20);

    for (int tmp = 1; tmp < 10; tmp++) {
        cin >> v[tmp];
        string str(v.begin(), v.end()-1);
        cout << str << endl;
    }

    return 0;
}
