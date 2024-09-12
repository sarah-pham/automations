import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

public class ShellHelper {
    public static void printSolutionMethods() {
        List<String> names = new ArrayList<>();
        for (Method m : Solution.class.getMethods()) {
            names.add(m.getName());
        }
        String output = String.join("|", names);
        System.out.println(output);
    }

    public static void main(String[] args) {
        try {
            ShellHelper.class.getMethod(args[0]).invoke(null);
        } catch (Exception e) {
            System.err.println(e);
        }
    }
}
