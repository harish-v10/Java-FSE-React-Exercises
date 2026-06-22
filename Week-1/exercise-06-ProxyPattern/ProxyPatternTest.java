public class ProxyPatternTest {

    public static void main(String[] args) {

        Image image = new ProxyImage("nature.jpg");

        System.out.println("Image object created.");

        System.out.println("\nFirst display call:");
        image.display();

        System.out.println("\nSecond display call:");
        image.display();
    }
}