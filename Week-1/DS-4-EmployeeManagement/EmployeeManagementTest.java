public class EmployeeManagementTest {

    public static void main(String[] args) {

        EmployeeManagement management =
                new EmployeeManagement(10);

        management.addEmployee(
                new Employee(101,
                             "John",
                             "Manager",
                             75000));

        management.addEmployee(
                new Employee(102,
                             "Alice",
                             "Developer",
                             60000));

        management.addEmployee(
                new Employee(103,
                             "Bob",
                             "Tester",
                             50000));

        System.out.println("\nEmployee Records:");
        management.displayEmployees();

        System.out.println("\nSearching Employee ID 102:");
        Employee employee =
                management.searchEmployee(102);

        if (employee != null) {
            System.out.println(employee);
        } else {
            System.out.println("Employee not found.");
        }

        System.out.println("\nDeleting Employee ID 102:");
        management.deleteEmployee(102);

        System.out.println("\nUpdated Employee Records:");
        management.displayEmployees();
    }
}