import java.util.Scanner;

import javax.swing.JOptionPane;

/*
 * Write a program to compute the maximum and minimum numbers in a
 * list of numbers entered by the user (on a single line).
 */
public class MinMax {

	public static void main(String[] args) {
		String input = JOptionPane.showInputDialog("Enter your list of numbers separated\nby spaces:");
		Scanner numberScanner = new Scanner( input );
		if (numberScanner.hasNextDouble())
		{
			double minimumNumber = numberScanner.nextDouble();
			double maximumNumber = minimumNumber;
			while (numberScanner.hasNextDouble())
			{
				double currentNumber = numberScanner.nextDouble();
				if (currentNumber < minimumNumber)
					minimumNumber = currentNumber;
				if (currentNumber > maximumNumber)
					maximumNumber = currentNumber;
			}
			JOptionPane.showMessageDialog(null, "The numbers you entered are between " +
					minimumNumber + " and " + maximumNumber );
		}
		else
		{
			JOptionPane.showMessageDialog(null, "No numbers provided.",
					"Error", JOptionPane.ERROR_MESSAGE);
		}
	}

}