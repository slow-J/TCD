import java.util.Scanner;

public class SimpleExceptionHandling {

	public static void main(String[] args) {
		try
		{
			System.out.print("Enter a number: ");
		    @SuppressWarnings("resource")
			Scanner inputScanner = new Scanner( System.in );
		    int number = inputScanner.nextInt();
		    int result = 100 / number;
		    System.out.println( "Result is " + result );
		}
		catch (ArithmeticException exception)
		{
		    System.err.printf ( "\nException thrown: %s\n", exception );
		}
	}

}