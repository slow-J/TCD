//@version 1.2 11/10/18 
import java.util.LinkedList;

public class DirectedAcyclicGraph
{
  private int totalVertices;
  private int totalEdges;
  LinkedList<Integer> successors[];
  private int[] indegree;
  
  public DirectedAcyclicGraph(int totalVertices)
  {
    this.totalVertices = totalVertices;
    this.totalEdges = 0;
    successors = new LinkedList[totalVertices];
    indegree = new int[totalVertices];
    
    for (int i = 0; i < totalVertices; ++i)
    {
      successors[i] = new LinkedList<Integer>();
    }

  }
  
  public int getNoOFVertices()
  {
    return this.totalVertices;
  }
  public int getNoOfEdges()
  {
    return this.totalEdges;
  }
  private void setEdges(int a)
  {
    this.totalEdges=a;
  }
  private boolean validateVertex(int vertex)
  {
    if (vertex < 0 || vertex >= this.totalVertices)
      return false;
    return true;
  }
  
// from a -> z  
  public void addEdge(int a, int z) 
  {
    if(validateVertex(a) && validateVertex(z))
    {
      successors[a].add(z);
      indegree[z]++;
      setEdges(getNoOfEdges()+1);
    }
    else
    {
      throw new IllegalArgumentException("Error with validating vertex");
    }
  }

  public String toString()
  {
    StringBuilder stringB = new StringBuilder();
    stringB.append(totalVertices + " vertices, " + totalEdges + " edges \n");
    for (int v = 0; v < totalVertices; v++)
    {
      stringB.append(String.format("%d: ", v));
      for (int w : successors[v])
      {
        stringB.append(String.format("%d ", w));
      }
      stringB.append("\n");
    }
    return stringB.toString();
  }

}