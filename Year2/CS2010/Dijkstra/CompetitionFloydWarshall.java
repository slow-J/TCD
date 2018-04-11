import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.Arrays;
import java.util.Scanner;


/*
 * A Contest to Meet (ACM) is a reality TV contest that sets three contestants at three random
 * city intersections. In order to win, the three contestants need all to meet at any intersection
 * of the city as fast as possible.
 * It should be clear that the contestants may arrive at the intersections at different times, in
 * which case, the first to arrive can wait until the others arrive.
 * From an estimated walking speed for each one of the three contestants, ACM wants to determine the
 * minimum time that a live TV broadcast should last to cover their journey regardless of the contestants’
 * initial positions and the intersection they finally meet. You are hired to help ACM answer this question.
 * You may assume the following:
 *     Each contestant walks at a given estimated speed.
 *     The city is a collection of intersections in which some pairs are connected by one-way
 * streets that the contestants can use to traverse the city.
 *
 * This class implements the competition using Floyd-Warshall algorithm
 */

public class CompetitionFloydWarshall
{
  private String fileN;
  private int totalIntersections=-1;
  private int totalStreets=-1;
  private int speedA;             //metres per minute
  private int speedB;
  private int speedC;
  double[][] FWtable=null;
  
  private boolean negativeCycle=false;
  
  private void setFileName(String fileN)
  {
    this.fileN=fileN;
  }
  private void initFWtable(int n)
  {
    this.FWtable = new double[n][n];
    for (int i = 0; i < FWtable.length; i++)
    {
      for (int j = 0; j < FWtable.length; j++)
      {
        if (i == j)
        {
          FWtable[i][j] = 0;
        } 
        else
        {
          FWtable[i][j] = Double.MAX_VALUE;
        }
      }
    }
  }

  public boolean hasNegativeCycle()
  {
    return this.negativeCycle;
  }

  private void addEdge(int from, int to, double weight)
  {
    FWtable[from][to] = weight;
  }

 // all-pairs shortest path
  public double[][] floydWarshall()
  {
    double[][] distances;
    int n = this.FWtable.length;
    distances = Arrays.copyOf(this.FWtable, n);

    for (int k = 0; k < n; k++)
    {
      for (int i = 0; i < n; i++)
      {
        for (int j = 0; j < n; j++)
        {
          distances[i][j] = Math.min(distances[i][j], distances[i][k] + distances[k][j]);
        }
      }

      if (distances[k][k] < 0.0)
      {
        this.negativeCycle = true;
      }
    }

    return distances;
  }
  
  /**
   * @param filename:
   *          A filename containing the details of the city road network
   * @param sA,
   *          sB, sC: speeds for 3 contestants
   */
  CompetitionFloydWarshall(String filename, int sA, int sB, int sC)
  {
    setFileName(filename);
    if (filename!=null)
    {
      try
      {
        Scanner scan = new Scanner(new FileReader(filename));
        this.speedA = sA;
        this.speedB = sB;
        this.speedC = sC;

        int a=-1;
        int b=-1;
        double c=0.0; // km        
        this.totalIntersections = scan.nextInt();
        this.totalStreets = scan.nextInt();
        if(this.totalStreets<=0||this.totalIntersections<=0)
          setFileName("0");
        
        
        initFWtable(totalIntersections);
        while (scan.hasNext())
        {
          a = scan.nextInt();
          b = scan.nextInt();
          if(b==-1) 
            setFileName("0");
          
          if(c<0)
            setFileName("0");

          c = scan.nextDouble();
          c *= 1000;
          addEdge(a, b, c);

        }
        scan.close();
      } 
      catch (FileNotFoundException e)
      {
        // TODO Auto-generated catch block
        e.printStackTrace();
      }
    }
  }
  
  /**
   * @return int: minimum minutes that will pass before the three contestants
   *         can meet
   */
  public int timeRequiredforCompetition()
  {
    if (this.FWtable==null)
      return -1;
    if (this.speedA<0||this.speedB<0||this.speedC<0)
      return -1;
    if (this.fileN==null||this.fileN=="0")
      return -1;
    if (this.negativeCycle)
      return -1;
    double[][] floy=floydWarshall();
    double longestTime =0.0;
    int longestestD=0;
    int longestP=0;
    double dist1;
    double dist2;
    double dist3;
    for (int finalD = 0; finalD < floy.length; finalD++)
    {
      for (int indexA = 0; indexA < floy.length; indexA++)
      {
        dist1 = floy[finalD][indexA];
        if (dist1==Double.MAX_VALUE||dist1<0)
          return -1;
        dist1 = dist1/speedA; 
        if (dist1>longestTime)
        {  
          longestTime=dist1;
          longestestD=finalD;
          longestP=indexA;
        }  
        for (int indexB = 0; indexB < floy.length; indexB++)
        {
          dist2 = floy[indexB][finalD];
          if (dist2==Double.MAX_VALUE||dist2<0)
            return -1;
          dist2 = dist2 / speedB;
          if (dist2 > longestTime)
          {
            longestTime = dist2;
            longestestD = finalD;
            longestP = indexB;
          }
          
          for (int indexC = 0; indexC < floy.length; indexC++)
          {
            dist3 = floy[indexC][finalD];
            if (dist3==Double.MAX_VALUE||dist3<0)
              return -1;
            dist3 = dist3/speedC; 
            if (dist3>longestTime)
            {
              longestTime = dist3;
              longestestD = finalD;
              longestP = indexC;
            }
          }
        }
      }
    }
    int ret=(int)Math.ceil(longestTime);
    return ret;
  }

}
