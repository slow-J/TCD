/*************************************************************************
 *  Binary Search Tree class.
 *  Adapted from BST.java
 *
 *  @version 1.0 19/09/18 
 *
 *  @author Jakub slowinski
 *
 *************************************************************************/

public class BinaryTree<Key extends Comparable<Key>, Value>
{
  public Node lowestCommonAncestor(Node a, Node x, Node y)
  {
    //pass in root for Node a
    
    // If both n1 and n2 are smaller than root, then LCA lies in left
    if (a.key.compareTo(x.key) > 0 && a.key.compareTo(y.key) > 0)
      return lowestCommonAncestor(a.left, x, y);
    if (a.key.compareTo(x.key) < 0 && a.key.compareTo(y.key) < 0)
      return lowestCommonAncestor(a.right, x, y); // If both n1 and n2 are
                                                  // greater than root, then LCA lies in right

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
   *
   * Asymptotic worst-case running time using Theta notation: the worst case
   * running time is theta(N)
   *
   * @return the number of links from the root to the deepest leaf.
   *
   *         Example 1: for an empty tree this should return -1. Example 2: for
   *         a tree with only one node it should return 0. Example 3: for the
   *         following tree it should return 2. B / \ A C \ D
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
   * Median key. If the tree has N keys k1 < k2 < k3 < ... < kN, then their
   * median key is the element at position (N+1)/2 (where "/" here is integer
   * division)
   *
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

  /**
   * Print all keys of the tree in a sequence, in-order. That is, for each node,
   * the keys in the left subtree should appear before the key in the node.
   * Also, for each node, the keys in the right subtree should appear before the
   * key in the node. For each subtree, its keys should appear within a
   * parenthesis.
   *
   * Example 1: Empty tree -- output: "()" Example 2: Tree containing only "A"
   * -- output: "(()A())" Example 3: Tree: B / \ A C \ D
   *
   * output: "((()A())B(()C(()D())))"
   *
   * output of example in the assignment:
   * (((()A(()C()))E((()H(()M()))R()))S(()X()))
   *
   * @return a String with all keys in the tree, in order, parenthesized.
   */
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
   * Deteles a key from a tree (if the key is in the tree). Note that this
   * method works symmetrically from the Hibbard deletion: If the node to be
   * deleted has two child nodes, then it needs to be replaced with its
   * predecessor (not its successor) node.
   *
   * @param key
   *          the key to delete
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