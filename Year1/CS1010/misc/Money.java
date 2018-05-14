import javax.swing.JOptionPane;
import java.util.Scanner;

public class Money {
	
	public static final int OLD_PENNY_PER_NEW_PENNY = 67;
	public static final int OLD_SHILLING_PER_NEW_PENNY = 804;
	public static final int OLD_POUND_PER_NEW_PENNY = 16080;
	public static final int PENNYS_PER_NEW_POUND = 16080;
		
	public static void main(String []args)
	{
		
		String input = JOptionPane.showInputDialog("What are your Pounds, Shillings and Pennys that you wish to convert (separated by spaces)");
		Scanner inputScanner = new Scanner(input);
		int pound = inputScanner.nextInt();
		int shilling = inputScanner.nextInt();
		int penny = inputScanner.nextInt();
		inputScanner.close();	
		
		double newpound = 0.0;
		newpound = (OLD_PENNY_PER_NEW_PENNY*penny + OLD_SHILLING_PER_NEW_PENNY*shilling + OLD_POUND_PER_NEW_PENNY*pound)/100.0;
		
		JOptionPane.showMessageDialog(null, "For " + pound + " pounds, " +
				shilling + " shillings, " + penny + " pennys, the new pound value is £" + newpound );
		
		
	}
		
}
