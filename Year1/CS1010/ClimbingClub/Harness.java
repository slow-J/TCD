
public class Harness
{
	private String make;
	private int model;
	private int usage;
	private String instructor;
	private boolean onLoan;
	private String loanee;
	private final int MAX_USAGE = 25;
	
	public String getMake()
	{
		return make;
	}
	public int getModel()
	{
		return model;
	}
	
	public Harness(String inMake, int inModel, int inUsage, String inInstructor, boolean inOnLoan, String inLoanee)
	{
		this.make = inMake;
		this.model = inModel;
		this.usage = inUsage;
		this.instructor = inInstructor;
		this.onLoan = inOnLoan;
		this.loanee = inLoanee;
	}
	public Harness(String inMake, int inModel, String inInstructor)
	{
		this.make = inMake;
		this.model = inModel;
		this.usage = 0;
		this.instructor = inInstructor;
		this.onLoan = false;
		this.loanee = "";
	}
	public void checkHarness(String inInstructor)
	{
		if (this.onLoan==false)
		{
			this.usage = 0;
			this.instructor = inInstructor;
		}
	}
	public boolean isHarnessOnLoan()
	{
		return this.onLoan;
	}
	public boolean canHarnessBeLoaned()
	{
		if(isHarnessOnLoan()==false&&this.usage<MAX_USAGE)
		{
			return true;
		}
		return false;
	}
	public void loanHarness(String inLoanee)
	{
		if (canHarnessBeLoaned())
		{
			this.onLoan = true;
			this.loanee = inLoanee;
		}
	}
	public void returnHarness()
	{
		if (this.onLoan==true)
		{
			this.usage++;
			this.onLoan=false;
			this.loanee = "no one";
		}
	}
	public String toString()
	{
		String a;
		a="The harness make/model>>> "+ this.make + "/"+ this.model+ ",";
		if(this.instructor.equals("brand new"))
		{
			a+= "\nBrand new and never safety checked, ";
		}
		else
		{
			a+= "\nLast safety check by: "+ this.instructor +", ";
		}
		a+="\nUsed " + this.usage + " times since last safety check,";
		if(this.onLoan)
		{
			a+="\nOn loan to: " +this.loanee+ ".";
		}
		else
		{
			a+="\nNot on loan.";
		}
		return a;
	}
}
/*(1) a constructor which takes the make, the model number, the number of times the harness was used, the name of the climbing instructor who last checked the safety of the harness, whether the harness is on loan, and if the harness is on loan the name of club member who has it borrowed. The constructor creates a Harness value with the given characteristics.

(2) a constructor which takes the make, the model number, and the name of the climbing instructor who checked the safety of the harness, and which creates a Harness value with the given characteristics and the other characteristics to sensible initial values.  

(3) checkHarness which takes the name of a climbing instructor and which resets the number of times used value of this harness and records the name of the safety checking instructor, assuming that this harness is not currently on out on loan, otherwise this operation has no effect.

(4) isHarnessOnLoan which determines whether this harness is currently loaned out to a climbing club member.

(5) canHarnessBeLoaned which determines whether this harness can be loaned out to a climbing club member.

(6) loanHarness which takes the name of a climbing club member and which loans this harness to the club member, assuming that this harness can be loaned, otherwise the operation has no effect.  

(7) returnHarness which updates this harness characteristics to record the fact that the harness has been returned by a climbing club member, assuming that the harness was on loan. If the harness was not on loan the operation has no effect.

(8) toString which return a String value description of this harness.
*/