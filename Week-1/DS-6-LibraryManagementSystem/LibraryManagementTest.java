import java.util.Arrays;
import java.util.Comparator;

public class LibraryManagementTest {

    public static void main(String[] args) {

        Book[] books = {

                new Book(101,
                         "Java Programming",
                         "James Gosling"),

                new Book(102,
                         "Python Basics",
                         "Guido van Rossum"),

                new Book(103,
                         "Data Structures",
                         "Mark Allen Weiss"),

                new Book(104,
                         "C++ Fundamentals",
                         "Bjarne Stroustrup")
        };

        // Linear Search
        Book result1 =
                LibrarySearch.linearSearch(
                        books,
                        "Python Basics");

        System.out.println("Linear Search Result:");

        if (result1 != null) {
            System.out.println(result1);
        } else {
            System.out.println("Book not found.");
        }

        // Sort books by title for Binary Search
        Arrays.sort(
                books,
                Comparator.comparing(Book::getTitle)
        );

        Book result2 =
                LibrarySearch.binarySearch(
                        books,
                        "Python Basics");

        System.out.println("\nBinary Search Result:");

        if (result2 != null) {
            System.out.println(result2);
        } else {
            System.out.println("Book not found.");
        }
    }
}