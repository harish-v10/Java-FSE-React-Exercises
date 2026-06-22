public class TaskManagementTest {

    public static void main(String[] args) {

        TaskLinkedList taskList = new TaskLinkedList();

        taskList.addTask(
                new Task(101,
                         "Design Database",
                         "Pending"));

        taskList.addTask(
                new Task(102,
                         "Develop API",
                         "In Progress"));

        taskList.addTask(
                new Task(103,
                         "Testing",
                         "Pending"));

        System.out.println("Task List:");
        taskList.displayTasks();

        System.out.println("\nSearching Task ID 102:");

        Task task = taskList.searchTask(102);

        if (task != null) {
            System.out.println(task);
        } else {
            System.out.println("Task not found.");
        }

        System.out.println("\nDeleting Task ID 102:");
        taskList.deleteTask(102);

        System.out.println("\nUpdated Task List:");
        taskList.displayTasks();
    }
}