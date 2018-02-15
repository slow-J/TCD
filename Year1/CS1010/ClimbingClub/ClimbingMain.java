import java.util.Scanner;

public class ClimbingMain
{

	public static void main(String[] args)
	{
		int selection;
		String inMake;
		int inModel;
		String inInstructor;
		String inLoanee;
		boolean quit = false;
		HarnessRecords harnesses = new HarnessRecords();
		System.out.print("WELCOME to the harness tracker 4000. Make your selection by entering the corresponding number:");
		while (quit==false)
		{
			System.out.print("\n(1) add a record for a newly purchased harness,"
					+ "\n(2) remove a climbing harness from the club,"
					+ "\n(3) record the fact that a club instructor has checked the safety of a harness,"
					+ "\n(4) loan a harness to a club member if there is an available harness, "
					+ "\n(5) return a harness which is no longer in use by a club member,"
					+ "\n(6) view all club harnesses,"
					+ "\n(7) QUIT PROGRAM. "
					+ "\n>>>");
			
			Scanner scanner = new Scanner(System.in);
			selection = scanner.nextInt();
			
			if (selection==1)
			{
				System.out.println("Enter MAKE of new harness ie LYNX"
						+ "\n>>>");
				scanner = new Scanner(System.in);
				inMake = scanner.nextLine();
				System.out.println("Enter MODEL number of new harness ie 4721"
						+ "\n>>>");
				inModel = scanner.nextInt();
				Harness inHarness = new Harness(inMake, inModel, "brand new");
				harnesses.addHarness(inHarness);
				System.out.println("Adding " + inMake + "/" + inModel + " successful.");
			}
			
			if (selection==2)
			{
				System.out.println("Enter MAKE of harness to remove ie LYNX"
						+ "\n>>>");
				scanner = new Scanner(System.in);
				inMake = scanner.nextLine();
				System.out.println("Enter MODEL number of harness to remove ie 4721"
						+ "\n>>>");
				inModel = scanner.nextInt();
				if(harnesses.removeHarness(inMake, inModel)==null)
				{
					System.out.println("ERROR. This harness doesnt exist.");
				}
				else
				{
					System.out.println("Removing " + inMake + "/" + inModel + " successful.");
				}
			}
			if (selection==3)
			{
				System.out.println("Enter name of instructor who performed safety check"
						+ "\n>>>");
				scanner = new Scanner(System.in);
				inInstructor= scanner.nextLine();
				System.out.println("Enter MAKE of harness inspected ie LYNX"
						+ "\n>>>");
				inMake = scanner.nextLine();
				System.out.println("Enter MODEL number of harness inspected ie 4721"
						+ "\n>>>");
				inModel = scanner.nextInt();
				if(harnesses.checkHarness(inMake, inModel, inInstructor)==null)
				{
					System.out.println("ERROR. This harness doesnt exist.");
				}
				else
				{
					System.out.println("Safety check by " + inInstructor + " successful.");
				}
			}
			if (selection==4)
			{
				System.out.println("Enter name of club member to loan harness to"
						+ "\n>>>");
				scanner = new Scanner(System.in);
				inLoanee= scanner.nextLine();
				if (harnesses.loanHarness(inLoanee)==null)
				{
					System.out.println("ERROR. No harnesses available for loan.");
				}
				else
				{
					System.out.println("Loaning to " + inLoanee + " successful.");
				}
					
			}
			if (selection==5)
			{
				System.out.println("Enter MAKE of harness to remove ie LYNX"
						+ "\n>>>");
				scanner = new Scanner(System.in);
				inMake = scanner.nextLine();
				System.out.println("Enter MODEL number of harness to remove ie 4721"
						+ "\n>>>");
				inModel = scanner.nextInt();
				if (harnesses.returnHarness(inMake, inModel)==null)
				{
					System.out.println("ERROR. This harness doesn't exist.");
				}
				else
				{
					System.out.println("Returning " + inMake + "/" + inModel + " successful.");
				}
				
			}
			if (selection==6)
			{
				harnesses.allHarnesses();
			}
			if (selection==7)
			{
				quit=true;
			}
		}
		if(quit=true)
		{
			System.out.println("PROGRAM TERMINATED");
		}
	}

}

/*
Write a Java program which will allow a user (the climbing club manager) to keep track of and update the current characteristics of each climbing club harness through a user interface (text based or otherwise). 
The user interface must at least allow the climbing club manager to:

(1) add a record for a newly purchased harness,

(2) remove a climbing harness from the club,

(3) record the fact that a club instructor has checked the safety of a harness,

(4) loan a harness to a club member if there is an available harness,  

5) return a harness which is no longer in use by a club member.


*/