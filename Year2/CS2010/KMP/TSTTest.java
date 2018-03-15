import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNull;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.junit.Test;

public class TSTTest
{

  @Test
  public void testEmpty()
  {
    TST<Long> trie = new TST<>();
    assertEquals("size of an empty trie should be 0", 0, trie.size());
    assertFalse("searching an empty trie should return false", trie.contains(""));
    assertNull("getting from an empty trie should return null", trie.get(""));
  }
  @Test
  public void testSize()
  {
    TST<Long> trie = new TST<>();
    trie.put("a", 22L);
    trie.size();
  }
  @Test
  public void testContains()
  {
    TST<Integer> trie = new TST<>();
    trie.put("a", 22);
    trie.put("o", 212);
    trie.put("l", 2332);
    trie.put("d", 22);
    trie.put("z", 2999992);
    trie.put("s", 122);
    trie.put("f", 0);
    trie.contains("a");
    trie.contains("o");
    
  }
  @Test
  public void testGet()
  {
    TST<Integer> trie = new TST<>();
    trie.put("a", 22);
    trie.put("o", 212);
    trie.put("l", 2332);
    trie.put("d", 22);
    trie.put("z", 2999992);
    trie.put("s", 122);
    trie.put("f", 0);
    trie.get("a");
    trie.get("o");
    
  }
  
  @Test
  public void testKeysWithPrefix()
  {
    TST<String> trie = new TST<>();
    trie.put("a", "22");
    trie.put("o", "212");
    trie.put("l", "2332");
    trie.put("d", "22");
    trie.put("z", "2999992");
    trie.put("s", "122");
    trie.put("f", "");
    trie.keysWithPrefix("2");
    
  }


  public static void main(String[] args)
  {
    /*
    try
    {
      JSONParser parser = new JSONParser();
      Object busObj =  parser.parse(new FileReader("/BUSES_SERVICE.json"));
      
      JSONArray busArr = (JSONArray)busObj;
      
      TST<Integer> busTST = new TST<Integer>();
      String destination="";
      int count=0;
      for(int i=0; i<busArr.size();i++)
      {
        JSONObject obi = (JSONObject) busArr.get(i);
        destination = ((String) obi.get("Destination"));

        if (busTST.contains(destination))
        {
          count = busTST.get(destination);
          busTST.put(destination, count + 1);
        } 
        else
          busTST.put(destination, 1);

      }
      
      System.out.println(busTST.size());
      System.out.println(busTST.get("SOUTHSIDE"));
      LinkedList<String> list1 = new   LinkedList<String>();
      list1=busTST.keysWithPrefix("DOWN");
      System.out.println(list1.toString());
      System.out.println(busTST.get("DOWNTOWN"));
      System.out.println("-----------------------------------------");


    }
    catch (Exception e)
    {

    }
    try
    {
      FileReader reader = new FileReader("google-books-common-words.txt");
      BufferedReader bufferedReader = new BufferedReader(reader);
      TST<String> words = new TST<String>();
      String line = null;
      String[] parts = {"",""};
      while ((line = bufferedReader.readLine()) != null)
      {        
        parts = line.split("\\s");
       // a =Long.parseLong(parts[1]);
        words.put(parts[0], parts[1]);
      }      
      bufferedReader.close();
      System.out.println(words.size());
      System.out.println(words.get("ALGORITHM"));
      System.out.println(words.get("EMOJI"));
      System.out.println(words.get("BLAH"));
      LinkedList<String> list1 = new   LinkedList<String>();
      list1=words.keysWithPrefix("TEST");
      System.out.println(list1.size());      
    } 
    catch (IOException e)
    {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
    */
  }
}