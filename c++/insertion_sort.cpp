#include <iostream>
#include <vector>

using namespace std;

void insertion_sort(vector<int> &a) {
    for (int i = 1; i < a.size(); i++) {
        int value = a[i];
        int j = i - 1;

        while (j >= 0 && a[j] > value) {
            a[j + 1] = a[j];
            j -= 1;
        }
        a[j + 1] = value;
    }
}

void print_array(vector<int> &a) {
    cout << "{ ";
    for (int i = 0; i < a.size(); i++) {
        cout << a[i] << " ";
    }
    cout << "}" << endl;
}

int main() {
    vector<int> a = {2, 6, 1, 23, -6};
    print_array(a);
    insertion_sort(a);
    print_array(a);
}
