import java.util.Scanner;

public class Chuck 
{
	public static void main(String[] args) 
	{
		boolean finished = false;
		System.out.print("Insert money into account: ");
		Scanner scanner = new Scanner(System.in);	
		Double initialMoney = scanner.nextDouble();
		Wallet myWallet; // declare a name dice1 which can refer to a Dice object
		myWallet = new Wallet();    // create a 6-sided Dice object & name it dice1
		myWallet.put(initialMoney);
		System.out.println("Welcome, you currently have €"+ myWallet.check());
		String s;
		while (finished==false)
		{
			System.out.println("Place bet(Triple, Field, High, Low) or type quit: ");
			scanner = new Scanner(System.in);	
			s = scanner.next();

			if (s.equals("Quit")||s.equals("quit"))
			{
				finished = true;
				scanner.close();
			}
			else
			{
				resolveBet(myWallet, s);
			}
		}
		if (finished ==true)
		{
			System.out.println("Thank you for playing.\n Your initial balance was: " + initialMoney
					+ "\n You left with: €"+ myWallet.check());
			if (initialMoney<myWallet.check())
			{
				System.out.println("Congratulations on your hard earned cash.");
			}
			if (initialMoney>myWallet.check())
			{
				System.out.println("Better luck next week.");
			}
			if (initialMoney==myWallet.check())
			{
				System.out.println("Time well spent.");
			}
		}
	}	
	public static void resolveBet(Wallet myWallet, String s)
	{
		double bet;
		boolean win = false;
		double money = myWallet.check();
		System.out.println("You currently have €"+ money + " at your disposal");
		System.out.println("How much are you willing to bet");
		Scanner scanner = new Scanner(System.in);	
		bet = scanner.nextDouble();
		if (bet<=money)
		{
			myWallet.put(bet-bet*2);
			
			Dice dice1; // Dice object
			Dice dice2;
			Dice dice3;

			dice1 = new Dice(6);    
			dice2 = new Dice(6);  
			dice3 = new Dice(6);
			dice1.roll(); // invoke the role operation
			dice2.roll(); 
			dice3.roll(); 
			System.out.println("The die has been cast!");
			System.out.println(
			         "\n" + "dice1 = " + dice1.topFace() + "\n" 
			              + "dice2 = " + dice2.topFace() + "\n" 
			              + "dice3 = " + dice3.topFace() + "\n"
			      );
			if (s.equals("Triple")||s.equals("triple"))
			{
				if(dice1.topFace()==dice2.topFace()&& dice1.topFace()==dice3.topFace()
						&&dice1.topFace()>1&&dice1.topFace()<6)
				{
					myWallet.put(30*bet+bet);
					win = true;
				}
			}
			if (s.equals("Field")||s.equals("field"))
			{
				if(dice1.topFace()+dice2.topFace()+ dice3.topFace()<8||dice1.topFace()
						+dice2.topFace()+dice3.topFace()>12)
				{
					myWallet.put(bet+bet);
					win = true;
				}
			}
			if (s.equals("High")||s.equals("high"))
			{
				if (dice1.topFace()==dice2.topFace()&& dice1.topFace()==dice3.topFace()&& dice1.topFace()==4||dice1.topFace()==dice2.topFace()
						&& dice1.topFace()==dice3.topFace()
						&& dice1.topFace()==5||dice1.topFace()==dice2.topFace()
						&& dice1.topFace()==dice3.topFace()&& dice1.topFace()==6)
				{
					
				}
				else 
				{
					if(dice1.topFace()+dice2.topFace()+ dice3.topFace()>10)
					{
						myWallet.put(bet+bet);
						win = true;
					}
				}
			}
			if (s.equals("Low")||s.equals("low"))
			{
				if (dice1.topFace()==dice2.topFace()&& dice1.topFace()==dice3.topFace()&& dice1.topFace()==1||dice1.topFace()==dice2.topFace()
						&& dice1.topFace()==dice3.topFace()
						&& dice1.topFace()==2||dice1.topFace()==dice2.topFace()
						&& dice1.topFace()==dice3.topFace()&& dice1.topFace()==3)
				{
					
				}
				else 
				{
					if(dice1.topFace()+dice2.topFace()+ dice3.topFace()<11)
					{
						myWallet.put(bet+bet);
						win = true;
					}
				}
			}

		}
		else
		{
			System.out.println("Error your funds are too low to place that bet.");
		}
		if (win==true)
		{
			System.out.println("Congratulations on your hard earned win.");
		}
		else
		{
			System.out.println("Unlucky.\nYou lost €"+bet);
		}

	}
}
/*
Your program requires:

1. mainline (parts of the mainline can be implemented in new methods that you can create) which does the following:

Asks the user for the amount of cash he/she has and creates a Wallet object and puts this cash into it.
Allows the user to play continuously placing any of the four bet types until the user either enters quit or the cash in the wallet is 0.
For each bet placed by the user, the resolveBet method is called.
Once the game is over, provides an overall summary by comparing the cash in the wallet with what the user initially started with.
 

2. ResolveBet method which takes the bet type (String) and the Wallet object and does not return anything:

Presents the amount of cash in the wallet and ask the user how much he/she would like to bet
Ensures the bet amount is not greater than the cash in the wallet
Checks to see if the bet is correct by creating three Dice objects and rolling them and comparing roll output with the bet type.
outputs the results (win or loss) and adds the winnings to the wallet if user wins or removes the bet amount from the wallet if the user loses. 
*/