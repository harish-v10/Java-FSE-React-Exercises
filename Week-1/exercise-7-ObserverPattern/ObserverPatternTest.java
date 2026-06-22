public class ObserverPatternTest {

    public static void main(String[] args) {

        StockMarket stockMarket = new StockMarket("TCS");

        Observer mobileUser = new MobileApp("Alice");
        Observer webUser = new WebApp("Bob");

        stockMarket.registerObserver(mobileUser);
        stockMarket.registerObserver(webUser);

        stockMarket.setStockPrice(3500.50);
        stockMarket.setStockPrice(3600.75);

        System.out.println("\nRemoving WebApp Observer...");

        stockMarket.deregisterObserver(webUser);

        stockMarket.setStockPrice(3700.25);
    }
}
