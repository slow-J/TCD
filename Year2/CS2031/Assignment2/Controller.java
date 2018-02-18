public class Controller 
{	//router/source/destination
	private static int[][] ROUTINGTABLE = {{0,1,6}, {2001,0,10001}, {10001,2001,10002}, {10002, 10001, 2002},{2002,10002,10003}, {10003, 2002, 10004},
			{10004,10003,2003},{2003,10004,10005},{10005,2003,10006},{10006,10005,2004},{2004, 10006, 10007},{10007,2004,10008},{10008,10007,2005},
			{2005,10008,10009},{10009,2005,10010},{10010,10009,2006},{2006,10010,0}};
	
	public static int getOut(int finalD, int port)
	{ 
		int ret = 0;
		int dest=0;
		int x =0;
		for (int i=1; i<ROUTINGTABLE.length ; i++)
		{
			if (ROUTINGTABLE[i][0] == port )
				x= i;
		}
		
		if (ROUTINGTABLE[0][2]==finalD)
			dest=2;
		else	
			dest=1;		
			
		ret = ROUTINGTABLE[x][dest];			
		return ret;
	}
	
	public static int[] getOut( int port)
	{ 
		int ret[] = new int[2];
		int dest=2;
		int src=1;
		int x =0;
		for (int i=1; i<ROUTINGTABLE.length ; i++)
		{
			if (ROUTINGTABLE[i][0] == port )
				x= i;
			
		}					
		ret[0] = ROUTINGTABLE[x][dest];
		ret[1] = ROUTINGTABLE[x][src];				
		return ret;
	}
}