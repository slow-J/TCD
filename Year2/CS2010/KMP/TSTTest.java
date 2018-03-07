import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNull;

import org.junit.Test;

public class TSTTest {

  @Test
  public void testEmpty(){
    TST<Long> trie = new TST<>();
    assertEquals("size of an empty trie should be 0",0, trie.size());
    assertFalse("searching an empty trie should return false",trie.contains(""));
    assertNull("getting from an empty trie should return null",trie.get(""));
  }
}
