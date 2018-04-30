import java.util.Scanner;
import java.util.Arrays;
public class LewisCarroll
{

	public static void main(String[] args)
	{  
		String[] fullDictionary = readDictionary();
		String[] readWords = readWordList();
		if(isWordChain(readWords, fullDictionary)==true)
		{
			System.out.println("Valid chain of words from Lewis Carroll's word-links game.");
		}
		else
		{
			System.out.println("Not a valid chain of words from Lewis Carroll's word-links game.");
		}
	}

	public static String[] readDictionary()
	{
		In words = new In("words.txt");
		String dictionary = words.readAll();
		String[] word1Array = dictionary.split("\n");
		Arrays.sort(word1Array);
		return word1Array;
	}
	public static String[] readWordList()
	{
		System.out.print("Enter a comma separated list of words: ");
		Scanner scanner = new Scanner(System.in);		
		String a = scanner.next();
		String[] word2Array = a.split(",");
		System.out.println(Arrays.toString(word2Array));
	
		scanner.close();
		return word2Array;
	}
	public static boolean isUniqueList(String[] words)
	{
		boolean isUnique=true;
		if (words !=null)
		{
			
			for (int i =0; i<words.length; i++)
			{
				for (int index2=0; index2<words.length; index2++)
				{
					if (index2!=i)
					{
						if (words[i].equals(words[index2]))
						{
							isUnique=false;	
						}
					}
					else
					{

					}
				}
			}
		}
		return isUnique;
	}
	public static boolean isEnglishWord(String word, String[] fullDictionary)
	{
		boolean isEnglish=false;
		int binarySearch = Arrays.binarySearch(fullDictionary, word);
		if (binarySearch<0)
			{
				isEnglish = true;
			}
		return isEnglish;
	}
	public static boolean isDifferentByOne(String first, String second)
	{
		int change = 1;
		if(first.equals(second)) 
			return true;

		if(first.length() == second.length())
		{ 
			for(int i = 0; i < first.length(); i++)
			{ 
				if(first.charAt(i) != second.charAt(i)) 
				{ 
					change--;
					if(change < 0) 
					{ 
						return false; 
					}
				}
			}
		}
		else
		{
			return false;
		}

		return true;
	}
	public static boolean isWordChain(String[] words, String[] fullDictionary)
	{
		boolean condition =true;
		if (isUniqueList(words)==false)
		{
			condition =false;
		}
		
		for (int i =0; i<words.length; i++)
		{
			String wordTested = words[i];
			if(isEnglishWord(wordTested, fullDictionary)==false)
			{
				condition=false;	
			}
		}
	
		for (int i=0; i<words.length-1; i++)
		{
			String first = words[i];
			String second = words[i+1];
			if(isDifferentByOne(first, second)==false)
			{
				condition = false;
			}
		}
		return condition;
	}
}
/*Other Methods for Manipulating Strings
If you want to get more than one consecutive character from a string, you can use the substring method. The substring method has two versions, as shown in the following table:
String anotherPalindrome = "Niagara. O roar again!"; 
char aChar = anotherPalindrome.charAt(9);
The substring Methods in the String Class
Method	Description
String substring(int beginIndex, int endIndex)	Returns a new string that is a substring of this string. The substring begins at the specified beginIndex and extends to the character at index endIndex - 1.
String substring(int beginIndex)	Returns a new string that is a substring of this string. The integer argument specifies the index of the first character. Here, the returned substring extends to the end of the original string.
The following code gets from the Niagara palindrome the substring that extends from index 11 up to, but not including, index 15, which is the word "roar":

String anotherPalindrome = "Niagara. O roar again!"; 
String roar = anotherPalindrome.substring(11, 15); 
Here are several other String methods for manipulating strings:

Other Methods in the String Class for Manipulating Strings
Method	Description
String[] split(String regex)
String[] split(String regex, int limit)	Searches for a match as specified by the string argument (which contains a regular expression) and splits this string into an array of strings accordingly. The optional integer argument specifies the maximum size of the returned array. Regular expressions are covered in the lesson titled "Regular Expressions."
CharSequence subSequence(int beginIndex, int endIndex)	Returns a new character sequence constructed from beginIndex index up until endIndex - 1.
String trim()	Returns a copy of this string with leading and trailing white space removed.
String toLowerCase()
String toUpperCase()	Returns a copy of this string converted to lowercase or uppercase. If no conversions are necessary, these methods return the original string.
Searching for Characters and Substrings in a String

Here are some other String methods for finding characters or substrings within a string. The String class provides accessor methods that return the position within the string of a specific character or substring: indexOf() and lastIndexOf(). The indexOf() methods search forward from the beginning of the string, and the lastIndexOf() methods search backward from the end of the string. If a character or substring is not found, indexOf() and lastIndexOf() return -1.

The String class also provides a search method, contains, that returns true if the string contains a particular character sequence. Use this method when you only need to know that the string contains a character sequence, but the precise location isn't important.

The following table describes the various string search methods.

The Search Methods in the String Class
Method	Description
int indexOf(int ch)
int lastIndexOf(int ch)	Returns the index of the first (last) occurrence of the specified character.
int indexOf(int ch, int fromIndex)
int lastIndexOf(int ch, int fromIndex)	Returns the index of the first (last) occurrence of the specified character, searching forward (backward) from the specified index.
int indexOf(String str)
int lastIndexOf(String str)	Returns the index of the first (last) occurrence of the specified substring.
int indexOf(String str, int fromIndex)
int lastIndexOf(String str, int fromIndex)	Returns the index of the first (last) occurrence of the specified substring, searching forward (backward) from the specified index.
boolean contains(CharSequence s)	Returns true if the string contains the specified character sequence.
Note: CharSequence is an interface that is implemented by the String class. Therefore, you can use a string as an argument for the contains() method.
Replacing Characters and Substrings into a String

The String class has very few methods for inserting characters or substrings into a string. In general, they are not needed: You can create a new string by concatenation of substrings you have removed from a string with the substring that you want to insert.

The String class does have four methods for replacing found characters or substrings, however. They are:

Methods in the String Class for Manipulating Strings
Method	Description
String replace(char oldChar, char newChar)	Returns a new string resulting from replacing all occurrences of oldChar in this string with newChar.
String replace(CharSequence target, CharSequence replacement)	Replaces each substring of this string that matches the literal target sequence with the specified literal replacement sequence.
String replaceAll(String regex, String replacement)	Replaces each substring of this string that matches the given regular expression with the given replacement.
String replaceFirst(String regex, String replacement)	Replaces the first substring of this string that matches the given regular expression with the given replacement.
An Example

The following class, Filename, illustrates the use of lastIndexOf() and substring() to isolate different parts of a file name.

Note: The methods in the following Filename class don't do any error checking and assume that their argument contains a full directory path and a filename with an extension. If these methods were production code, they would verify that their arguments were properly constructed.

public class Filename {
    private String fullPath;
    private char pathSeparator, 
                 extensionSeparator;

    public Filename(String str, char sep, char ext) {
        fullPath = str;
        pathSeparator = sep;
        extensionSeparator = ext;
    }

    public String extension() {
        int dot = fullPath.lastIndexOf(extensionSeparator);
        return fullPath.substring(dot + 1);
    }

    // gets filename without extension
    public String filename() {
        int dot = fullPath.lastIndexOf(extensionSeparator);
        int sep = fullPath.lastIndexOf(pathSeparator);
        return fullPath.substring(sep + 1, dot);
    }

    public String path() {
        int sep = fullPath.lastIndexOf(pathSeparator);
        return fullPath.substring(0, sep);
    }
}
Here is a program, FilenameDemo, that constructs a Filename object and calls all of its methods:


public class FilenameDemo {
    public static void main(String[] args) {
        final String FPATH = "/home/user/index.html";
        Filename myHomePage = new Filename(FPATH, '/', '.');
        System.out.println("Extension = " + myHomePage.extension());
        System.out.println("Filename = " + myHomePage.filename());
        System.out.println("Path = " + myHomePage.path());
    }
}
And here's the output from the program:

Extension = html
Filename = index
*/