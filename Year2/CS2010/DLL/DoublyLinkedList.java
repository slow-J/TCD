import java.util.Iterator;
import java.util.ListIterator;
import java.util.NoSuchElementException;

// -------------------------------------------------------------------------
/**
 *  This class contains the methods of Doubly Linked List.
 *
 *  @author jakub slowinski 
 *  @version 23/10/17 16:24
 */

/**
 * Class DoublyLinkedList: implements a *generic* Doubly Linked List.
 * 
 * @param <T>
 *            This is a type parameter. T is used as a class name in the
 *            definition of this class.
 *
 *            When creating a new DoublyLinkedList, T should be instantiated
 *            with an actual class name that extends the class Comparable. Such
 *            classes include String and Integer.
 *
 *            For example to create a new DoublyLinkedList class containing
 *            String data: DoublyLinkedList<String> myStringList = new
 *            DoublyLinkedList<String>();
 *
 *            The class offers a toString() method which returns a
 *            comma-separated sting of all elements in the data structure.
 * 
 *            This is a bare minimum class you would need to completely
 *            implement. You can add additional methods to support your code.
 *            Each method will need to be tested by your jUnit tests -- for
 *            simplicity in jUnit testing introduce only public methods.
 */
class DoublyLinkedList<T extends Comparable<T>> 
{

	/**
	 * private class DLLNode: implements a *generic* Doubly Linked List node.
	 */
	private class DLLNode {
		public final T data; // this field should never be updated. It gets its
								// value once from the constructor DLLNode.
		public DLLNode next;
		public DLLNode prev;

		/**
		 * Constructor
		 * 
		 * @param theData
		 *            : data of type T, to be stored in the node
		 * @param prevNode
		 *            : the previous Node in the Doubly Linked List
		 * @param nextNode
		 *            : the next Node in the Doubly Linked List
		 * @return DLLNode
		 */
		public DLLNode(T theData, DLLNode prevNode, DLLNode nextNode) {
			data = theData;
			prev = prevNode;
			next = nextNode;
		}
	}

	// Fields head and tail point to the first and last nodes of the list.
	private DLLNode head, tail;

	/**
	 * Constructor
	 * 
	 * @return DoublyLinkedList
	 */
	public DoublyLinkedList() 
	{
		head = null;
		tail = null;
	}

	/**
	 * Tests if the doubly linked list is empty
	 * 
	 * @return true if list is empty, and false otherwise
	 *
	 *         Worst-case asymptotic runtime cost: Θ(1)
	 *
	 *         Justification: constant asymptotic running time as its one line and doesnt depend on input size
	 */
	public boolean isEmpty() 
	{
		return (head == null);
	}
	
	/**
	 * Inserts an element in the doubly linked list
	 * 
	 * @param pos
	 *            : The integer location at which the new data should be
	 *            inserted in the list. We assume that the first position in the
	 *            list is 0 (zero). If pos is less than 0 then add to the head
	 *            of the list. If pos is greater or equal to the size of the
	 *            list then add the element at the end of the list.
	 * @param data
	 *            : The new data of class T that needs to be added to the list
	 * @return none
	 *
	 *         Worst-case asymptotic runtime cost: Θ(N)
	 *
	 *         Justification: linear asymptotic running as the function contains one for loop
	 */
	public void insertBefore(int pos, T data) 
	{
		if (isEmpty()) 
		{
			DLLNode newNode = new DLLNode(data, null, null);
			head = newNode;
			tail = newNode;
		} 
		else if (pos <= 0) 
		{
			DLLNode newNode = new DLLNode(data, null, head); // makes newNode the last head
			head.prev = newNode; // makes the previousNode of last head = newNode
			head = newNode; // makes the newNode = the head node
		} 
		
		else
		{
			DLLNode fin;
			DLLNode tmp = head;
			for (int i = 0; i < pos; i++) 
			{
				if (tmp.next != null)
				{
					tmp =tmp.next;
				}
			}
			if (pos==1)
			{
				if (tmp.next != null)
					fin = new DLLNode(data, head, tmp.next.prev);
				else
					fin = new DLLNode(data, head, null);
			}
			else
			{
				if (tmp.next != null)
					fin = new DLLNode(data, tmp.prev, tmp.next.prev);
				else
					fin = new DLLNode(data, tmp.prev, null);
			}
			if (fin.next == null)
			{
				tail.next = fin;
				fin.prev = tail;
				tail = fin;
			}
			else
			{
				fin.prev.next = fin;
				fin.next.prev = fin;
			}
		}
	}

	/**
	 * Returns the data stored at a particular position
	 * 
	 * @param pos
	 *            : the position
	 * @return the data at pos, if pos is within the bounds of the list, and
	 *         null otherwise.
	 *
	 *         Worst-case asymptotic runtime cost: Θ(N)
	 *
	 *         Justification: one for loop so linear asymptotic notation
	 *
	 */
	public T get(int pos) 
	{
		
		if (isEmpty())
			return null;
		else
		{
			if (pos<0)
				return null;
			DLLNode newNode;
			newNode = head;
			for (int i = 0; i < pos; i++)
			{
				if (newNode.next!=null)
					newNode = newNode.next;
				else
					return null;
			}
			return newNode.data;
		}
	}

	/**
	 * Deletes the element of the list at position pos. First element in the
	 * list has position 0. If pos points outside the elements of the list then
	 * no modification happens to the list.
	 * 
	 * @param pos
	 *            : the position to delete in the list.
	 * @return true : on successful deletion, false : list has not been
	 *         modified.
	 *
	 *         Worst-case asymptotic runtime cost: Θ(N)
	 *
	 *         Justification: linear as one for loop
	 */
	public boolean deleteAt(int pos) 
	{
		
		if (isEmpty()==false)
		{
			
			if (pos<0)
				return false;
			
			if (pos==0)
			{
				if (head.next!=null)
				{
					head = head.next;
					head.prev = null;
				}
				else
				{
					head=null;
					tail=null;					
				}
				return true;
			}
			boolean broken = false;
			DLLNode tmp;
			if (head.next != null) 
			{
				tmp = new DLLNode(null, head, head.next);
			} 
			else 
			{
				tmp = new DLLNode(null, head, null);
			}
			for (int i = 0; i < pos; i++) 
			{
				if (tmp.next != null) 
				{
					tmp = tmp.next;
				} 
				else
					return false;

			}
			
			if (tmp.next!=null)
				tmp.prev.next = tmp.next;
			
			else
			{
				tail = tmp;
				tmp.prev.next = tail;
				
			}
			return true;
			
		}
		return false;
	}

	/**
	 * Reverses the list. If the list contains "A", "B", "C", "D" before the
	 * method is called Then it should contain "D", "C", "B", "A" after it
	 * returns.
	 *
	 * Worst-case asymptotic runtime cost: O(1)
	 *
	 * Justification: An algorithm is said to run in constant time if it 
	 *         requires the same amount of time regardless of the input size.
	 */
	public void reverse() 
	{
		DLLNode temp;
		if (isEmpty()==false)
		{
			DLLNode current = head;
			temp = new DLLNode(null, null, null);
			while (current != null) 
			{
				temp = current.prev; // swap the next and prev pointer
				current.prev = current.next;
				current.next = temp;
				current = current.prev;
			}
		}
		temp = head;
		head = tail;
		tail = temp;
		
	}

	/*----------------------- STACK */
	/**
	 * This method should behave like the usual push method of a Stack ADT. If
	 * only the push and pop methods are called the data structure should behave
	 * like a stack. How exactly this will be represented in the Doubly Linked
	 * List is up to the programmer.
	 * 
	 * @param item
	 *            : the item to push on the stack
	 *
	 *            Worst-case asymptotic runtime cost: Θ(1)
	 *
	 *            Justification: constant running time as no for loops
	 */
	public void push(T item) 
	{
		if (isEmpty()==false)
		{
			DLLNode fin = new DLLNode(item, tail, null);
			tail.next = fin;
			tail = fin;
		}
		else
		{
			DLLNode fin = new DLLNode(item, null, null);
			head = fin;
			tail = fin;
			
		}

	}

	/**
	 * This method should behave like the usual pop method of a Stack ADT. If
	 * only the push and pop methods are called the data structure should behave
	 * like a stack. How exactly this will be represented in the Doubly Linked
	 * List is up to the programmer.
	 * 
	 * @return the last item inserted with a push; or null when the list is
	 *         empty.
	 *
	 *         Worst-case asymptotic runtime cost: O(1)
	 *
	 *         Justification: An algorithm is said to run in constant time if it 
	 *         requires the same amount of time regardless of the input size.
	 */
	public T pop() 
	{
		if (isEmpty()==false)
		{
			DLLNode fin;
			int count=0;
			DLLNode newNode;
			newNode = head;
			while (newNode.next!=null)
			{
				newNode = newNode.next;
				count++;
			}
			if (count==0)
			{
				fin=head;
				head=null;
				tail=null;
			}
			else
			{
				fin = tail;		
				tail = tail.prev;				
				tail.next = null;

			}
			return fin.data;
		}
		return null;
	}

	/*----------------------- QUEUE */

	/**
	 * This method should behave like the usual enqueue method of a Queue ADT.
	 * If only the enqueue and dequeue methods are called the data structure
	 * should behave like a FIFO queue. How exactly this will be represented in
	 * the Doubly Linked List is up to the programmer.
	 * 
	 * @param item
	 *            : the item to be enqueued to the stack
	 *
	 *            Worst-case asymptotic runtime cost: Θ(1)
	 *
	 *            Justification: An algorithm is said to run in constant time if it 
	 *         requires the same amount of time regardless of the input size.
	 */
	public void enqueue(T item)
	{
		insertBefore(Integer.MAX_VALUE, item);
	}

	/**
	 * This method should behave like the usual dequeue method of a Queue ADT.
	 * If only the enqueue and dequeue methods are called the data structure
	 * should behave like a FIFO queue. How exactly this will be represented in
	 * the Doubly Linked List is up to the programmer.
	 * 
	 * @return the earliest item inserted with a push; or null when the list is
	 *         empty.
	 *
	 *         Worst-case asymptotic runtime cost: O(1)
	 *
	 *         Justification: An algorithm is said to run in constant time if it 
	 *         requires the same amount of time regardless of the input size.
	 */
	public T dequeue() 
	{
		
		if (isEmpty())
			return null;
		
		if (head==tail)
		{
			DLLNode fin = head;
			head=null;
			tail=null;
			return fin.data;
		}
		DLLNode fin = head;
		head = head.next;
		head.prev = null;
		return fin.data;

	}

	/**
	 * @return a string with the elements of the list as a comma-separated list,
	 *         from beginning to end
	 *
	 *         Worst-case asymptotic runtime cost: Theta(n)
	 *
	 *         Justification: We know from the Java documentation that
	 *         StringBuilder's append() method runs in Theta(1) asymptotic time.
	 *         We assume all other method calls here (e.g., the iterator methods
	 *         above, and the toString method) will execute in Theta(1) time.
	 *         Thus, every one iteration of the for-loop will have cost
	 *         Theta(1). Suppose the doubly-linked list has 'n' elements. The
	 *         for-loop will always iterate over all n elements of the list, and
	 *         therefore the total cost of this method will be n*Theta(1) =
	 *         Theta(n).
	 */
	public String toString() 
	{
		StringBuilder s = new StringBuilder();
		boolean isFirst = true;

		// iterate over the list, starting from the head
		for (DLLNode iter = head; iter != null; iter = iter.next) {
			if (!isFirst) {
				s.append(",");
			} else {
				isFirst = false;
			}
			s.append(iter.data.toString());
		}

		return s.toString();
	}

}
