
public class Connect4Grid2DArray implements Connect4Grid
{
	private static final int WIDTH = 7;
	private static final int HEIGHT = 6;
	private static char[][] grid=new char[HEIGHT][WIDTH];
	private static final char EMPTY = ' ';
	private static final char RED = 'R';
	private static final char YELLOW = 'Y';
	
	public void emptyGrid()
	{
		for (int row = 0; (row < grid.length); row++)
			for (int column = 0; (column < grid[row].length); column++)
				grid[row][column] = EMPTY;
	}
	public String toString()
	{
		String a="";
		for (int row = -1; (row <= grid.length); row++)
		{
			a+=("|");
			for (int column = 0; (column < grid[0].length); column++)
				if ((row == -1) || (row == grid.length))
					a+=("-");
				else System.out.print(grid[row][column]);
			a+=("|");
		}
		return a;
	}
	public boolean isValidColumn(int column)
	{
		if(column<=HEIGHT)
			return true;
		return false;
	}
	public boolean isColumnFull(int column)
	{
		if(grid[0][column-1] == EMPTY)
			return true;
		return false;
	}
	public void dropPiece(ConnectPlayer player, int column)
	{
		boolean end =false;
		if (isColumnFull(column)==false)
		{
			for (int i =HEIGHT;i>=0;i--)
			{
				if(grid[i][column-1] == EMPTY)
				{
					grid[i][column-1] = player.getSymbol();
					end=true;
				}

			}
		}
		else
		{
			System.out.print("ERROR COLUMN IS FULL");
		}
	}	
	public boolean didLastPieceConnect4()
	{
        int count = 0;
        boolean check = false;
        int player = 0;
        char token = ' ';
       
		while(player<2)
		{
			switch (player) 
			{
				case 0:  token = RED;
					break;
				case 1:  token = YELLOW;
					break;
			}
			for (int row = 0; row < HEIGHT; row++)//vertical check
			{
				count=0;
				for (int column = 0; column < WIDTH; column++)
				{
					if (count>=4)
					{
						check=true;
					}
					if (grid[row][column] == token)
					{
						count++;
					}
					else
					{
						count=0;
					}
				}
			}
			for (int column = 0; column < WIDTH; column++)//horizontal check
			{
				count=0;
				for (int row = 0; row<HEIGHT; row++)
				{
					if (count>=4)
					{
						check=true;
					}
					
					if (grid[row][column] == token)
					{
						count++;
					}
					else
					{
						count=0;
					}
				}
			}

			for (int row = 3; row <= HEIGHT; row++)//back slash check
			{
				for (int column = 0; column < WIDTH-3; column++)  
				{
					if (grid[row][column] == token && grid[row-1][column+1] == token && grid[row-2][column+2] == token && grid[row-3][column+3] == token)
		               check=true;
				}
			}
			for (int row = 3; row <= HEIGHT; row++)//forward slash check
			{
				for (int column = 3; column < WIDTH; column++)
				{
					if (grid[row][column] == token && grid[row-1][column-1] == token && grid[row-2][column-2] == token && grid[row-3][column-3] == token)
		               check=true;
				}
			}
			player++;
		}
		return check;
	}
	public boolean isGridFull()
	{
		int count=WIDTH;
		for (int i = 0; (i < WIDTH); i++)
		{ 
				if (grid[0][i] == EMPTY)
					count--;				
		}
		if(count==WIDTH)
			return true;
		return false;
	}

}
