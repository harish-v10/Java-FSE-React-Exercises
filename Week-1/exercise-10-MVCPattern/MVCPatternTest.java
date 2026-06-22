public class MVCPatternTest {

    public static void main(String[] args) {

        // Create Model
        Student student = new Student("John", 101, "A");

        // Create View
        StudentView view = new StudentView();

        // Create Controller
        StudentController controller =
                new StudentController(student, view);

        // Display initial details
        System.out.println("Initial Student Information:");
        controller.updateView();

        // Update student details through Controller
        controller.setStudentName("Alice");
        controller.setStudentGrade("A+");

        System.out.println("\nUpdated Student Information:");
        controller.updateView();
    }
}
