public class SortingTest {

    public static void printOrders(Order[] orders) {

        for (Order order : orders) {
            System.out.println(order);
        }
    }

    public static void main(String[] args) {

        Order[] orders = {
                new Order(101, "John", 5000),
                new Order(102, "Alice", 12000),
                new Order(103, "Bob", 3000),
                new Order(104, "David", 8000)
        };

        System.out.println("Original Orders:");
        printOrders(orders);

        // Bubble Sort
        BubbleSort.sort(orders);

        System.out.println("\nAfter Bubble Sort:");
        printOrders(orders);

        // New array for Quick Sort
        Order[] orders2 = {
                new Order(101, "John", 5000),
                new Order(102, "Alice", 12000),
                new Order(103, "Bob", 3000),
                new Order(104, "David", 8000)
        };

        QuickSort.sort(orders2, 0, orders2.length - 1);

        System.out.println("\nAfter Quick Sort:");
        printOrders(orders2);
    }
}
