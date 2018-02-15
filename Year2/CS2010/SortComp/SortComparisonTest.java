import static org.junit.Assert.assertEquals;

import java.util.Arrays;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;
	
//-------------------------------------------------------------------------
/**
 *  Test class for SortComparison.java
 *
 *  @author Jakub Slowinski
 *  @version HT 2018
 *  
 *  *  
 *  
 *		       | Insert  | Quick  | Merge  | Shell  | Selection | Bubble  | all in nanoseconds from stopwatch.java
 * --------------------|---------|--------|--------|--------|-----------|---------|---------------------------------------------
 * 10 random	       | 35470   | 12075  | 9660   | 3018   | 3622      | 3321    |	
 * 100 random	       | 91769   | 41658  | 95090  | 13886  | 127994    | 152446  |
 * 1000 random	       | 3545192 | 427150 | 633329 | 134031 | 247767    | 2522146 | 
 * 1000 few unique     | 721777  | 121957 | 186859 | 143691 | 237272    | 2191293 |
 * 1000 nearly ordered | 140673  | 89052  | 138559 | 140975 | 1281147   | 217348  | 
 * 1000 reverse order  | 4783171 | 486619 | 105958 | 140673 | 151238    | 190481  |
 * 1000 sorted	       | 9962.0  | 580501 | 81506  | 136447 | 150030    | 164219  |
 *
 * Also, in the comment at the top of your SortComparisonTest file please answer the following
 * questions:
 * 1. Which of the sorting algorithms does the order of input have an impact on? Why?
 * 2. Which algorithm has the biggest difference between the best and worst performance, based
 * on the type of input, for the input of size 1000? Why?
 * 3. Which algorithm has the best/worst scalability, ie, the difference in performance time based
 * on the input size? Please consider only input files with random order for this answer.
 * 4. Which algorithm is the fastest for each of the 7 input files? 
 *
 * Answers:
 *
 * 1. selection sort is the algorithm that the order of input has a big impact on as it doesnt handle nearly sorted arrays well.
 * 
 * 2. bubble sort has the biggest difference between the best and worst performance from 2191293 to 164219.  *
 *  
 * 3. shell sort had the best scalibility as it remained quick throughout all the tests.
 *    insertion sort hasd the worst as it sorted 10 values in 35470 and 1000 in 3545192
 * 
 * 4. 10 random = shell sort 3018 ns
 *    100 random = shell sort 13886 ns
 *    1000 random = shell sort 134031 ns
 *    1000 few unique = quick sort 121957 ns
 *    1000 nearly ordered = quick sort 89052 ns
 *    1000 reverse order = merge sort 105958 ns
 *    1000 sorted = insertion sort 9962 ns
 */
 
@RunWith(JUnit4.class)
public class SortComparisonTest
{
	
	private static double[] testA = {1.0, 100.0, 3018.3223, 22.1,911.0,213.66, 2.0, 0.2, 33.1, 0.4, 1.0,
			22.0, 12.435, 123123.123213, 123.11, 99.0, 0.0, 121.1};
	private static double[] testB =  
		    { 99.0, 85.0, 98.0, 0.0 , 98.0, 57.0, 79.0, 0.0 , 
		      92.0, 77.0, 74.0, 0.0 , 94.0, 62.0, 81.0, 0.0 , 
		      99.0, 94.0, 92.0, 0.0 , 80.0, 76.5, 67.0, 0.0 , 
		      76.0, 58.5, 90.5, 0.0 , 92.0, 66.0, 91.0, 0.0 , 
		      97.0, 70.5, 66.5, 0.0 , 89.0, 89.5, 81.0, 0.0 };
	double[] finA = testA.clone(); 
	double[] finB = testB.clone();
	 
    //~ Constructor ........................................................
    @Test
    public void testConstructor()
    {
        new SortComparison();
    }

    //~ Public Methods ........................................................

    // ----------------------------------------------------------
    /**
     * Check that the methods work for empty arrays
     */
    @Test
    public void testEmpty()
    {
    }
    
    @Test
    public void testInsertionSort() 
    {    	    	
    	finA = SortComparison.insertionSort(testA); 
    	finB = SortComparison.insertionSort(testB); 
    } 
    
    @Test
    public void testQuickSort() 
    {    	
    	finA = SortComparison.quickSort(testA); 
    	finB = SortComparison.insertionSort(testB); 
    } 
    
    @Test
    public void testMergeSort() 
    {    	
    	finA = SortComparison.mergeSort(testA);
    	finB = SortComparison.insertionSort(testB); 
    }
    
    @Test
    public void testShellSort() 
    {  
    	finA = SortComparison.shellSort(testA);
    	finB = SortComparison.insertionSort(testB); 
    } 
    
    @Test
    public void testSelectionSort() 
    {    	
    	finA = SortComparison.selectionSort(testA);
    	finB = SortComparison.insertionSort(testB); 
    }
    
    @Test
    public void testBubbleSort() 
    {    	
    	finA = SortComparison.bubbleSort(testA);
    	finB = SortComparison.insertionSort(testB); 
    } 
    // TODO: add more tests here. Each line of code and ech decision in Collinear.java should
    // be executed at least once from at least one test.

    // ----------------------------------------------------------
    /**
     *  Main Method.
     *  Use this main method to create the experiments needed to answer the experimental performance questions of this assignment.
     *
     */
    public static void main(String[] args)
    {
/*
    	In ten = new In("numbers10.txt");
    	In hundred = new In("numbers100.txt");
    	In thousand = new In("numbers1000.txt");
		In thousandDupe = new In("numbers1000Duplicates.txt");
		In nearOrdered1000 = new In("numbersNearlyOrdered1000.txt");
		In reverse1000 = new In("numbersReverse1000.txt");
		In sorted1000 = new In("numbersSorted1000.txt");
	
		double[] tenA = ten.readAllDoubles();
		double[] hundredA = hundred.readAllDoubles();
		double[] thousandA = thousand.readAllDoubles();
		double[] thousandDupeA =thousandDupe.readAllDoubles();
		double[] nearOrdered1000A = nearOrdered1000.readAllDoubles();
		double[] reverse1000A = reverse1000.readAllDoubles();
		double[] sorted1000A = sorted1000.readAllDoubles(); 
	
		double[] test10;
		double[] test100;
		double[] test1000;
    	Stopwatch stopwatch = new Stopwatch();
    	test10 = SortComparison.insertionSort(tenA); 
    	System.out.println("10 numbers took " + stopwatch.elapsedTime() + " seconds to run insertionSort");
    	
    	stopwatch = new Stopwatch();
    	test10 = SortComparison.quickSort(tenA); 
    	System.out.println("10 numbers took " + stopwatch.elapsedTime() + " seconds to run quickSort");
    	
    	stopwatch = new Stopwatch();
    	test10 = SortComparison.mergeSort(tenA); 
    	System.out.println("10 numbers took " + stopwatch.elapsedTime() + " seconds to run mergeSort");
    	
    	stopwatch = new Stopwatch();
    	test10 = SortComparison.shellSort(tenA); 
    	System.out.println("10 numbers took " + stopwatch.elapsedTime() + " seconds to run shellSort");
    	
    	stopwatch = new Stopwatch();
    	test10 = SortComparison.selectionSort(tenA); 
    	System.out.println("10 numbers took " + stopwatch.elapsedTime() + " seconds to run selectionSort");
    	
    	stopwatch = new Stopwatch();
    	test10 = SortComparison.bubbleSort(tenA); 
    	System.out.println("10 numbers took " + stopwatch.elapsedTime() + " seconds to run bubbleSort");
    	
    	///////////////////////////////////////////
    	
    	stopwatch = new Stopwatch();
    	test100 = SortComparison.insertionSort(hundredA); 
    	System.out.println("100 numbers took " + stopwatch.elapsedTime() + " seconds to run insertionSort");
    	
    	stopwatch = new Stopwatch();
    	test100 = SortComparison.quickSort(hundredA); 
    	System.out.println("100 numbers took " + stopwatch.elapsedTime() + " seconds to run quickSort");
    	
    	stopwatch = new Stopwatch();
    	test100 = SortComparison.mergeSort(hundredA); 
    	System.out.println("100 numbers took " + stopwatch.elapsedTime() + " seconds to run mergeSort");
    	
    	stopwatch = new Stopwatch();
    	test100 = SortComparison.shellSort(hundredA); 
    	System.out.println("100 numbers took " + stopwatch.elapsedTime() + " seconds to run shellSort");
    	
    	stopwatch = new Stopwatch();
    	test100 = SortComparison.selectionSort(hundredA); 
    	System.out.println("100 numbers took " + stopwatch.elapsedTime() + " seconds to run selectionSort");

		stopwatch = new Stopwatch();
		test100 = SortComparison.bubbleSort(hundredA);
		System.out.println("100 numbers took " + stopwatch.elapsedTime() + " seconds to run bubbleSort");
		
		///////////////////////////////////////////
		
		stopwatch = new Stopwatch();		
		test1000 = SortComparison.insertionSort(thousandA);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run insertionSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.quickSort(thousandA);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run quickSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.mergeSort(thousandA);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run mergeSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.shellSort(thousandA);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run shellSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.selectionSort(thousandA);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run selectionSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.bubbleSort(thousandA);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run bubbleSort");
		
		///////////////////////////////////////////
		
		stopwatch = new Stopwatch();
		test1000 = SortComparison.insertionSort(thousandDupeA);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run insertionSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.quickSort(thousandDupeA);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run quickSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.mergeSort(thousandDupeA);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run mergeSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.shellSort(thousandDupeA);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run shellSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.selectionSort(thousandDupeA);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run selectionSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.bubbleSort(thousandDupeA);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run bubbleSort");
		
		///////////////////////////////////////////
		
		stopwatch = new Stopwatch();
		test1000 = SortComparison.insertionSort(nearOrdered1000A);
		System.out.println("1000 nearly sorted numbers took " + stopwatch.elapsedTime() + " seconds to run insertionSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.quickSort(nearOrdered1000A);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run quickSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.mergeSort(nearOrdered1000A);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run mergeSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.shellSort(nearOrdered1000A);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run shellSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.selectionSort(nearOrdered1000A);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run selectionSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.bubbleSort(nearOrdered1000A);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run bubbleSort");

		///////////////////////////////////////////
		
		stopwatch = new Stopwatch();
		test1000 = SortComparison.insertionSort(reverse1000A);
		System.out.println("1000 reversed numbers took " + stopwatch.elapsedTime() + " seconds to run insertionSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.quickSort(reverse1000A);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run quickSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.mergeSort(reverse1000A);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run mergeSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.shellSort(reverse1000A);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run shellSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.selectionSort(reverse1000A);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run selectionSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.bubbleSort(reverse1000A);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run bubbleSort");

		///////////////////////////////////////////
		
		stopwatch = new Stopwatch();
		test1000 = SortComparison.insertionSort(sorted1000A);
		System.out.println("1000 sorted numbers took " + stopwatch.elapsedTime() + " seconds to run insertionSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.quickSort(sorted1000A);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run quickSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.mergeSort(sorted1000A);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run mergeSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.shellSort(sorted1000A);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run shellSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.selectionSort(sorted1000A);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run selectionSort");

		stopwatch = new Stopwatch();
		test1000 = SortComparison.bubbleSort(sorted1000A);
		System.out.println("1000 numbers took " + stopwatch.elapsedTime() + " seconds to run bubbleSort");
*/    	
    }

}
