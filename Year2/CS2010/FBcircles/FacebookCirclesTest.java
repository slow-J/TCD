import java.io.*;
import java.util.Scanner;
import java.util.HashMap;

import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.junit.Ignore;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

//-------------------------------------------------------------------------
/**
 * Test class for FacebookCircles class
 *
 * @author
 *
 * @version 06/12/15 15:06:51
 */

@RunWith(JUnit4.class)
public class FacebookCirclesTest {

	// ~ Unit tests ..........................................................
	@Test
	public void testEmpty() {
		FacebookCircles fbCircles = new FacebookCircles(10);
		assertEquals("Checking number of circles", 10, fbCircles.numberOfCircles());
		assertEquals("Checking size of largest circle", 1, fbCircles.sizeOfLargestCircle());
		assertEquals("Checking size of average circle", 1, fbCircles.sizeOfAverageCircle());
		assertEquals("Checking size of smallest circle", 1, fbCircles.sizeOfSmallestCircle());

	}

	@Test
	public void testOneFriendship() {
		FacebookCircles fbCircles = new FacebookCircles(10);
		fbCircles.friends(0, 1);
		assertEquals("Checking number of circles", 9, fbCircles.numberOfCircles());
		assertEquals("Checking size of largest circle", 2, fbCircles.sizeOfLargestCircle());
		assertEquals("Checking size of average circle", 1, fbCircles.sizeOfAverageCircle());
		assertEquals("Checking size of smallest circle", 1, fbCircles.sizeOfSmallestCircle());
	}

	@Test
	public void testOneFriendshipOdd() {
		FacebookCircles fbCircles = new FacebookCircles(4);
		fbCircles.friends(0, 1);
		assertEquals("Checking number of circles when there is 1 friendship b/w 4 users", 3,
				fbCircles.numberOfCircles());
		assertEquals("Checking size of largest circle there is 1 friendship b/w 4 users", 2,
				fbCircles.sizeOfLargestCircle());
		assertEquals("Checking size of average circle there is 1 friendship b/w 4 users", 1,
				fbCircles.sizeOfAverageCircle());
		assertEquals("Checking size of smallest circle there is 1 friendship b/w 4 users", 1,
				fbCircles.sizeOfSmallestCircle());
	}

	@Test
	public void testTwoFriendshipsEven() {
		FacebookCircles fbCircles = new FacebookCircles(4);
		fbCircles.friends(0, 1);
		fbCircles.friends(0, 2);
		assertEquals("Checking number of circles when there are two friendships b/w 4 users", 2,
				fbCircles.numberOfCircles());
		assertEquals("Checking size of largest circle there are two friendships b/w 4 users", 3,
				fbCircles.sizeOfLargestCircle());
		assertEquals("Checking size of average circle there are two friendships b/w 4 users", 2,
				fbCircles.sizeOfAverageCircle());
		assertEquals("Checking size of smallest circle there are two friendships b/w 4 users", 1,
				fbCircles.sizeOfSmallestCircle());
	}

	@Test
	public void testTwoFriendshipsOdd() {
		FacebookCircles fbCircles = new FacebookCircles(5);
		fbCircles.friends(0, 1);
		fbCircles.friends(3, 2);
		assertEquals("Checking number of circles when there are two friendships b/w 5 users", 3,
				fbCircles.numberOfCircles());
		assertEquals("Checking size of largest circle there are two friendships b/w 5 users", 2,
				fbCircles.sizeOfLargestCircle());
		assertEquals("Checking size of average circle there are two friendships b/w 5 users", 1,
				fbCircles.sizeOfAverageCircle());
		assertEquals("Checking size of smallest circle there are two friendships b/w 5 users", 1,
				fbCircles.sizeOfSmallestCircle());
	}

	@Test
	public void testTwoFriendshipsiEven2() {
		FacebookCircles fbCircles = new FacebookCircles(8);
		fbCircles.friends(1, 2);
		fbCircles.friends(3, 4);
		fbCircles.friends(5, 6);
		fbCircles.friends(6, 7);
		assertEquals("Checking number of circles when there are 4 friendships b/w 8 users", 4,
				fbCircles.numberOfCircles());
		assertEquals("Checking size of largest circle there are 4 friendships b/w 8 users", 3,
				fbCircles.sizeOfLargestCircle());
		assertEquals("Checking size of average circle there are 4 friendships b/w 8 users", 2,
				fbCircles.sizeOfAverageCircle());
		assertEquals("Checking size of smallest circle there are 4 friendships b/w 8 users", 1,
				fbCircles.sizeOfSmallestCircle());
	}

	// ~ Integration
	// Tests..........................................................
	//
	// Each of the following methods tests the actual facebook data from the
	// provided
	// assignment files
	//
	@Test
	public void test1684() throws IOException {
		FacebookCircles fbCircles = readFacebookData("1684.edges");
		assertEquals("Checking number of circles in file 1684.edges", 4, fbCircles.numberOfCircles());
		assertEquals("Checking size of largest circle in file 1684.edges", 775, fbCircles.sizeOfLargestCircle());
		assertEquals("Checking size of average circle in file 1684.edges", 196, fbCircles.sizeOfAverageCircle());
		assertEquals("Checking size of smallest circle in file 1684.edges", 2, fbCircles.sizeOfSmallestCircle());
	}

	@Test
	public void test1912() throws IOException {
		FacebookCircles fbCircles = readFacebookData("1912.edges");
		assertEquals("Checking number of circles in file 1912.edges", 2, fbCircles.numberOfCircles());
		assertEquals("Checking size of largest circle in file 1912.edges", 744, fbCircles.sizeOfLargestCircle());
		assertEquals("Checking size of average circle in file 1912.edges", 373, fbCircles.sizeOfAverageCircle());
		assertEquals("Checking size of smallest circle in file 1912.edges", 3, fbCircles.sizeOfSmallestCircle());
	}

	@Test
	public void test3437() throws IOException {
		FacebookCircles fbCircles = readFacebookData("3437.edges");
		assertEquals("Checking number of circles in file 3437.edges", 2, fbCircles.numberOfCircles());
		assertEquals("Checking size of largest circle in file 3437.edges", 532, fbCircles.sizeOfLargestCircle());
		assertEquals("Checking size of average circle in file 3437.edges", 267, fbCircles.sizeOfAverageCircle());
		assertEquals("Checking size of smallest circle in file 3437.edges", 2, fbCircles.sizeOfSmallestCircle());
	}

	@Test
	public void test348() throws IOException {
		FacebookCircles fbCircles = readFacebookData("348.edges");
		assertEquals("Checking number of circles in file 348.edges", 1, fbCircles.numberOfCircles());
		assertEquals("Checking size of largest circle in file 348.edges", 224, fbCircles.sizeOfLargestCircle());
		assertEquals("Checking size of average circle in file 348.edges", 224, fbCircles.sizeOfAverageCircle());
		assertEquals("Checking size of smallest circle in file 348.edges", 224, fbCircles.sizeOfSmallestCircle());
	}

	@Test
	public void test3980() throws IOException {
		FacebookCircles fbCircles = readFacebookData("3980.edges");
		assertEquals("Checking number of circles in file 3980.edges", 4, fbCircles.numberOfCircles());
		assertEquals("Checking size of largest circle in file 3980.edges", 44, fbCircles.sizeOfLargestCircle());
		assertEquals("Checking size of average circle in file 3980.edges", 13, fbCircles.sizeOfAverageCircle());
		assertEquals("Checking size of smallest circle in file 3980.edges", 2, fbCircles.sizeOfSmallestCircle());
	}

	@Test
	public void testAll() throws IOException {
		FacebookCircles fbCircles = readFacebookData("all.edges");
		assertEquals("Checking number of circles in file all.edges", 270, fbCircles.numberOfCircles());
		assertEquals("Checking size of largest circle in file all.edges", 75458, fbCircles.sizeOfLargestCircle());
		assertEquals("Checking size of average circle in file all.edges", 282, fbCircles.sizeOfAverageCircle());
		assertEquals("Checking size of smallest circle in file all.edges", 1, fbCircles.sizeOfSmallestCircle());
	}

	/**
	 * Read the contents of a facebook friendship file containing pairs of user
	 * names in each line, separated by whitespace, and construct the
	 * corresponding FacebookCircles file..
	 * 
	 * @param fFileName
	 *            : the name of the file
	 * @return an object of the class FacebookCircles, containing the friendship
	 *         information in the file.
	 */
	static FacebookCircles readFacebookData(String fFileName) throws IOException {
		String user, otherUser;

		// read the file once to get the number of facebook users
		// and assign a unique integer, starting from 0, to each user
		Scanner scanner = new Scanner(new FileInputStream(fFileName));

		HashMap<String, Integer> userMap = new HashMap<String, Integer>();
		int noOfUsers = 0;
		try {
			while (scanner.hasNext()) {
				user = scanner.next();
				if (!userMap.containsKey(user)) {
					userMap.put(user, noOfUsers);
					noOfUsers++;
				}
			}
		} finally {
			scanner.close();
		}

		// now we can construct the FacebookCircle object
		FacebookCircles fbCircles = new FacebookCircles(noOfUsers);
		scanner = new Scanner(new FileInputStream(fFileName));
		try {
			while (scanner.hasNext()) {
				// read the two friends
				user = scanner.next();
				otherUser = scanner.next();
				// sanity check that the file hasn't changed between reads
				assert (userMap.containsKey(user));
				assert (userMap.containsKey(otherUser));
				// find the two user's int ids and add their friendship in the
				// fbCircles object
				fbCircles.friends(userMap.get(user).intValue(), userMap.get(otherUser).intValue());
			}
		} finally {
			scanner.close();
		}
		return fbCircles;
	}

}
