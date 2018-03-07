
import java.util.LinkedList;


public class TST<Value> {

  /*
   * Bus Service Questions:
   * 1. How many unique destinations is there in the file?
   *    //TODO
   * 2. Is there a bus going to the destination "SOUTHSIDE"?
   *    //TODO
   * 3. How many records is there about the buses going to the destination beginning with "DOWN"?
   *    //TODO
   *
   * Google Books Common Words Questions:
   * 4. How many words is there in the file?
   *    //TODO
   * 5. What is the frequency of the word "ALGORITHM"?
   *    //TODO
   * 6. Is the word "EMOJI" present?
   *   //TODO
   * 7. IS the word "BLAH" present?
   *   //TODO
   * 8. How many words are there that start with "TEST"?
   *    //TODO
   */
  /* A Node in your trie containing a Value val and a pointer to its children */
  private static class Node<Value> {
		private char c;                        // character
        private Node<Value> left, mid, right;  // left, middle, and right subtries
        private Value val;                     // value associated with string
  }

  /* a pointer to the start of your trie */
  private TrieNode root = new TrieNode();

  /*
   * Returns the number of words in the trie
   */
  public int size() {
    //TODO: Implement method
    return -1;
  }

  /*
   * returns true if the word is in the trie, false otherwise
   */
  public boolean contains(String key) {
    //TODO: implement method
    return false;
  }

  /*
   * return the value stored in a node with a given key, returns null if word is not in trie
   */
  public Value get(String key) {
    //TODO: implement method
    return null;
  }

  /*
   * stores the Value val in the node with the given key
   */
  public void put(String key, Value val) {
    //TODO: implement method
  }

  /*
   * returns the linked list containing all the keys present in the trie
   * that start with the prefix passes as a parameter, sorted in alphabetical order
   */
  public LinkedList<String> keysWithPrefix(String prefix) {
    //TODO: implement method
    return null;
  }
}
