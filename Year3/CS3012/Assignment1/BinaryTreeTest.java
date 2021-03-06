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
  public void testPut()
  {
	  BinaryTree<Integer, Integer> bst = new BinaryTree<Integer, Integer>();

    bst.put(7, 7);
    bst.put(3, 3);
    bst.put(1, 1);
    bst.put(2, 2);
    bst.put(6, 6);
    bst.put(4, 4);
    bst.put(5, 5);
    assertEquals("test method works correctly", "(((()1(()2()))3((()4(()5()))6()))7())", bst.printKeysInOrder());
}
  
  @Test
  public void testLCA1()
  {
    BinaryTree<Integer, Integer> bst = new BinaryTree<Integer, Integer>();
    bst.put(5, 5); 
    bst.put(3, 3); 
    bst.put(8, 8); 
    bst.put(7, 7); 
    bst.put(11, 11);
    //System.out.println(bst.prettyPrintKeys());
    //System.out.println(bst.getNodeInfo(bst.getRoot()));
    assertEquals("Checking lca of keys 7 and 11", "8", bst.getNodeKey(bst.lowestCommonAncestor(7, 11)));
    assertEquals("Checking lca of keys 11 and 7", "8", bst.getNodeKey(bst.lowestCommonAncestor(11, 7)));
  }
  
  @Test
  public void testLCA2()
  {
    BinaryTree<Integer, String> bst = new BinaryTree<Integer, String>();
    bst.put(1, "Mark"); 
    bst.put(15, "Gideon");
    bst.put(40, "Isabelle"); 
    bst.put(33, "Shane"); 
    bst.put(7, "Tom");
    bst.put(9, "Lorchan"); 
    bst.put(11, "Dylan");
    bst.put(3, "Jade");
    bst.put(5, "Yasmin"); 
    bst.put(21, "Anna"); 
    bst.put(12, "Ian");
    bst.put(20, "Fernando");
    bst.put(25, "Cian");
    //System.out.println(bst.prettyPrintKeys());
    //System.out.println(bst.getNodeInfo(bst.getRoot()));
    assertEquals("Checking lca of keys 20 and 25", "21", bst.getNodeKey(bst.lowestCommonAncestor(20, 25)));
    assertEquals("Checking lca of keys 1 and 12", "1", bst.getNodeKey(bst.lowestCommonAncestor(1, 12)));
    assertEquals("Checking lca of keys 11 and 25", "15", bst.getNodeKey(bst.lowestCommonAncestor(11, 25)));
    assertEquals("Checking lca of keys 3 and 40", "15", bst.getNodeKey(bst.lowestCommonAncestor(40, 3)));
    assertEquals("Checking lca of keys 33 and 21", "33", bst.getNodeKey(bst.lowestCommonAncestor(33, 21)));
  }
  
  @Test
  public void testLCA3()
  {
    BinaryTree<Integer, Boolean> bst = new BinaryTree<Integer, Boolean>();
    bst.put(1, true); 
    bst.put(60, false);
    bst.put(31, false); 
    bst.put(2, false);
    bst.put(4, true);
    bst.put(61, false);
    bst.put(23, false);
    bst.put(32, true);
    bst.put(132, true);
    bst.put(15, true);
    bst.put(20, true);
    //System.out.println(bst.prettyPrintKeys());
    //System.out.println(bst.getNodeInfo(bst.getRoot()));
    assertEquals("Checking lca of keys 4 and 61", "60", bst.getNodeKey(bst.lowestCommonAncestor(4, 61)));
    assertEquals("Checking lca of keys 1 and 32", "1", bst.getNodeKey(bst.lowestCommonAncestor(1, 32)));
    assertEquals("Checking lca of keys 32 and 23", "31", bst.getNodeKey(bst.lowestCommonAncestor(32, 23)));
    assertEquals("Checking lca of keys 4 and 23", "4", bst.getNodeKey(bst.lowestCommonAncestor(4, 23)));
  }
  
  @Test
  public void testDAG1()
  {
    DirectedAcyclicGraph dag = new DirectedAcyclicGraph(10);
    dag.addEdge(8, 9);
    dag.addEdge(1, 8);
    dag.addEdge(1, 2);
    dag.addEdge(3, 4);
    dag.addEdge(2, 3);
    dag.addEdge(1, 5);
    dag.addEdge(4, 6);
    dag.addEdge(3, 7);
    dag.addEdge(2, 0);
    //System.out.println(dag.toString());

    assertEquals("Checking lca of keys 8 and 9", 8, (dag.lowestCommonAncestor(8, 9)));
    assertEquals("Checking lca of keys 2 and 5", 1, (dag.lowestCommonAncestor(2, 5)));
    assertEquals("Checking lca of keys 2 and 3", 2, (dag.lowestCommonAncestor(2, 3)));
    assertEquals("Checking lca of keys 7 and 0", 2, (dag.lowestCommonAncestor(7, 0)));
    assertEquals("Checking lca of keys 6 and 7", 3, (dag.lowestCommonAncestor(6, 7)));
    assertEquals("Checking lca of keys 5 and 8", 1, (dag.lowestCommonAncestor(5, 8)));
    assertEquals("Checking lca of keys 3 and 9", 1, (dag.lowestCommonAncestor(3, 9)));
  }
  
  @Test
  public void testDAG2()
  {
    DirectedAcyclicGraph dag = new DirectedAcyclicGraph(20);
    dag.addEdge(1, 2);
    dag.addEdge(1, 3);
    dag.addEdge(2, 5);
    dag.addEdge(3, 4);
    dag.addEdge(5, 0);
    dag.addEdge(4, 7);
    dag.addEdge(1, 6);
    dag.addEdge(7, 15);
    dag.addEdge(5, 17);
    dag.addEdge(8, 5);
    dag.addEdge(9, 4);
    dag.addEdge(12, 0);
    dag.addEdge(14, 1);
    dag.addEdge(19, 4);
    assertEquals("Checking lca of keys 2 and 15", 19, (dag.lowestCommonAncestor(2, 15)));
  }
  
}
