import java.util.ArrayList;

public class HarnessRecords
{
	ArrayList<Harness> harnessArray = new ArrayList<Harness>();
	
	public HarnessRecords()
	{
		this.harnessArray.clear();
	}
	public HarnessRecords(String streamInput)
	{
		
	}
	public boolean isEmpty()
	{
		if(this.harnessArray==null)
		{
			return true;
		}
		return false;
	}
	public void addHarness(Harness inHarness)
	{
		this.harnessArray.add(inHarness);
	}
	public Harness findHarness(String inMake, int inModel)
	{
		for(int i=0; i<this.harnessArray.size(); i++)
		{
			String a = this.harnessArray.get(i).getMake();
			if((a.equals(inMake)) && (this.harnessArray.get(i).getModel() == inModel))
			{
				Harness foundHarness = this.harnessArray.get(i);
				return foundHarness;
			}
		}
		return null;
	}
	public Harness checkHarness(String inMake, int inModel, String inInstructor)
	{
		for(int i=0; i<this.harnessArray.size(); i++)
		{
			String a = this.harnessArray.get(i).getMake();
			if((a.equals(inMake)) && (this.harnessArray.get(i).getModel() == inModel))
			{
				Harness foundHarness = this.harnessArray.get(i);
				foundHarness.checkHarness(inInstructor);
				return foundHarness;
			}
		}
		return null;
	}
	public Harness loanHarness(String inLoanee)
	{
		for(int i=0; i<this.harnessArray.size(); i++)
		{
			if(this.harnessArray.get(i).canHarnessBeLoaned())
			{
				Harness foundHarness = this.harnessArray.get(i);
				foundHarness.loanHarness(inLoanee);
				return foundHarness;
			}
		}
		return null;
	}
	public Harness returnHarness(String inMake, int inModel)
	{
		for(int i=0; i<this.harnessArray.size(); i++)
		{
			String a = this.harnessArray.get(i).getMake();
			if((a.equals(inMake)) && (this.harnessArray.get(i).getModel() == inModel))
			{
				Harness foundHarness = this.harnessArray.get(i);
				foundHarness.returnHarness();
				return foundHarness;
			}
		}
		return null;
	}
	public Harness removeHarness(String inMake, int inModel)
	{
		for(int i=0; i<this.harnessArray.size(); i++)
		{
			String a = this.harnessArray.get(i).getMake();
			if((a.equals(inMake)) && (this.harnessArray.get(i).getModel() == inModel))
			{
				Harness foundHarness = this.harnessArray.get(i);
				this.harnessArray.remove(i);
				return foundHarness;
			}
		}
		return null;
	}
	public void allHarnesses()
	{
		System.out.println("");
		if (this.harnessArray.size()==0)
		{
			System.out.println("There are no harnesses belonging to your club.");
		}
		for(int i=0; i<this.harnessArray.size(); i++)
		{
			System.out.println("("+ (i+1) + "/"+ this.harnessArray.size()+ ") " + this.harnessArray.get(i).toString());
			System.out.println("");
		}
	}
}
/*
Design a HarnessRecords data type (Java class) whose values (Java objects) represent the collection of harnesses owned by climbing club, that is, the current characteristics of each harness owned by a climbing club. Your data type must store a list of Harness values (using either an array or an ArrayList) and must provide at least the following operations (Java instance methods):

(1) a constructor which constructs an empty HarnessRecords value, that is, a HarnessRecords value which does not contain any Harness values.

(2) a constructor which takes an input stream containing the number of harness contained in the stream follow by characteristics values for each harness. The constructor creates a HarnessRecords value containing a Harness value for each one in the input stream.

(3) isEmpty which determiners whether this collection of harness records is empty,  that is, does not contain any Harness values.

(4) addHarness which takes a Harness value to add to the list of currently of currently recorded climbing club harnesses.

(5) findHarness which takes a harness make and model number, and which finds and returns the harness with given make and model number, assuming that such a harness exists in list of currently recorded climbing club harnesses, otherwise the operation returns the null value.

(6) checkHarness which takes an instructor name, a harness make and model number, and which updates the characteristics of this particular harness to reflect the fact that the given instructor has safety checked the harness, assuming the harness exists and is currently not on loan. If a harness is updated it is returned by the operation, otherwise the operation has no effect and      returns the null value.

(7) loanHarness which takes the name of a climbing club member and which tries to find an available harness for them to use. If a usable harness is found its characteristics are updated and the harness is returned, otherwise the operation has no effect and returns the null value.

(8) returnHarness which takes the make and model number of a harness, which should be currently on loan to a club member, and which finds and updates the  characteristics of that particular harness, assuming that such a harness exists. If a harness is found and updated it is returned by the operation,  otherwise the operation has no effect and returns the null value.

(9) removeHarness which takes the make and model number of a harness, and which finds and removes the harness from the list of currently recorded climbing club harnesses, assuming that such a harness exists. If a harness is found and removed it is returned by the operation, otherwise the operation has no effect and returns the null value.
*/
