public class StrategyPatternTest {

    public static void main(String[] args) {

        PaymentContext context;

        // Using Credit Card payment
        context = new PaymentContext(new CreditCardPayment());
        context.executePayment(5000);

        // Switching to PayPal payment
        context.setPaymentStrategy(new PayPalPayment());
        context.executePayment(2500);
    }
}
