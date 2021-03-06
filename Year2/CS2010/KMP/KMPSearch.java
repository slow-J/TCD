public class KMPSearch 
{

  /*
   * Bus Service Questions:
   *
   * 1. How many total vehicles is there information on?
   *    987
   *
   * 2. Does the file contain information about the vehicle number 16555?
   *    true
   *
   * 3. Locate the first record about a bus heading to HAMPTON PARK
   *    index number:: 19605
   *
   * 4. Does the file contain information about the vehicle number 9043409?
   *    false
   */

   /*
   * The method checks whether a pattern pat occurs at least once in String txt.
   *
   */
  public static boolean contains(String txt, String pat)
  {
    if(txt.length()<1||pat.length()<1)
       return false;
    int lenP = pat.length();
    int lenT = txt.length();
    int i, j;
    for (i = 0, j = 0; i < lenT && j < lenP; i++)
    {
      if (txt.charAt(i) == pat.charAt(j))
        j++;
      else
      {
        i -= j;
        j = 0;
      }
    }   
    if (j == lenP)
      return true; // found
    else 
      return false; // not found
  }

  /*
   * The method returns the index of the first ocurrence of a pattern pat in
   * String txt. It should return -1 if the pat is not present
   */
  public static int searchFirst(String txt, String pat)
  {
    if(txt.length()<1||pat.length()<1)
      return -1;
    int lenP = pat.length();
    int lenT = txt.length();
    int i, j;
    for (i = 0, j = 0; i < lenT && j < lenP; i++)
    {
      if (txt.charAt(i) == pat.charAt(j))
        j++;
      else
      {
        i -= j;
        j = 0;
      }
    }
    if (j == lenP)
      return i - lenP; // found
    else
      return -1; // pattern not present
  }

  /*
   * The method returns the number of non-overlapping occurences of a pattern pat in String txt.
   */
  public static int searchAll(String txt, String pat) 
  {
    int lenP = pat.length();
    int lenT = txt.length();
    int i, j;
    int patFound=0;
    for (i = 0, j = 0; i < lenT && j < lenP; i++)
    {
      if (txt.charAt(i) == pat.charAt(j))
        j++;
      else
      {
        i -= j;
        j = 0;
      }
      if (j == lenP)
      {  
        patFound++;
        j=0;
      }
    }
    return patFound;
  }
}