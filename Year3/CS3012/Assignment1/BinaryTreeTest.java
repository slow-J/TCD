import static org.junit.Assert.*;

import org.junit.Test;

public class BinaryTreeTest 
{

  @Test
  public void testIsEmpty()
  {
    BinaryTree<Integer, Integer> bst = new BinaryTree<Integer, Integer>();
    assertEquals("Checking pretty printing of empty tree", true, bst.isEmpty());
  }
  @Test
  public void testLCA()
  {
    BinaryTree<Integer, String> bst = new BinaryTree<Integer, String>();
    bst.put(5, "J"); 
    bst.put(3, "S"); 
    bst.put(8, "T"); 
    bst.put(7, "P"); 
    bst.put(11, "Q");
    System.out.println(bst.prettyPrintKeys());
    System.out.println(bst.getNodeInfo(bst.getRoot()));
    System.out.println();
    bst.printNodeName(bst.lowestCommonAncestor(7,11));
  }

}
