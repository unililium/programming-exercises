#include <iostream>
#include <vector>

using namespace std;

void insert_sort(vector<int> a) {
    int alength = a.size();

    for (int i = 1; i <= alength; i++) {
        int key = a[i];
        int j = i - 1;

        while (j > 0 && a[j] > key) {
            a[j + 1] = a[j];
            j = j - 1;
        }
        a[j + 1] = key;
    }
}

void print_array(vector<int> a) {
    int alength = a.size();
    cout << "{ ";
    for (int i = 0; i < alength; i++) {
        cout << a[i] << " ";
    }
    cout << "}" << endl;
}

int main() {
    vector<int> a = {2, 6, 1, 23, -6};
    print_array(a);
    insert_sort(a);
    print_array(a);
}
