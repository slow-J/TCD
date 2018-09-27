/*************************************************************************
 *  Binary Search Tree class.
 *  Adapted from BST.java
 *
 *  @version 1.3 27/09/18 
 *
 *  @author Jakub slowinski
 *
 *************************************************************************/

public class BinaryTree<Key extends Comparable<Key>, Value>
{
  public Node lowestCommonAncestor(Key x, Key y)
  {
    Node ret = root;
    if (x == null || y == null) 
      return null;
    
    if (ret == x || ret == y)
      return ret;
    
    // If both x and y are smaller than root, then LCA lies in left
    if (ret.key.compareTo(x) > 0 && ret.key.compareTo(y) > 0)
      ret= lowestCommonAncestor(ret.left, x, y);
    // If both x and y are greater than root, then LCA lies in right
    if (ret.key.compareTo(x) < 0 && ret.key.compareTo(y) < 0)
      ret= lowestCommonAncestor(ret.right, x, y);
    
    return ret;
  }
  private Node lowestCommonAncestor(Node a, Key x, Key y)
  {
    if (a.key.compareTo(x) > 0 && a.key.compareTo(y) > 0)
      return lowestCommonAncestor(a.left, x, y);
    if (a.key.compareTo(x) < 0 && a.key.compareTo(y) < 0)
      return lowestCommonAncestor(a.right, x, y);
    return a;
  }
  
  
  private Node root; // root of BST

  /**
   * Private node class.
   */
  private class Node
  {
    private Key key; // sorted by key
    private Value val; // associated data
    private Node left, right; // left and right subtrees
    private int N; // number of nodes in subtree

    public Node(Key key, Value val, int N)
    {
      this.key = key;
      this.val = val;
      this.N = N;
    }
  }

  // is the symbol table empty?
  public boolean isEmpty()
  {
    return size() == 0;
  }

  // return number of key-value pairs in BST
  public int size()
  {
    return size(root);
  }

  // return number of key-value pairs in BST rooted at x
  private int size(Node x)
  {
    if (x == null)
      return 0;
    else
      return x.N;
  }

  /**
   * Search BST for given key. Does there exist a key-value pair with given key?
   *
   * @param key
   *          the search key
   * @return true if key is found and false otherwise
   */
  public boolean contains(Key key)
  {
    return get(key) != null;
  }

  /**
   * Search BST for given key. What is the value associated with given key?
   *
   * @param key
   *          the search key
   * @return value associated with the given key if found, or null if no such
   *         key exists.
   */
  public Value get(Key key)
  {
    return get(root, key);
  }

  private Value get(Node x, Key key)
  {
    if (x == null)
      return null;
    int cmp = key.compareTo(x.key);
    if (cmp < 0)
      return get(x.left, key);
    else if (cmp > 0)
      return get(x.right, key);
    else
      return x.val;
  }
  public Node getRoot()
  {
    return this.root;
  }
  /**
   * Insert key-value pair into BST. If key already exists, update with new
   * value.
   *
   * @param key
   *          the key to insert
   * @param val
   *          the value associated with key
   */
  public void put(Key key, Value val)
  {
    if (val == null)
    {
      delete(key);
      return;
    }
    root = put(root, key, val);
  }

  private Node put(Node x, Key key, Value val)
  {
    if (x == null)
      return new Node(key, val, 1);
    int cmp = key.compareTo(x.key);
    if (cmp < 0)
      x.left = put(x.left, key, val);
    else if (cmp > 0)
      x.right = put(x.right, key, val);
    else
      x.val = val;
    x.N = 1 + size(x.left) + size(x.right);
    return x;
  }

  /**
   * Tree height.
   * @return the number of links from the root to the deepest leaf.
   *
   */
  public int height()
  {
    return height(root);
  }

  private int height(Node x)
  {
    if (x == null)
    {
      return -1;
    }
    return 1 + Math.max(height(x.left), height(x.right));
  }

  /**
   * @return the median key, or null if the tree is empty.
   */

  public Key median()
  {
    int med = ((size(root) + 1) / 2) - 1;
    return median(med);
  }

  private Key median(int a)
  {
    if (a < 0 || a >= size())
      return null;
    Node k = median(root, a);
    return k.key;
  }

  private Node median(Node k, int a)
  {
    int t = (size(k.left));
    if (t > a)
      return median(k.left, a);
    else if (t < a)
      return median(k.right, a - t - 1);
    else
      return k;
  }

  public String printKeysInOrder()
  {
    if (isEmpty())
      return "()";
    else
      return printKeysInOrder(root);

  }

  private String printKeysInOrder(Node t)
  {
    if (t == null)
      return "()";
    else
      return "(" + (printKeysInOrder(t.left)) + (t.key.toString()) + printKeysInOrder(t.right) + ")";

  }

  /**
   * Pretty Printing the tree. Each node is on one line -- see assignment for
   * details.
   *
   * @return a multi-line string with the pretty ascii picture of the tree.
   */
  public String getNodeInfo(Node a)
  {
    String ret="\n";
    ret +="key: "+ a.key+"\nvalue: "+ a.val+"\nsize of subtree: "+a.N;
    return ret;    
  }
  public String getNodeKey(Node a)
  {
    if(a.key==null)
      return null;
    String ret = a.key+"";
    return ret;
  }
  public String getNodeVal(Node a)
  {
    if(a.val==null)
      return null;
    String ret = a.val+"";
    return ret;
  }
  public String prettyPrintKeys()
  {
    if (isEmpty())
    {
      return "-null\n";
    }
    return prettyPrintKeys(root, "");
  }

  private String prettyPrintKeys(Node node, String prefix)
  {
    if (node == null)
    {
      return prefix + "-null\n";
    }

    else
    {
      return (prefix + "-" + node.key.toString() + "\n" + prettyPrintKeys(node.left, (prefix + " |"))
          + prettyPrintKeys(node.right, (prefix + "  ")));
    }

  }

  /**
   * Deletes a key from a tree (if the key is in the tree).
   *
   * @param key key to delete
   */

  public void delete(Key k)
  {
    root = delete(root, k);
  }

  private Node delete(Node x, Key k)
  {
    if (x == null)
      return null;
    int compare = k.compareTo(x.key);

    if (compare < 0)
      x.left = delete(x.left, k);
    else if (compare > 0)
      x.right = delete(x.right, k);

    else
    {
      if (x.right == null)
        return x.left;
      if (x.left == null)
        return x.right;
      Node a = x;
      x = replace(a.left);
      x.left = deleteReplacement(a.left);
      x.right = a.right;
    }
    x.N = size(x.left) + size(x.right) + 1;
    return x;
  }

  private Node deleteReplacement(Node x)
  {
    if (x.right == null)
      return x.left;
    x.right = deleteReplacement(x.right);
    x.N = size(x.left) + size(x.right) + 1;
    return x;
  }

  public Node replace(Node a)
  {
    if (a.right != null)
      return replace(a.right);

    return a;
  }

}