import java.util.Arrays;
// -------------------------------------------------------------------------
/**
 *  This class contains only two static methods that search for points on the
 *  same line in three arrays of integers. 
 *
 *  @author  Jslow
 *  @version 03/10/16 17:10:35
 */
class Collinear
{
	private static int[] a1 = new int [0];		//y=1
	private static int[] a2 = new int [0];		//y=2
	private static int[] a3 = new int [0];		//y=3
	int collinears = countCollinear( a1, a2, a3);
	int collinearsFast = countCollinearFast(a1, a2, a3);
   // ----------------------------------------------------------
    /**
     * Counts for the number of non-horizontal lines that go through 3 points in arrays a1, a2, a3.
     * This method is static, thus it can be called as Collinear.countCollinear(a1,a2,a3)
     * @param a1: An UNSORTED array of integers. Each integer a1[i] represents the point (a1[i], 1) on the plain.
     * @param a2: An UNSORTED array of integers. Each integer a2[i] represents the point (a2[i], 2) on the plain.
     * @param a3: An UNSORTED array of integers. Each integer a3[i] represents the point (a3[i], 3) on the plain.
     * @return the number of points which are collinear and do not lie on a horizontal line.
     *
     * Array a1, a2 and a3 contain points on the horizontal line y=1, y=2 and y=3, respectively.
     * A non-horizontal line will have to cross all three of these lines. Thus
     * we are looking for 3 points, each in a1, a2, a3 which lie on the same
     * line.
     *
     * Three points (x1, y1), (x2, y2), (x3, y3) are collinear (i.e., they are on the same line) if
     * 
     * x1(y2âˆ’y3)+x2(y3âˆ’y1)+x3(y1âˆ’y2)=0 
     *
     * In our case y1=1, y2=2, y3=3.
     *
     * You should implement this using a BRUTE FORCE approach (check all possible combinations of numbers from a1, a2, a3)
     *
     * ----------------------------------------------------------
     *
     * Experimental Performance:
     * -------------------------
     *  Write the running time of the algorithm when run with the following input sizes
     *  
     *  Input Size N      Running Time (sec)
     *  ------------------------------------
     *  1000              0.322
     *  2000              2.8
     *  4000              16.909
     *
     *  Assuming that the running time of your algorithm is of the form aN^b,
     *  estimate 'b' and 'a' by fitting a line to the experimental points:
     *
     *  b = 2.132
     *  a = 2.56x10^-7
     *
     *  What running time do you predict using your results for input size 5000?
     *  What is the actual running time you get with such an input?
     *  What is the error in percentage?
     *
     *  Error = ( (Actual time) - (Predicted time) ) * 100 / (Predicted time)
     *
     *  Input Size N      Predicted Running Time (sec)        Actual Running Time (sec)       Error (%)
     *  ------------------------------------------------------------------------------------------------
     *  5000              19.689                              32.814                          66.66
     * 
     *  Order of Growth
     *  -------------------------
     *
     *  Calculate and write down the order of growth of your algorithm. You can use the asymptotic notation.
     *  You should adequately explain your answer. Answers without adequate explanation will not be counted.
     *
     *  Order of growth:  θ (N^3).  It has cubic complexity
     *
     *  Explanation: a triple nested and an if statement makes the order of growth a N^3
     */
    static int countCollinear(int[] a1, int[] a2, int[] a3)
    {
       /*Three points (x1, y1), (x2, y2), (x3, y3) are collinear (i.e., they are on the same line)
    	*if x1*(y2-y3) + x2*(y3-y1) + x3*(y1-y2)=0
        */
    	int collinearCount = 0;
    	int y1 = 1;
    	int y2 = 2;
    	int y3 = 3;
    	
    	for (int count1 =0; count1 < a1.length; count1++)
    	{
    		for (int count2 =0; count2 < a2.length; count2++)
        	{
    			for (int count3 =0; count3 < a3.length; count3++)
    	    	{
    				if (a1[count1]*(y2-y3) + a2[count2]*(y3-y1) + a3[count3]*(y1-y2)==0)
    					collinearCount++;
    	    	}
        	}
    	}    	
    	
    	return collinearCount;
    }

    // ----------------------------------------------------------
    /**
     * Counts for the number of non-hoizontal lines that go through 3 points in arrays a1, a2, a3.
     * This method is static, thus it can be called as Collinear.countCollinearFast(a1,a2,a3)
     * @param a1: An UNSORTED array of integers. Each integer a1[i] represents the point (a1[i], 1) on the plain.
     * @param a2: An UNSORTED array of integers. Each integer a2[i] represents the point (a2[i], 2) on the plain.
     * @param a3: An UNSORTED array of integers. Each integer a3[i] represents the point (a3[i], 3) on the plain.
     * @return the number of points which are collinear and do not lie on a horizontal line.
     *
     * In this implementation you should make non-trivial use of InsertionSort and Binary Search.
     * The performance of this method should be much better than that of the above method.
     *
     * Experimental Performance:
     * -------------------------
     *  Measure the running time of the algorithm when run with the following input sizes
     *  
     *  Input Size N      Running Time (sec)
     *  ------------------------------------
     *  1000              0.049
     *  2000              0.226
     *  4000              1.0
     *  5000              1.602
     *
     *
     *  Compare Implementations:
     *  ------------------------
     *  Show the sppedup achieved by this method, using the times you got from your experiments.
     *
     *  Input Size N      Speedup = (time of countCollinear)/(time of countCollinearFast)
     *  ---------------------------------------------------------------------------------
     *  1000              6.5714
     *  2000              12.389
     *  4000              16.909
     *  5000              20.483
     *
     *
     *  Order of Growth
     *  -------------------------
     *
     *  Caclulate and write down the order of growth of your algorithm. You can use the asymptotic notation.
     *  You should adequately explain your answer. Answers without adequate explanation will not be counted.
     *
     *  Order of Growth:  θ (N^2)
     *
     *  Explanation: double nested loops. It has quadratic complexity
     *
     *
     */
    static int countCollinearFast(int[] a1, int[] a2, int[] a3)
    {
        //TODO: implement this method
    	sort(a2);
    	
    	int check;
    	int collinearCount = 0;
       /*if a1*(2-3) + a2*(3-1) + a3*(1-2) == 0
    	*if a1*(-1) + a2*2 + a3*(-1) == 0
    	*if -a1 + 2a2 - a3 == 0
    	*if 2a2 == a1 + a3
    	*if a2 == (a1 + a3) /2
    	*/
    	for (int count1 =0; count1 < a1.length; count1++)
    	{
    		for (int count3 =0; count3 < a3.length; count3++)
        	{
    			check = (a1[count1]+ a3[count3]) /2;
    			if (binarySearch(a2, check) == true)
    				collinearCount++;
    			
        	}	
    	}
    	
    	return collinearCount;
    }

    // ----------------------------------------------------------
    /**
     * Sorts an array of integers according to InsertionSort.
     * This method is static, thus it can be called as Collinear.sort(a)
     * @param a: An UNSORTED array of integers. 
     * @return after the method returns, the array must be in ascending sorted order.
     *
     * ----------------------------------------------------------
     *
     * Approximate Mathematical Performance:
     * -------------------------------------
     *  Using an appropriate cost model, give the performance of your algorithm.
     *  Explain your answer.
     *
     *  Performance:  θ (N^2)
     *
     *  Explanation: the 2 for loops make it N^2. It has quadratic complexity
     *  
     *  
     *  
     *
     */
    static void sort(int[] a)
    {
    	int sort;
        for (int i = 1; i < a.length; i++)
        {
        	for(int k = i ; k > 0 ; k--)
        	{
        		if(a[k] < a[k-1])
        		{
        			sort = a[k];
        			a[k] = a[k-1];
        			a[k-1] = sort;
                }
            }
        }
    }

    // ----------------------------------------------------------
    /**
     * Searches for an integer inside an array of integers.
     * This method is static, thus it can be called as Collinear.binarySearch(a,x)
     * @param a: A array of integers SORTED in ascending order.
     * @param x: An integer.
     * @return true if 'x' is contained in 'a'; false otherwise.
     *
     * ----------------------------------------------------------
     *
     * Approximate Mathematical Performance:
     * -------------------------------------
     *  Using an appropriate cost model, give the performance of your algorithm.
     *  Explain your answer.
     *
     *  Performance:  θ (log2 * N)
     *
     *  Explanation: how many times do we have to divide N by 2 to get the answer
     *    1 = N / 2x
     *    x * 1  = log2 N
     *    This has logarithmic complexity
     */
    static boolean binarySearch(int[] a, int x)
    {
    	//from notes
    	int lo = 0;
    	int hi = a.length-1;
    	while (hi >= lo)
    	{
    		int mid = (int) ((lo + hi) / 2);
    		if (x == a[mid])
    			return true;
    		else
    		{
    			if (x < a[mid])
    				hi = mid - 1;
    			else 
    				lo = mid + 1;
    		}
    	}
    	return false;
    }

}