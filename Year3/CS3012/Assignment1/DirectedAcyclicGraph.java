//@version 1.1 08/10/18 
import java.util.LinkedList;

public class DirectedAcyclicGraph
{
  private int totalVertices;
  private int edges;

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

  public DirectedAcyclicGraph(int totalVertices)
  {
    this.totalVertices = totalVertices;
    this.edges = 0;
    private LinkedList<Node> successors[];
    public Graph(int a)
    {
      successors = new LinkedList[a]; 
      for (int i=0; i<a; ++i)
      {
        successors[i] = new LinkedList<Node>(); 
      }

     
    }
  }
  /* public void addEdge(int newKey, int key, int weight)
      {
        //successors node = new Node(key, weight);
        //adj[newKey].add(node);// Add v to u's list
      }
   */
  //pubic static prettyPrint()
  public static int getNoOFVertices()
  {
    return totalVertices;
  }
  public static int getNoOFEdges()
  {
    return edges;
  }

}
