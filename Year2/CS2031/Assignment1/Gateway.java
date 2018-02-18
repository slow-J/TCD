
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetSocketAddress;

import tcdIO.Terminal;

public class Gateway extends Node 
{
	static final int DEFAULT_SRC_PORT = 50000;
	static final int DEFAULT_PORT = 50001;
	static final int DEFAULT_DST_PORT = 50002;
	static final String DEFAULT_DST_NODE = "localhost";
	
	Terminal terminal;
	InetSocketAddress dstAddress;
	InetSocketAddress srcAddress;
	/*
	 * 
	 */
	Gateway(Terminal terminal, int port)
	{
		try
		{
			this.terminal= terminal;
			socket= new DatagramSocket(port);
			listener.go();
		}
		catch(java.lang.Exception e) {e.printStackTrace();}
	}

	/**
	 * Assume that incoming packets contain a String and print the string.
	 */
	public void onReceipt(DatagramPacket packet)
	{
		try
		{

			dstAddress = new InetSocketAddress(DEFAULT_DST_NODE, DEFAULT_DST_PORT );
			srcAddress = new InetSocketAddress(DEFAULT_DST_NODE, DEFAULT_SRC_PORT );
			
			//print content on receival
			StringContent content= new StringContent(packet);			
			terminal.println(content.toString());
			
			byte[] buffer = packet.getData();
			int serv = 1;
			int recNumber = buffer[1] & 0xff;
			
			if (recNumber==serv)
				packet.setSocketAddress(dstAddress);
			else
				packet.setSocketAddress(srcAddress);
			
			socket.send(packet);
		}
		catch(Exception e) {e.printStackTrace();}
		
	}

	
	public synchronized void start() throws Exception 
	{
		terminal.println("Waiting for contact from client");
		this.wait();
	}
	
	/*
	 * 
	 */
	public static void main(String[] args) 
	{
		try 
		{					
			Terminal terminal= new Terminal("Gateway");
			(new Gateway(terminal, DEFAULT_PORT)).start();
			terminal.println("Program completed");
		} catch(java.lang.Exception e) {e.printStackTrace();}
	}
}
