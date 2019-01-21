import java.util.ArrayList;
import java.util.List;

public class CacheObj
{
  static String[] allInputs = { "0000", "0004", "000c", "2200", "00d0", "00e0", "1130",
        "0028", "113c", "2204", "0010", "0020", "0004", "0040", "2208", "0008", "00a0",
        "0004", "1104", "0028", "000c", "0084", "000c", "3390", "00b0", "1100", "0028", 
        "0064", "0070", "00d0", "0008", "3394" };

  public static void main(String[] args)
  {
    List<CacheObject> caches = new ArrayList<CacheObject>();
    // L, K, N
    caches.add(new CacheObject(16, 1, 8));
    caches.add(new CacheObject(16, 2, 4));
    caches.add(new CacheObject(16, 4, 2));
    caches.add(new CacheObject(16, 8, 1));

    for (CacheObject c : caches)
    {
      int count = 0;
      for (String i : allInputs)
      {
        if (c.check(i))
        {
          System.out.println(i + ", " + "hit");
          count++;
        }
        else
          System.out.println(i + ", " + "miss");
      }
      System.out.println("L = " + c.getL()  + ", K = " + c.getK()+ ", N = " + c.getN() + "; " + count + " hits");
    }
  }
}

class CacheObject
{
  private int l; // bytes per cache line
  private int k; // cache lines per set
  private int n; // number of sets

  List<Set> setList = new ArrayList<Set>();

  public CacheObject(int l, int k, int n)
  {
    setL(l);
    setK(k);
    setN(n);
    for (int i = 0; i < n; i++)
    {
      setList.add(i, new Set(k));
    }
  }
  
  boolean check(String s)
  {
    int tmp = (int) Long.parseLong(s, 16);
    int setNumber = (tmp >> 4) & ((1 << (int) (Math.log(getN()) / Math.log(2))) - 1);
    int tag = tmp >> ((int) (Math.log(getN()) / Math.log(2)) + 4);
    
    return setList.get(setNumber).check(tag);
  }

  public int getL()
  {
    return l;
  }
  private void setL(int l)
  {
    this.l = l;
  }
  public int getK()
  {
    return k;
  }
  private void setK(int k)
  {
    this.k = k;
  }
  public int getN()
  {
    return n;
  }
  private void setN(int n)
  {
    this.n = n;
  }
}

class Set
{
  // list of all K tags
  List<Tag> tags = new ArrayList<Tag>();

  int K;
  int timestamp;

  Set(int K)
  {
    this.K = K;
    this.timestamp = 0;
    for (int i = 0; i < K; i++)
    {
      tags.add(i, new Tag());
    }
  }

  // true if hit
  public boolean check(int tag)
  {
    // timestamp for lru
    timestamp++; 
    int index = -1;
    for (int i = 0; i < tags.size(); i++)
    {
      if (tags.get(i).value == tag)
      { 
        // check is tag 
        index = i;
      }
    }

    if (index >= 0)
    { 
      Tag t = tags.get(index);
      t.timestamp = timestamp; 
      return true;
    }
    else
    {
      int oldest = 0, t = Integer.MAX_VALUE;
      for (int i = 0; i < tags.size(); i++)
      { 
        // find the lru
        if (tags.get(i).timestamp < t)
        {
          oldest = i;
          t = tags.get(i).timestamp;
        }
      }      
      tags.get(oldest).value = tag; // replace lru
      tags.get(oldest).timestamp = timestamp; // set write timestamp
    }
    
    return false;
  }
}

class Tag
{
  int value, timestamp;
  //setup
  Tag()
  {
    value = -1; 
    timestamp = 0; 
  }
}
