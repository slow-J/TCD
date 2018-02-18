
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetSocketAddress;

import tcdIO.Terminal;

public class Server extends Node 
{
	private byte nextPack = 0;
	static final int DEFAULT_SRC_PORT = 50000;
	static final int DEFAULT_PORT = 50002;
	static final int DEFAULT_DST_PORT = 50001;
	static final String DEFAULT_DST_NODE = "localhost";
	Terminal terminal;
	InetSocketAddress dstAddress;
	
	/* Server class
	 * 
	 */
	Server(Terminal terminal, int port) 
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
			String seq = "";
			StringContent content= new StringContent(packet);			
			terminal.println("Packet received " + content.toString());
			
			byte[] buffer = packet.getData();
			byte ack = buffer[0];
			byte err = -1;								// if error occurs send back -1
			boolean error = false;
			if (ack == 127)
				ack=0;
			else
				ack++;
			if (getNextPack() == 127)
			{
				if (ack == 0)
					seq = Byte.toString(ack);
				else
				{
					error = true;
				}	
			}
			else
			{				
				if (ack == getNextPack() + 1)
					seq = Byte.toString(ack);
				else
				{
					error = true;
				}				
			}	
			
			DatagramPacket response;
			if (error != true)
			{
				response= (new StringContent("ACK" + seq)).toDatagramPacket();
				setNextPack(ack);
			}
			else
				response= (new StringContent(""+err).toDatagramPacket());
			
			response.setSocketAddress(packet.getSocketAddress());
			socket.send(response);
			 
			
		}
		catch(Exception e) {e.printStackTrace();}
	}

	
	public byte getNextPack() 
	{
		return nextPack;
	}

	public void setNextPack(byte nextPack) 
	{
		this.nextPack = nextPack;
	}

	public synchronized void start() throws Exception 
	{
		terminal.println("Waiting for contact from gateway");
		this.wait();
	}
	
	/*
	 * 
	 */
	public static void main(String[] args) 
	{
		try 
		{					
			Terminal terminal= new Terminal("Server");
			(new Server(terminal, DEFAULT_PORT)).start();
			terminal.println("Program completed");
		} catch(java.lang.Exception e) {e.printStackTrace();}
	}
}
