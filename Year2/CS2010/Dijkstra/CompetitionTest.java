import static org.junit.Assert.*;

import javax.print.DocFlavor.URL;
import javax.xml.soap.Node;

import org.junit.Test;

public class CompetitionTest
{

  @Test
  public void testDijkstraConstructor()
  {
    String a="tinyEWD.txt";
    CompetitionDijkstra stra = new CompetitionDijkstra(a, 50, 60, 90);
    System.out.println(stra.timeRequiredforCompetition());
  }
  @Test
  public void testNoIn()
  {
    CompetitionDijkstra stra = new CompetitionDijkstra(null, 50, 60, 90);
    assertEquals("Time required", -1, stra.timeRequiredforCompetition());
    System.out.println("minimum time " + stra.timeRequiredforCompetition());
    CompetitionFloydWarshall fw = new CompetitionFloydWarshall(null, 50, 60, 90);
    assertEquals("Time required", -1, fw.timeRequiredforCompetition());
    System.out.println("minimum time " + fw.timeRequiredforCompetition());
  }
  
  @Test
  public void testMinusSpeed()
  {
    CompetitionDijkstra stra = new CompetitionDijkstra("tinyEWD.txt", -20, 60, 90);
    assertEquals("Time required", -1, stra.timeRequiredforCompetition());
    System.out.println("minimum time " + stra.timeRequiredforCompetition());
    CompetitionFloydWarshall fw = new CompetitionFloydWarshall("tinyEWD.txt", -20, 60, 90);
    assertEquals("Time required", -1, fw.timeRequiredforCompetition());
    System.out.println("minimum time " + fw.timeRequiredforCompetition());
  }
//"bin/" +
  @Test
  public void testInI()
  {
    CompetitionDijkstra stra = new CompetitionDijkstra("input-I.txt", 4, 7, 1);
    assertEquals("Time required", 12000, stra.timeRequiredforCompetition());
    System.out.println("input-I: Minimum time required: " + stra.timeRequiredforCompetition() + " seconds");
    
    CompetitionFloydWarshall fw = new CompetitionFloydWarshall("input-I.txt", 52, 60, 22);
    assertEquals("Time required", 546, fw.timeRequiredforCompetition());
    System.out.println("input-I: Minimum time required: " + fw.timeRequiredforCompetition() + " seconds");
  }
  @Test
  
  @Test
  public void testWrongFile()
  {
    CompetitionDijkstra stra = new CompetitionDijkstra("ta.txt", -20, 60, 90);
    assertEquals("Time required", -1, stra.timeRequiredforCompetition());
    System.out.println("minimum time " + stra.timeRequiredforCompetition());
    CompetitionFloydWarshall fw = new CompetitionFloydWarshall("ta.txt", -20, 60, 90);
    assertEquals("Time required", -1, fw.timeRequiredforCompetition());
    System.out.println("minimum time " + fw.timeRequiredforCompetition());
  }


  @Test
  public void testFWConstructor()
  {
    String a="tinyEWD.txt";
    CompetitionFloydWarshall fw = new CompetitionFloydWarshall(a, 50, 60, 90);
    System.out.println(fw.timeRequiredforCompetition());
  }
  //"bin/" +
  @Test
  public void testD()
  {
    CompetitionDijkstra stra = new CompetitionDijkstra("input-I.txt", 50, 60, 90);
    System.out.println(stra.timeRequiredforCompetition());
    CompetitionFloydWarshall fw = new CompetitionFloydWarshall("input-I.txt", 50, 60, 90);
    System.out.println(fw.timeRequiredforCompetition());
  }

  public static void main(String[] args)
  {
    String a="bin/" +"tinyEWD.txt";
    CompetitionDijkstra stra = new CompetitionDijkstra(a, 50, 60, 90);
    System.out.println(stra.timeRequiredforCompetition());
    
    CompetitionFloydWarshall FW = new CompetitionFloydWarshall(a, 50, 60, 90);
    System.out.println(FW.timeRequiredforCompetition());
    
   
  }

}
