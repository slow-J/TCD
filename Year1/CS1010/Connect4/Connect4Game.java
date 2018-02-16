import java.util.Scanner;

public class Connect4Game
{
	public static final int AI_PLAYER = 0;
	public static final int PLAYER2 = 1;
    
    
	public static void main(String[] args)
	{
		int win = 0;// 0 = draw 1=lose 2=win
		int enemy;
		int selection;
		boolean quit = false;
		Connect4Grid gameGrid = new Connect4Grid();
		gameGrid.toString();
		System.out.println("WELCOME to CONNECT 4");		
		System.out.println("Please type 0 (0) for an AI opponent\nPlease type 2 (2) to play 2 player mode");
		Scanner scanner = new Scanner(System.in);
		selection = scanner.nextInt();
		if (selection == 0)
			enemy=AI_PLAYER;
		if (selection == 1)
			enemy= PLAYER2;
		while (quit==false)
		{
		
		}
		
		
		if (win==0)
		{
			System.out.println("A stalemate: you drew");
		}
		else if (win==1)
		{
			System.out.println("Unlucky, you lost");
		}
		else if (win==2)
		{
			System.out.println("Congratulations, you won");
		}
		
	}
}
/*Connect4Game class
A class whose objects represent an executing Connect Four two-player game application.
 The class will allow a user to start a new Connect Four game involving two players whose types are chosen by the user. 
 This class consists of a mainline which handles user input. The class creates a grid using the connect4Grid interface and a human player and a computer player using the player abstract class.

Connect4Grid interface
An interface with the following (abstract) methods:
public void emptyGrid();
public String toString();
public boolean isValidColumn(Integer column);
public boolean isColumnFull(Integer column);
public void dropPiece(Player player, Integer column);
public boolean didLastPieceConnect4();
public boolean isGridFull();   

Connect4Grid2DArray class 
This class implements the Connect4Grid interface and provides appropriate functionality for each of the methods in the interface

ConnectPlayer abstract class
An abstract class that provides the operations (methods) which any type of Connect Four Player class must override.

C4HumanPlayer class
A class which extends the ConnectPlayer abstract class and whose objects represent a human player (a user) who is involved in a Connect Four game.

C4RandomAIPlayer class
A class which extends the ConnectPlayer abstract class and whose objects represent Random AI Player (a computer) which is involved in a Connect Four game.


*/