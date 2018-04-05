import javax.swing.JOptionPane;
import java.util.Scanner;

public class PowerOf2 {

	public static void main(String[] args) {

		try
		{
			String input = JOptionPane.showInputDialog("Enter base:");
			Scanner scanner = new Scanner( input );
			int base = scanner.nextInt();
			input = JOptionPane.showInputDialog("Enter exponent:");
			scanner = new Scanner( input );
			int exponent = scanner.nextInt();
			
			if (exponent < 0)
			{
				JOptionPane.showMessageDialog(null, "Exponent must be positive", "Error", JOptionPane.ERROR_MESSAGE);
			}
			else
			{
				int result = 1;
				boolean resultTooBig = false;
				for (int i=0; ((i < exponent) && (!resultTooBig)); i++)
				{
					if (Integer.MAX_VALUE/base > result)
						result *= base;
					else resultTooBig = true;
				}
				if (resultTooBig)
					JOptionPane.showMessageDialog(null, "Result exceeds the largest possible integer.", "Error", JOptionPane.ERROR_MESSAGE);
				else JOptionPane.showMessageDialog(null, "" + base + " to the power of " + exponent + " is " + result);
			}
		}
		catch (NullPointerException exception)
		{
		}
		catch (java.util.NoSuchElementException exception)
		{
			JOptionPane.showMessageDialog(null, "No number entered.");
		}
	}

}