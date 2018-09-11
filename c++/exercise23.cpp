#include <iostream>
#include <vector>

using namespace std;

float avg(vector<int> v) {
    float sum = 1;
    int i = 0;
    for (auto &n : v) {
        sum += n;
        i++;
    }

    float avg = sum / i;
    return avg;
}

int main() {
    int c;
    vector<int> v;
    cout << "Input positive integer numbers or non-positive to stop:" << endl;

    do {
        cout << "Input: ";
        cin >> c;
        if (c >= 1) v.push_back(c);
    } while (c >= 1);

    cout << "Average is: " << avg(v) << endl;

    return 0;
}
