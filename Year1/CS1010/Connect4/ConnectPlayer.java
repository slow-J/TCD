import java.util.Random;
abstract class ConnectPlayer
{
	protected static final int WIDTH = 7;
	protected static final char RED = 'R';
	protected static final char YELLOW = 'Y';
	protected Connect4Grid board;
	abstract public char getSymbol();
	abstract public void setBoard(Connect4Grid board);
}

class C4HumanPlayer extends ConnectPlayer
{
	
	public void setBoard(Connect4Grid board)
    {
        this.board = board;
    }
	Random generator = new Random();
	
	public char getSymbol()
	{
		if (true==true)
			return RED;
		return YELLOW;
	}
	int dropLocation = generator.nextInt(WIDTH);
	if(board.isColumnFull(dropLocation)==true)
	{
		
	}
}

class C4RandomAIPlayer extends ConnectPlayer
{
	public void setBoard(Connect4Grid board)
    {
        this.board = board;
    }
	public char getSymbol()
	{
		return YELLOW;
	}
}