import java.util.Arrays;

// -------------------------------------------------------------------------

/**
 *  This class contains static methods that implementing sorting of an array of numbers
 *  using different sort algorithms.
 *
 *  @author
 *  @version HT 2018
 */

 class SortComparison 
 {

    /**
	 * Sorts an array of doubles using InsertionSort. This method is static,
	 * thus it can be called as SortComparison.sort(a)
	 * 
	 * @param a:
	 *            An unsorted array of doubles.
	 * @return array sorted in ascending order.
	 *
	 */
	public static double[] insertionSort(double a[]) 
	{
		double array1[] = a.clone();
		int n = array1.length;  
        for (int j = 1; j < n; j++) 
        {  
            double key = array1[j];  
            int i = j-1;  
            while ( (i > -1) && ( array1[i] > key ) ) 
            {  
                array1[i+1] = array1[i];  
                i--;  
            }  
            array1[i+1] = key;  
        }  
		return array1;
	}	
	// end insertionsort

    /**
     * Sorts an array of doubles using Quick Sort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     * @param a: An unsorted array of doubles.
     * @return array sorted in ascending order
     *
     */
    public static double [] quickSort (double a[])
    {
    	double array1[] = a.clone();
    	recursiveQuickSort(array1, 0, array1.length - 1);
    	return array1;
    }
    public static void recursiveQuickSort(double[] array, double start, double end) 
    {
    	double idx = partition(array, (int)start, (int)end); 
    	if (start < idx - 1) 
    		recursiveQuickSort(array, start, idx - 1); 
    	
    	if (end > idx) 
    		recursiveQuickSort(array, (int)idx, (int)end); 
    }
    public static double partition(double[] array, int left, int right) 
    {
    	double pivot = array[left]; // taking first element as pivot
    	while (left <= right) 
    	{	 
    		//searching number which is greater than pivot, bottom up 
    		while ((double)array[left] < pivot)
    			left++;
    		//searching number which is less than pivot, top down 
    		while ((double)array[right] > pivot)
    			right--;   		
    		// swapping values 
    		if (left <= right) 
    		{ 
    			double tmp = array[left]; 
    			array[left] = array[right];
    			array[right] = tmp; //increment left index and decrement right index
    			left++;
    			right--;
    		}
    	}	
		return left;
	}
	// end quicksort

	/**
	 * Sorts an array of doubles using Merge Sort. This method is static, thus
	 * it can be called as SortComparison.sort(a)
	 * 
	 * @param a:
	 *            An unsorted array of doubles.
	 * @return array sorted in ascending order
	 *
	 */
	public static double[] mergeSort(double a[]) 
	{
		int firstIndex = 0;
		int lastIndex = a.length - 1;
		if (firstIndex < lastIndex) 
		{
			int middleElelemnt = (firstIndex + lastIndex) / 2;
			mergeSort(a, firstIndex, middleElelemnt);
			mergeSort(a, middleElelemnt + 1, lastIndex);
			merge(a, firstIndex, middleElelemnt, lastIndex);
		}
		return a;
	}
	public static double[] mergeSort(double a[], int firstIndex, int lastIndex) {

		if (firstIndex < lastIndex) {

			int middleElelemnt = (firstIndex + lastIndex) / 2;

			mergeSort(a, firstIndex, middleElelemnt);
			mergeSort(a, middleElelemnt + 1, lastIndex);

			merge(a, firstIndex, middleElelemnt, lastIndex);
		}
		return a;
	}
	public static void merge(double a[], int firstIndex, int middleElement, int lastIndex) {

		int indexArrayOne = middleElement - firstIndex + 1;
		int indexArrayTwo = lastIndex - middleElement;

		double LeftArray[] = new double[indexArrayOne];
		double RightArray[] = new double[indexArrayTwo];

		for (int i = 0; i < indexArrayOne; ++i) 
		{
			LeftArray[i] = a[firstIndex + i];
		}

		for (int j = 0; j < indexArrayTwo; ++j) 
		{
			RightArray[j] = a[middleElement + 1 + j];
		}

		int i = 0;
		int j = 0;
		int k = firstIndex;

		while (i < indexArrayOne && j < indexArrayTwo) {

			if (LeftArray[i] <= RightArray[j]) {

				a[k] = LeftArray[i];
				i++;
			} else {

				a[k] = RightArray[j];
				j++;
			}
			k++;
		}

		while (i < indexArrayOne) {

			a[k] = LeftArray[i];
			i++;
			k++;
		}

		while (j < indexArrayTwo) {

			a[k] = RightArray[j];
			j++;
			k++;
		}

	}

	// end mergesort

	/**
	 * Sorts an array of doubles using Shell Sort. This method is static, thus
	 * it can be called as SortComparison.sort(a)
	 * 
	 * @param a:
	 *            An unsorted array of doubles.
	 * @return array sorted in ascending order
	 *
	 */

	public static double[] shellSort(double a[]) 
	{
		double array1[] = a.clone();
		double temp;

		int j;
		for (int gap = array1.length / 2; gap > 0; gap /= 2) {
			for (int i = gap; i < array1.length; i++) 
			{
				temp = array1[i];
				for (j = i; j >= gap && Double.compare(temp, array1[j - gap]) < 0; j -= gap) 
				{
					array1[j] = array1[j - gap];
				}
				array1[j] = temp;
			}
		}
		return array1;
	}

	// end shellsort

	/**
	 * Sorts an array of doubles using Selection Sort. This method is static,
	 * thus it can be called as SortComparison.sort(a)
	 * 
	 * @param a:
	 *            An unsorted array of doubles.
	 * @return array sorted in ascending order
	 *
	 */
    static double [] selectionSort (double a[])
    {
    	double array1[] = a.clone();
        for (int i = 0; i < array1.length - 1; i++)  
        {  
            int index = i;  
            for (int j = i + 1; j < array1.length; j++){  
                if (array1[j] < array1[index]){  
                    index = j;//searching for lowest index  
                }  
            }  
            double smallerNumber = array1[index];   
            array1[index] = array1[i];  
            array1[i] = smallerNumber;  
        }  
        return array1;
    }//end selectionsort

    /**
     * Sorts an array of doubles using Bubble Sort.
     * This method is static, thus it can be called as SortComparison.sort(a)
     * @param a: An unsorted array of doubles.
     * @return array sorted in ascending order
     *
     */
    static double [] bubbleSort (double a[])
    {
      double array1[] = a.clone();
		  int n = array1.length;
		  double temp = 0.0;
		  for (int i = 0; i < n; i++) 
		  {
			  for (int j = 1; j < (n - i); j++) 
		  	{
			  	if (array1[j - 1] > array1[j])
			  	{
			  		temp = array1[j - 1];
			  		array1[j - 1] = array1[j];
			  		array1[j] = temp;
			  	}
			  }
		  }
		  return array1;  
		}// end bubblesort


    public static void main(String[] args) 
    {

        //todo: do experiments as per assignment instructions
    }

 }//end class
