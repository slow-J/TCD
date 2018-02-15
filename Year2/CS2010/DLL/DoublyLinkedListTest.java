import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.assertNull;

import org.junit.Test;
import org.junit.Ignore;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

//-------------------------------------------------------------------------
/**
 *  Test class for Doubly Linked List
 *
 *  @author  
 *  @version 13/10/16 18:15
 */
@RunWith(JUnit4.class)
public class DoublyLinkedListTest
{
    //~ Constructor ........................................................
    @Test
    public void testConstructor()
    {
      new DoublyLinkedList<Integer>();
    }

    //~ Public Methods ........................................................

    // ----------------------------------------------------------
    /**
     * Check if the insertBefore works
     */
    @Test
    public void testInsertBefore()
    {
        // test non-empty list
        DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
        testDLL.insertBefore(0,1);
        testDLL.insertBefore(1,2);
        testDLL.insertBefore(2,3);

        assertEquals( "Checking insertBefore  ", "1,2,3", testDLL.toString() );
        testDLL.insertBefore(0,4);
        assertEquals( "Checking insertBefore to a list containing 3 elements at position 0", "4,1,2,3", testDLL.toString() );
        testDLL.insertBefore(1,5);
        assertEquals( "Checking insertBefore to a list containing 4 elements at position 1", "4,5,1,2,3", testDLL.toString() );
        testDLL.insertBefore(2,6);       
        assertEquals( "Checking insertBefore to a list containing 5 elements at position 2", "4,5,6,1,2,3", testDLL.toString() );
        testDLL.insertBefore(-1,7);        
        assertEquals( "Checking insertBefore to a list containing 6 elements at position -1 - expected the element at the head of the list", "7,4,5,6,1,2,3", testDLL.toString() );
        testDLL.insertBefore(7,8);        
        assertEquals( "Checking insertBefore to a list containing 7 elemenets at position 8 - expected the element at the tail of the list", "7,4,5,6,1,2,3,8", testDLL.toString() );
        testDLL.insertBefore(700,9);        
        assertEquals( "Checking insertBefore to a list containing 8 elements at position 700 - expected the element at the tail of the list", "7,4,5,6,1,2,3,8,9", testDLL.toString() );

        // test empty list
        testDLL = new DoublyLinkedList<Integer>();
        testDLL.insertBefore(0,1);        
        assertEquals( "Checking insertBefore to an empty list at position 0 - expected the element at the head of the list", "1", testDLL.toString() );
        testDLL = new DoublyLinkedList<Integer>();
        testDLL.insertBefore(10,1);        
        assertEquals( "Checking insertBefore to an empty list at position 10 - expected the element at the head of the list", "1", testDLL.toString() );
        testDLL = new DoublyLinkedList<Integer>();
        testDLL.insertBefore(-10,1);        
        assertEquals( "Checking insertBefore to an empty list at position -10 - expected the element at the head of the list", "1", testDLL.toString() );
     }

    // TODO: add more tests here. Each line of code in DoublyLinkedList.java should
    // be executed at least once from at least one test.
    
    @Test
    public void testGet()
    {
    	DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
    	testDLL.get(1);
    	testDLL.get(-1);
		testDLL.insertBefore(0, 1);
		testDLL.get(-1);
		testDLL.insertBefore(1, 2);
		testDLL.get(1);
		testDLL.insertBefore(2, 3);
		testDLL.get(1);
        testDLL.get(4);
    }
    
    @Test
    public void deleteAt()
    {
    	DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
    	testDLL.deleteAt(-1);
		testDLL.insertBefore(0, 1);
		testDLL.deleteAt(-1);
		testDLL.deleteAt(-10);
		testDLL.deleteAt(-15);
		testDLL.deleteAt(1);
		testDLL.deleteAt(0);
		testDLL.insertBefore(0, 1);
		testDLL.insertBefore(1, 2);
        testDLL.deleteAt(1);
        testDLL.deleteAt(1);
        testDLL.deleteAt(0);
        testDLL.deleteAt(7);
        testDLL.deleteAt(0);
		testDLL.insertBefore(0, 1);
		testDLL.insertBefore(1, 2);
        
		testDLL.insertBefore(0, 1);
		testDLL.insertBefore(1, 2);
        testDLL.deleteAt(3);
        testDLL.deleteAt(5);
		testDLL.insertBefore(0, 1);
		testDLL.insertBefore(1, 2);
        testDLL.deleteAt(3);
    }
    
    @Test
    public void testReverse()
    {
    	DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
    	testDLL.reverse();
		testDLL.insertBefore(0, 1);
		testDLL.insertBefore(1, 2);
		testDLL.insertBefore(2, 3);
		testDLL.insertBefore(2, 5);
		testDLL.insertBefore(2, 2);
		testDLL.insertBefore(2, 7);
		assertEquals( "Checking testReverse  ", "1,2,7,2,3,5", testDLL.toString() );
        testDLL.reverse();
        assertEquals( "Checking testReverse  ", "5,3,2,7,2,1", testDLL.toString() );
    }
    
    @Test
    public void testPush()
    {
    	DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
		testDLL.push(1);
		testDLL.insertBefore(1, 2);
		testDLL.insertBefore(2, 3);
        testDLL.push(1);
        assertEquals( "Checking testPush  ", "1,2,3,1", testDLL.toString() );
    }
    
    @Test
    public void testPop()
    {
    	DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
    	testDLL.pop();
		testDLL.insertBefore(0, 1);
		testDLL.pop();
		testDLL.insertBefore(0, 1);
		testDLL.insertBefore(1, 2);
		testDLL.insertBefore(2, 3);
		testDLL.pop();
		testDLL.pop();
		testDLL.pop();
		testDLL.pop();
		testDLL.insertBefore(1, 2);
		testDLL.insertBefore(2, 3);
		testDLL.pop();
		testDLL.pop();
    }
    
    @Test
    public void testEnqueue()
    {
    	DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
		testDLL.insertBefore(0, 1);
		testDLL.insertBefore(1, 2);
		testDLL.insertBefore(2, 3);
        testDLL.enqueue(1);
        assertEquals( "Checking testEnqueue  ", "1,2,3,1", testDLL.toString() );
    }
    
    @Test
    public void testDequeue()
    {
    	DoublyLinkedList<Integer> testDLL = new DoublyLinkedList<Integer>();
    	testDLL.dequeue();
		testDLL.insertBefore(0, 1);
		testDLL.dequeue();
		testDLL.insertBefore(0, 1);
		testDLL.insertBefore(1, 2);
		testDLL.insertBefore(2, 3);
        testDLL.dequeue();
        assertEquals( "Checking testDequeue  ", "2,3", testDLL.toString() );
    }
}
