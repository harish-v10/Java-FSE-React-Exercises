public class FinancialForecast {

    // Recursive method
    public static double predictFutureValue(double currentValue,
                                            double growthRate,
                                            int years) {

        // Base Case
        if (years == 0) {
            return currentValue;
        }

        // Recursive Case
        return predictFutureValue(
                currentValue,
                growthRate,
                years - 1
        ) * (1 + growthRate);
    }
}