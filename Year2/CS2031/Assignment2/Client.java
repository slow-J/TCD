import java.net.DatagramSocket;
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.InetSocketAddress;
import java.net.SocketTimeoutException;

import tcdIO.*;

/**
 *
 * Client class
 * 
 * An instance accepts user input
 *
 */
public class Client extends Node {
	static final int DEFAULT_SRC_PORT = 2001;
	static final int DEFAULT_DST_PORT = 1004;	
	static final String DEFAULT_DST_NODE = "localhost";
	private int port;
	private byte[] lastPayload;
	Terminal terminal;
	InetSocketAddress dstAddress;

	
	Client(Terminal terminal, String dstHost, int srcPort) throws SocketTimeoutException
	{
		try 
		{
			setPort(srcPort);
			this.terminal = terminal;			
			socket = new DatagramSocket(srcPort);			
			listener.go();
		} 
		catch (java.lang.Exception e) 
		{
			e.printStackTrace();
		}
		
	}
	public void setPort(int p) 
	{
		this.port = p;
	}
	
	public byte[] getLastPayload()
	{
		return lastPayload;
	}

	public void setLastPayload(byte[] lastPayload) 
	{
		this.lastPayload = lastPayload;
	}

	/**
	 * Assume that incoming packets contain a String and print the string.
	 */
	public synchronized void onReceipt(DatagramPacket packet) 
	{
		byte[] buffer = packet.getData();
		int dNumber = buffer[1] & 0xff;
		if ((this.port-2000)==dNumber)
		{	
			StringContent content = new StringContent(packet);
			terminal.println();
			terminal.println("--------------------------------------------------------------------");
			terminal.println("New message received: " + content.toString());
			terminal.println("String to send: ");
			this.notify();
		}
		else
		{	
			int outs;
			if (dNumber>this.port-2000)
				outs = Controller.getOut( 6, port);
			else 
				outs = Controller.getOut( 1, port);
			dstAddress = new InetSocketAddress(DEFAULT_DST_NODE, outs);
			terminal.println();
			terminal.println("Message relayed to port: " + outs);
			
			packet.setSocketAddress(dstAddress);
			
			try 
			{
				socket.send(packet);
			}
			catch (IOException e) 
			{
				e.printStackTrace();
			}
		}
	}
	
	
	public void start() throws SocketTimeoutException
	{
		try
		{
			while (true) 
			{
				Byte finDest=null;
				
				DatagramPacket packet = null;

				byte[] payload = null;
				byte[] header = null;
				byte[] buffer = null;
				
				terminal.println("--------------------------------------------------------------------");
				payload = (terminal.readString("String to send: ")).getBytes();
				setLastPayload(payload);
				header = new byte[PacketContent.HEADERLENGTH];
				
				finDest = terminal.readByte("Input message recepient(1/2/3/4/5/6): ");//select recipient
				
				
				header[1] = finDest;
				int outs;
				if ((int)finDest>this.port-2000)
					outs = Controller.getOut( 6, port);
				else 
					outs = Controller.getOut( 1, port);
				dstAddress = new InetSocketAddress(DEFAULT_DST_NODE, outs);
				buffer = new byte[header.length + payload.length];
				System.arraycopy(header, 0, buffer, 0, header.length);
				System.arraycopy(payload, 0, buffer, header.length, payload.length);
			
				terminal.println("Sending packet to port: "+ outs);
				packet = new DatagramPacket(buffer, buffer.length, dstAddress); //send packet to dest

				socket.send(packet);
				terminal.println("Message sent");
			}
		} 
		catch (SocketTimeoutException s) 
		{
			System.out.println("Socket timed out 10 seconds!");
			s.printStackTrace();
		}
		catch (IOException e) 
		{			
			e.printStackTrace();	
		}
		

	}
		

	/**
	 * Test method
	 * 
	 * Sends a packet to a given address
	 */
	public static void main(String[] args) 
	{
		try 
		{
			Terminal terminal = new Terminal("Client");
		
			int clientPortNumber = terminal.readInt("Client port number(1/2/3/4/5/6): ");
			clientPortNumber+=2000;
			(new Client(terminal, DEFAULT_DST_NODE, clientPortNumber)).start();

			terminal.println("Program completed");
		}
		catch (java.lang.Exception e) 
		{
			e.printStackTrace();
		}
		
	}
}