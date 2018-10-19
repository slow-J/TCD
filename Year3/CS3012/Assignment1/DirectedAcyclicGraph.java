//@version 1.3 19/10/18 
import java.util.Iterator;
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
  
  public int lowestCommonAncestor(int x, int y)
  {
    if (!validateVertex(x) || !validateVertex(y)) 
      return -1;
    int ret =-1;
    for(int i=0; i<indegree.length; i++ )
    {
      if(indegree[i]==0)
        ret = i;
    }    
    if (ret == x || ret == y)
      return ret;
    
    LinkedList<Integer> xbfs = bfs(x);
    LinkedList<Integer> ybfs = bfs(y);
    
    
    return ret;
  }
 
  
  // prints BFS traversal from a given source s 
  public LinkedList<Integer> bfs(int s) 
  { 
    LinkedList<Integer> ret= new LinkedList();
    // Mark all the vertices as not visited
    boolean visited[] = new boolean[indegree.length];
    
    // queue for BFS
    LinkedList<Integer> queue = new LinkedList<Integer>();

    // Mark the current node as visited and enqueue it
    visited[s] = true;
    queue.add(s);

    while (queue.size() != 0) 
    {
      // Dequeue a vertex from queue and print it
      s = queue.poll();
      System.out.print(s + " ");
      ret.add(s);
      //findDepth(s);
      
      // Get all adjacent vertices of the dequeued vertex s
      // If a adjacent has not been visited, then mark it
      // visited and enqueue it
      Iterator<Integer> i = successors[s].listIterator();
      while (i.hasNext()) 
      {
        int n = i.next();
        if (!visited[n]) 
        {
          visited[n] = true;
          queue.add(n);
        }
      }
    }
    return ret;
  }

  /*
  public int findDepth(int s) 
}