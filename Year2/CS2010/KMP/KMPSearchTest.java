import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.*;
 

import org.junit.Test;
    
public class KMPSearchTest
{

  @Test
  public void testEmpty()
  {
    assertEquals("Empty text or pattern is invalid",-1,KMPSearch.searchFirst("",""));
    assertEquals("Empty text or pattern is invalid",0,KMPSearch.searchAll("",""));
    assertFalse("Empty text or pattern is invalid",KMPSearch.contains("",""));
  }
  @Test
  public void testContains()
  {
    String haystack ="apple";
    String needle ="app";
    KMPSearch.contains(haystack, needle);
  }
  @Test
  public void testSearchFirst()
  {
    String haystack ="apple";
    String needle ="app";
    KMPSearch.searchFirst(haystack, needle);
  }
  @Test
  public void testSearchAll()
  {
    String haystack ="apple";
    String needle ="app";
    KMPSearch.searchAll(haystack, needle);
  }
  
  public static void main(String[] args)
  {
    /*
    JSONParser parser = new JSONParser();
    try
    {
      JSONArray busArray = (JSONArray) parser.parse(new FileReader("U:\\BUSES_SERVICE.json"));
      String allJSON = busArray.toString();
      System.out.println(KMPSearch.searchAll(allJSON, "VehicleNo"));
      System.out.println(KMPSearch.contains(allJSON, "16555"));
      System.out.println(KMPSearch.searchFirst(allJSON, "HAMPTON PARK"));
      System.out.println(KMPSearch.contains(allJSON, "9043409"));
    }
    catch(Exception e)
    {
      
    }
    */
  }

}