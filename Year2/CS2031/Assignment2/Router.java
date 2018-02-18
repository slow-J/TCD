import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetSocketAddress;
import tcdIO.Terminal;

public class Router extends Node
{
	private int port;
	Terminal terminal;
	static final String DEFAULT_DST_NODE = "localhost";
	InetSocketAddress dstAddress;
	InetSocketAddress srcAddress;
	static int outs[] = new int[2];
	
	Router(Terminal terminal, int port) 
	{
		try 
		{
			setPort(port);
			this.terminal= terminal;
			socket= new DatagramSocket(port);
			listener.go();
		}
		catch(java.lang.Exception e) {e.printStackTrace();}
	}
	
	public void setPort(int p) 
	{
		this.port = p;
	}
	
	public void onReceipt(DatagramPacket packet) 
	{
		try
		{
			int dstPort;
			byte[] buffer = packet.getData();
			int dNumber = buffer[1] & 0xff;
			double R = this.port-10000;
			R = (Math.ceil(R-R/2));
			if (dNumber>R)
				dstPort= outs[0];
			else
				dstPort= outs[1];
					
			dstAddress = new InetSocketAddress(DEFAULT_DST_NODE, dstPort);
									
			StringContent content= new StringContent(packet);	
			terminal.println();
			terminal.println("Message received: "+content.toString()+ " and sent to port: " + dstPort);
			
			packet.setSocketAddress(dstAddress);
			
			socket.send(packet);
		}
		catch (IOException e) 
    	{
    		System.out.println(e);
    	}
		
	}
	public synchronized void start() throws Exception 
	{
		terminal.println("Waiting for contact");
		this.wait();
	}
	public static void main(String[] args) 
	{
		try 
		{		
			Terminal terminal= new Terminal("Router");
			int routerPortNumber = terminal.readInt("Router number(1/2/3/4/5/6/7/8/9/10): ");
			routerPortNumber += 10000;
			outs = Controller.getOut(routerPortNumber);
			(new Router(terminal, routerPortNumber)).start();
			
			terminal.println("Program completed");
		} catch(java.lang.Exception e) {e.printStackTrace();}
	}
}