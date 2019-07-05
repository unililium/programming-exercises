#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Book {
    public:
        string title;
        string author;
        int pages;

        Book() {
            title = "no title";
            author = "no author";
            pages = 0;
        }

        Book(string atitle, string aauthor, int apages) {
            title = atitle;
            author = aauthor;
            pages = apages;
        }
};

int main() {

    Book book1 = Book("MAru", "Maroc", 3);
    cout << book1.title << endl;

    return 0;
}
