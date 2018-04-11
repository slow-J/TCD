import java.util.Scanner;
import java.util.Arrays;
import java.util.Random;

public class Cipher 
{
	public static void main(String[] args)
	{
		char[] alphabet = "abcdefghijklmnopqrstuvwxyz ".toCharArray();
		char[] randomAlphabet = alphabet.clone();
		
		System.out.print("Enter text to encrypt: ");
		Scanner scanner = new Scanner(System.in);
		String myString = scanner.nextLine();		
		String lowercaseString = myString.toLowerCase();
		
		char[] characterArray = lowercaseString.toCharArray();
		char[] encryptedArray = new char[characterArray.length];
		char[] decryptedArray = new char[encryptedArray.length];
		
		createCipher(characterArray, alphabet, randomAlphabet);
		
		System.out.println("Your encrypted message is: " 
					+ anEncrypt(characterArray, encryptedArray, randomAlphabet, alphabet));
		System.out.println("Your messgage decrypted is: " 
					+ crypt(encryptedArray, decryptedArray, randomAlphabet, alphabet));
	}
	public static void createCipher(char[] characterArray, char[] alphabet, char[] randomAlphabet)
	//determines and returns the mapping from plain text to cipher text.
	{
		
		if (randomAlphabet!=null)
		{
			Random generator = new Random();
		    for (int index=0; index<randomAlphabet.length; index++ )
		    {
		      int otherIndex = generator.nextInt(randomAlphabet.length);
		      char temp = randomAlphabet[index];
		      randomAlphabet[index] = randomAlphabet[otherIndex];
		      randomAlphabet[otherIndex] = temp;
		    }
		 }
		System.out.println("The cypher used to encypt your message is: " + Arrays.toString(randomAlphabet));

	}
	public static String anEncrypt(char[] characterArray, char[] encryptedArray, char[] randomAlphabet, char[] alphabet)
	{
		String encrypt = "";
		if (characterArray!=null)
		{
			
		    for (int index=0; index<characterArray.length; index++ )
		    {
		    
		    	char temp = characterArray[index];
		   
		    	 for (int index2=0; index2<alphabet.length; index2++ )
				    {
		    		 	char temp2 = alphabet[index2];
		    		 	if (temp==temp2)
		    		 	{
		    		 		encryptedArray[index] =randomAlphabet[index2];
		    		 	}
				    }
		     
		    }
		    encrypt =  new String(encryptedArray);
		    
		}
		return encrypt;
	}
	public static String crypt(char[] encryptedArray, char[] decryptedArray, char[] randomAlphabet, char[] alphabet)
	{
		String decrypted = "";
		if (encryptedArray!=null)
		{
			
		    for (int index=0; index<encryptedArray.length; index++ )
		    {
		    	char temp = encryptedArray[index];
		    
		    	 for (int index2=0; index2<randomAlphabet.length; index2++ )
				    {
		    		 	char temp2 = randomAlphabet[index2];
		    		 	if (temp==temp2)
		    		 	{
		    		 		decryptedArray[index] = alphabet[index2];
		    		 	}
				    }
		        
		    
		    }
		    decrypted = new String(decryptedArray);
		    decrypted= decrypted.toUpperCase();
		}
		return decrypted;
	}
}

