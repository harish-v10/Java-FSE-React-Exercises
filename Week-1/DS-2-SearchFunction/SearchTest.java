import java.util.Arrays;
import java.util.Comparator;

public class SearchTest {

    public static void main(String[] args) {

        Product[] products = {
                new Product(105, "Keyboard", "Electronics"),
                new Product(101, "Laptop", "Electronics"),
                new Product(103, "Mouse", "Electronics"),
                new Product(104, "Headphones", "Accessories"),
                new Product(102, "Monitor", "Electronics")
        };

        // Linear Search
        Product result1 =
                SearchAlgorithms.linearSearch(products, 104);

        System.out.println("Linear Search Result:");
        System.out.println(result1);

        // Sort array for Binary Search
        Arrays.sort(products,
                Comparator.comparingInt(Product::getProductId));

        Product result2 =
                SearchAlgorithms.binarySearch(products, 104);

        System.out.println("\nBinary Search Result:");
        System.out.println(result2);
    }
}