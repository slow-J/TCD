//@version 1.2 11/10/18 
import java.util.LinkedList;

public class DirectedAcyclicGraph
{
  private int totalVertices;
  private int edges;


  public DirectedAcyclicGraph(int totalVertices)
  {
    this.totalVertices = totalVertices;
    this.edges = 0;
    LinkedList<Integer> successors[];

    successors = new LinkedList[totalVertices];
    for (int i = 0; i < totalVertices; ++i)
    {
      successors[i] = new LinkedList<Integer>();
    }

  }
  /* public void addEdge(int newKey, int key, int weight)
      {
        //successors node = new Node(key, weight);
        //adj[newKey].add(node);// Add v to u's list
      }
   */
  public static void prettyPrint(){}
  public int getNoOFVertices()
  {
    return this.totalVertices;
  }
  public int getNoOFEdges()
  {
    return this.edges;
  }
  private boolean validateVertex(int vertice)
  {
    if (vertice < 0 || vertice >= this.totalVertices)
      return false;
    return true;
  }

}