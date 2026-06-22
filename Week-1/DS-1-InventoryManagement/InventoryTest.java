public class InventoryTest {

    public static void main(String[] args) {

        InventoryManager manager = new InventoryManager();

        Product p1 = new Product(101, "Laptop", 20, 55000);
        Product p2 = new Product(102, "Mouse", 100, 500);

        // Add Products
        manager.addProduct(p1);
        manager.addProduct(p2);

        System.out.println("\nInventory:");
        manager.displayProducts();

        // Update Product
        manager.updateProduct(101,
                              "Gaming Laptop",
                              15,
                              65000);

        System.out.println("\nAfter Update:");
        manager.displayProducts();

        // Delete Product
        manager.deleteProduct(102);

        System.out.println("\nAfter Deletion:");
        manager.displayProducts();
    }
}
