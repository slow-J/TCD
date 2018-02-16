
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
	static final int DEFAULT_SRC_PORT = 50000;
	static final int DEFAULT_DST_PORT = 50001;	
	static final String DEFAULT_DST_NODE = "localhost";
	private byte lastPack; 
	private byte[] lastPayload;
	Terminal terminal;
	InetSocketAddress dstAddress;

	/**
	 * Constructor
	 * 
	 * Attempts to create socket at given port and create an InetSocketAddress
	 * for the destinations
	 */
	Client(Terminal terminal, String dstHost, int dstPort, int srcPort) throws SocketTimeoutException
	{
		try 
		{
			this.terminal = terminal;
			dstAddress = new InetSocketAddress(dstHost, dstPort);
			socket = new DatagramSocket(srcPort);
			
			listener.go();
		} 
		catch (java.lang.Exception e) 
		{
			e.printStackTrace();
		}
		
	}
	public byte getLastPack() 
	{
		return lastPack;
	}
	
	public void setLastPack(byte lastPack) 
	{
		this.lastPack = lastPack;
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
		try 
		{
			String err = "" + -1;
			StringContent content = new StringContent(packet);
			String errorCheck = content.toString();
			if (errorCheck.equals(err))
			{
				socket.setSoTimeout(10000);
				terminal.println("Wrong packet received");
				DatagramPacket packet2 = null;
				byte[] payload = null;
				byte[] header = null;
				byte[] buffer = null;

				payload = getLastPayload();

				header = new byte[PacketContent.HEADERLENGTH];
				header[0] = getLastPack();
				header[1] = 1; // to server
				buffer = new byte[header.length + payload.length];
				System.arraycopy(header, 0, buffer, 0, header.length);
				System.arraycopy(payload, 0, buffer, header.length, payload.length);

				terminal.println("REsending packet ...");
				packet2 = new DatagramPacket(buffer, buffer.length, dstAddress);

				socket.send(packet2);

				terminal.println("Packet REsent");
			} 
			else 
			{
				this.notify();
				terminal.println(content.toString());
			}
		} 
		catch (SocketTimeoutException s) 
		{
			System.out.println("Socket timed out after 10 seconds!");
			s.printStackTrace();

		} 
		catch (IOException e) 
		{
			e.printStackTrace();
		}

	}
	
	

	/**
	 * Sender Method
	 * 
	 */
	public synchronized void start() throws SocketTimeoutException
	{
		try
		{
			socket.setSoTimeout(10000);
			byte packetNumber = 0;
			byte recNumber = 1;
			while (true) {
				DatagramPacket packet = null;

				byte[] payload = null;
				byte[] header = null;
				byte[] buffer = null;

				payload = (terminal.readString("String to send: ")).getBytes();
				setLastPayload(payload);
				header = new byte[PacketContent.HEADERLENGTH];
				header[0] = packetNumber;
				header[1] = recNumber;
				buffer = new byte[header.length + payload.length];
				System.arraycopy(header, 0, buffer, 0, header.length);
				System.arraycopy(payload, 0, buffer, header.length, payload.length);

				terminal.println("Sending packet ...");
				packet = new DatagramPacket(buffer, buffer.length, dstAddress);

				socket.send(packet);
				terminal.println("Packet sent");
				setLastPack(packetNumber);
				this.wait();
				if (packetNumber >= 127) 
				{
					packetNumber = 0;
				} else {
					packetNumber++;
				}
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
		catch (InterruptedException e) 
		{
			// TODO Auto-generated catch block
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
			(new Client(terminal, DEFAULT_DST_NODE, DEFAULT_DST_PORT, DEFAULT_SRC_PORT)).start();
			
			terminal.println("Program completed");
		}
		catch (java.lang.Exception e) 
		{
			e.printStackTrace();
		}
		
	}
}