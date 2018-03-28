import java.util.ArrayList;
import java.util.HashSet;
import java.util.Stack;
/**
 * Class FacebookCircles: calculates the statistics about the friendship circles in facebook data.
 *
 * @author
 *
 * @version 01/12/15 02:03:28
 */
public class FacebookCircles 
{
	int sizeOfAverageCircle;
	int sizeOfSmallestCircle;
	int sizeOfLargestCircle;
	int numberOfAccounts;
	int numberOfCircles;	
	boolean circlesUpdated;
	
	ArrayList<FacebookUser> userList;
	ArrayList<Integer> circleSizes;

	private class FacebookUser
	{
		ArrayList<FacebookUser> friendList;
		int userID;
		public FacebookUser(int userID) 
		{
			this.userID = userID;
			this.friendList = new ArrayList<FacebookUser>();
		}
	}
	
  /**
   * Constructor
   * @param numberOfFacebookUsers : the number of users in the sample data.
   * Each user will be represented with an integer id from 0 to numberOfFacebookUsers-1.
   */
	public FacebookCircles(int numberOfFacebookUsers) 
	{
		//TODO
		this.sizeOfSmallestCircle = 1;
		this.sizeOfLargestCircle = 1;
		this.sizeOfAverageCircle = 1;
		
		this.numberOfAccounts = numberOfFacebookUsers;
		this.numberOfCircles = numberOfFacebookUsers;
		this.circlesUpdated = false;
		

		this.userList = new ArrayList<FacebookUser>();
		
		this.circleSizes = new ArrayList<Integer>();

		for (int i=1; i <= numberOfFacebookUsers; i++) 
		{
			FacebookUser newUser = new FacebookUser(i);
			userList.add(newUser);
		}
		this.circleSizes = updateCircleSize();
	}

   /**
   * creates a friendship connection between two users, represented by their corresponding integer ids.
   * @param user1 : int id of first user
   * @param user2 : int id of second  user
   */
	public void friends( int user1, int user2 ) 
	{
		FacebookUser userOne = userList.get(user1);
		FacebookUser userTwo = userList.get(user2);

		this.circlesUpdated = false;
		userOne.friendList.add(userTwo); //make each other to friends
		userTwo.friendList.add(userOne);
	}

	public ArrayList<Integer> updateCircleSize() 
	{
		if (!this.circlesUpdated) 
		{

			HashSet<FacebookUser> userList = new HashSet<FacebookUser>(this.userList);
			this.circleSizes = new ArrayList<Integer>();
			
			Stack<FacebookUser> userStack = new Stack<FacebookUser>();
			while (userList.isEmpty()==false) 
			{
				userStack.push(userList.iterator().next());
				int currentCircleSize = 1;
				
				while (userStack.isEmpty()==false) 
				{
					FacebookUser currentUser = userStack.pop();
					// Remove user, so not operated on twice
					userList.remove(currentUser);
					for (FacebookUser friend : currentUser.friendList) 
					{
						if (userList.contains(friend)) 
						{
							userList.remove(friend);
							userStack.push(friend);
							currentCircleSize++;
						}
					}
				}
				
				this.circleSizes.add(currentCircleSize);
			}
			this.circlesUpdated = true;
		}
		return this.circleSizes;
	}
  
  /**
   * @return the number of friend circles in the data already loaded.
   */
	public int numberOfCircles() 
	{
		return this.updateCircleSize().size();
	}

  /**
   * @return the size of the largest circle in the data already loaded.
   */
  public int sizeOfLargestCircle()
  {
	  int largestCircleSize = 0;	    
	  for(Integer x : this.circleSizes)
	  {
		  if(x>=largestCircleSize)
		  {	  
			  largestCircleSize = x;
		  }
	  }
	  return largestCircleSize;
  }

  /**
   * @return the size of the median circle in the data already loaded.
   */
  public int sizeOfAverageCircle() 
  {
	  int ret = this.userList.size()/this.updateCircleSize().size();
	  return ret;
  }

  /**
   * @return the size of the smallest circle in the data already loaded.
   */
  public int sizeOfSmallestCircle() 
  {
	  int smallestCircleSize;
	  
	  if(!this.circleSizes.isEmpty()) 
	  {
		  smallestCircleSize = this.circleSizes.get(0);
		  for(Integer i : this.circleSizes)
		  {
			  if(i<smallestCircleSize)
				  smallestCircleSize = i;

		  }
	  }	  
	  else
	  {
		  smallestCircleSize = 0;		  
	  } 
	  return smallestCircleSize;
  }
}