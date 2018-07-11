#include <iostream>
#include <vector>

using namespace std;

vector<int> merge(vector<int> &a1, vector<int> &a2) {
    vector<int> a;
    int k = 0, i = 0, j = 0;

    while(k < a1.size() * 2) {
        if(a1[i] <= a2[j]) {
            a.push_back(a1[i]);
            i++;
        } else {
            a.push_back(a2[j]);
            j++;
        }
        k++;
    }
}
void merge_sort(vector<int> &a) {
    vector<int> a1;
    vector<int> a2;

    if(a.size() == 1) return;

    for(int i = 0; i < a.size()/2; i++)
        a1.push_back(a[i]);
    for(int i = a.size()/2; i < a.size(); i++)
        a2.push_back(a[i]);

    merge_sort(a1);
    merge_sort(a2);
    a = merge(a1, a2);
}


void print_array(vector<int> &a) {
    cout << "{ ";
    for (int i = 0; i < a.size(); i++) {
        cout << a[i] << " ";
    }
    cout << "}" << endl;
}

int main() {
    vector<int> a = {2, 423, -7, 1, 23, -6};
    print_array(a);
    merge_sort(a);
    print_array(a);
}
