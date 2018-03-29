import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.junit.Ignore;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

import java.util.Arrays;

//-------------------------------------------------------------------------
/**
 *  Test class for Collinear.java
 *
 *  @author  
 *  @version 03/10/16 17:10:35#
 
 */
@RunWith(JUnit4.class)
public class CollinearTest
{
    //~ Constructor ........................................................
    @Test
    public void testConstructor()
    {
      new Collinear();
    }

    //~ Public Methods ........................................................

    // ----------------------------------------------------------
    /**
     * Check that the two methods work for empty arrays
     */
    @Test
    public void testEmpty()
    {
        int expectedResult = 0;

        assertEquals("countCollinear failed with 3 empty arrays",       expectedResult, Collinear.countCollinear(new int[0], new int[0], new int[0]));
        assertEquals("countCollinearFast failed with 3 empty arrays", expectedResult, Collinear.countCollinearFast(new int[0], new int[0], new int[0]));
    }

    // ----------------------------------------------------------
    /**
     * Check for no false positives in a single-element array
     */
    @Test
    public void testSingleFalse()
    {
        int[] a3 = { 15 };
        int[] a2 = { 5 };
        int[] a1 = { 10 };

        int expectedResult = 0;

        assertEquals("countCollinear({10}, {5}, {15})",       expectedResult, Collinear.countCollinear(a1, a2, a3) );
        assertEquals("countCollinearFast({10}, {5}, {15})", expectedResult, Collinear.countCollinearFast(a1, a2, a3) );
    }

    // ----------------------------------------------------------
    /**
     * Check for no false positives in a single-element array
     */
    @Test
    public void testSingleTrue()
    {
        int[] a3 = { 15, 5 };       int[] a2 = { 5 };       int[] a1 = { 10, 15, 5 };

        int expectedResult = 1;

        assertEquals("countCollinear(" + Arrays.toString(a1) + "," + Arrays.toString(a2) + "," + Arrays.toString(a3) + ")",     expectedResult, Collinear.countCollinear(a1, a2, a3));
        assertEquals("countCollinearFast(" + Arrays.toString(a1) + "," + Arrays.toString(a2) + "," + Arrays.toString(a3) + ")", expectedResult, Collinear.countCollinearFast(a1, a2, a3));
    }
    
    @Test
    public void testCollinear()
    {
    	int[] a3 = { 5, 0 };       int[] a2 = { 5 , 9};       int[] a1 = { 10, 15, 18};

        int expectedResult = 2;

        assertEquals("countCollinear(" + Arrays.toString(a1) + "," + Arrays.toString(a2) + "," + Arrays.toString(a3) + ")",     expectedResult, Collinear.countCollinear(a1, a2, a3));
    
    }
    
    @Test
    public void testCollinearFast()
    {
    	int[] a3 = { 5, 0};       int[] a2 = { 5 , 9};       int[] a1 = { 10, 15, 18 };

        int expectedResult = 2;

        assertEquals("countCollinearFast(" + Arrays.toString(a1) + "," + Arrays.toString(a2) + "," + Arrays.toString(a3) + ")", expectedResult, Collinear.countCollinearFast(a1, a2, a3));
    }
    
    @Test
    public void testSort()
    {
    	int[] a = { 5, 0, 2, 312, 311, 4, 33};    

       Collinear.sort(a);
    }
    // TODO: add more tests here. Each line of code and each decision in Collinear.java should
    // be executed at least once from at least one test.

    // ----------------------------------------------------------
    /**
     *  Main Method.
     *  Use this main method to create the experiments needed to answer the experimental performance questions of this assignment.
     *
     *  You should read the lecture notes and/or book to understand how to correctly implement the main methods.
     *  You can use any of the provided classes to read from files, and time your code.
     *
     */
     public static void main(String[] args)
     {
    	/*
    	 In in1001 = new In("r01000-1.txt");
    	 int in1001s[] = in1001.readAllInts(); 	 
    	 In in1002 = new In("r01000-2.txt");
    	 int in1002s[] = in1002.readAllInts();
    	 In in1003 = new In("r01000-3.txt");
    	 int in1003s[] = in1003.readAllInts();
    	 
    	 Stopwatch stopwatch = new Stopwatch();
    	 Collinear.countCollinear(in1001s, in1002s, in1003s);
    	 StdOut.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run countCollinear");
    	 
    	 stopwatch = new Stopwatch();
    	 Collinear.countCollinearFast(in1001s, in1002s, in1003s);
    	 StdOut.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run countCollinearFast");
    	 
    	 In in2001 = new In("r02000-1.txt");
    	 int in2001s[] = in2001.readAllInts();    	 
    	 In in2002 = new In("r02000-2.txt");
    	 int in2002s[] = in2002.readAllInts();    	 
    	 In in2003 = new In("r02000-3.txt");
    	 int in2003s[] = in2003.readAllInts();
    	 
    	 stopwatch = new Stopwatch();
    	 Collinear.countCollinear(in2001s, in2002s, in2003s);
    	 StdOut.println("2000 numbers took " + stopwatch.elapsedTime() + " seconds to run countCollinear");
    	 
    	 stopwatch = new Stopwatch();
    	 Collinear.countCollinearFast(in2001s, in2002s, in2003s);
    	 StdOut.println("2000 numbers took " + stopwatch.elapsedTime() + " seconds to run countCollinearFast");
    	 
    	 In in4001 = new In("r04000-1.txt");
    	 int in4001s[] = in4001.readAllInts();    	 
    	 In in4002 = new In("r04000-2.txt");
    	 int in4002s[] = in4002.readAllInts();    	 
    	 In in4003 = new In("r04000-3.txt");
    	 int in4003s[] = in4003.readAllInts();
    	 
    	 stopwatch = new Stopwatch();
    	 Collinear.countCollinear(in4001s, in4002s, in4003s);
    	 StdOut.println("4000 numbers took " + stopwatch.elapsedTime() + " seconds to run countCollinear");
    	 
    	 stopwatch = new Stopwatch();
    	 Collinear.countCollinearFast(in4001s, in4002s, in4003s);
    	 StdOut.println("4000 numbers took " + stopwatch.elapsedTime() + " seconds to run countCollinearFast");
    	
    	 In in5001 = new In("r05000-1.txt");
    	 int in5001s[] = in5001.readAllInts();    	 
    	 In in5002 = new In("r05000-2.txt");
    	 int in5002s[] = in5002.readAllInts();    	 
    	 In in5003 = new In("r05000-3.txt");
    	 int in5003s[] = in5003.readAllInts();
    	 
    	 stopwatch = new Stopwatch();
    	 Collinear.countCollinear(in5001s, in5002s, in5003s);
    	 StdOut.println("5000 numbers took " + stopwatch.elapsedTime() + " seconds to run countCollinear");
    	 
    	 stopwatch = new Stopwatch();
    	 Collinear.countCollinearFast(in5001s, in5002s, in5003s);
    	 StdOut.println("5000 numbers took " + stopwatch.elapsedTime() + " seconds to run countCollinearFast");
    	 
    	*/
     }

}
