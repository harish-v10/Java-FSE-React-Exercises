public class WebApp implements Observer {

    private String userName;

    public WebApp(String userName) {
        this.userName = userName;
    }

    @Override
    public void update(String stockName, double stockPrice) {
        System.out.println(
            "Web App [" + userName + "] received update: "
            + stockName + " = ₹" + stockPrice
        );
    }
}
