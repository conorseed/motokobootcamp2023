import Utils "utils";
import Array "mo:base/Array";
import Int "mo:base/Int";
import Buffer "mo:base/Buffer";
import Book "book";
import List "mo:base/List";

actor{
    /*
     * 4. In your file called book.mo create a custom type
     * with at least 2 properties (title of type Text, pages of type Nat),
     * import this type in your main.mo and create a variable that will store a book.
     */
    var book : Book.Book = Book.create_book("Harry Pottah", 123456, "J K Rowling");

    /*
     * 6. In main.mo import the type List from the Base Library
     * and create a list that stores books.
     */
    var library = List.nil<Book.Book>();

    /*
     * 7.1 In main.mo create a function called add_book that
     * takes a book as parameter and returns nothing.
     * This function should add this book to your list.
     */
    public func add_book(book : Book.Book) : () {
        library := List.push<Book.Book>(book, library);
    };
    
    /*
     * 7.2 Then create a second function called get_books that
     * takes no parameter but returns an Array that contains all books stored in the list.
     */
     public query func get_books() : async [Book.Book] {
        return List.toArray(library);
     };
    
}