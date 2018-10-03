import java.util.LinkedList;

public class DirectedAcyclicGraph
{
  private Node root; // root of BST

  /**
   * Private node class.
   */
  private class Node 
  {
    private int key; // sorted by key
    private int weight; // associated data

    public Node(int key, int weight)
    {
      this.key = key;
      this.weight = weight;
    }
  }

  private class Graph
  {
    private int graphKey;
    private LinkedList<Node> successors[];
    public Graph(int a)
    {
      successors = new LinkedList[a]; 
      for (int i=0; i<a; ++i)
      {
        successors[i] = new LinkedList<Node>(); 
      }

     /* public void addEdge(int newKey, int key, int weight)
      {
        //successors node = new Node(key, weight);
        //adj[newKey].add(node);// Add v to u's list
      }
      */
    }
  }

}
