import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.SocketException;
import java.util.concurrent.CountDownLatch;

public abstract class Node {
	static final int PACKETSIZE = 65536;

	DatagramSocket socket;
	Listener listener;
	CountDownLatch latch;
	
	Node()
	{
		latch= new CountDownLatch(1);
		listener= new Listener();
		listener.setDaemon(true);
		listener.start();
	}
	
	
	public abstract void onReceipt(DatagramPacket packet);
	
	/**
	 *
	 * Listener thread
	 * 
	 * Listens for incoming packets on a datagram socket and informs registered receivers about incoming packets.
	 */
	class Listener extends Thread
	{
		
		/*
		 *  Telling the listener that the socket has been initialized 
		 */
		public void go()
		{
			latch.countDown();
		}
		
		/*
		 * Listen for incoming packets and inform receivers
		 */
		public void run() 
		{
			try 
			{
				latch.await();
				// Endless loop: attempt to receive packet, notify receivers, etc
				while(true) 
				{
					DatagramPacket packet = new DatagramPacket(new byte[PACKETSIZE], PACKETSIZE);
					socket.receive(packet);
					onReceipt(packet);
				}
			}
			catch (Exception e) 
			{if (!(e instanceof SocketException)) e.printStackTrace();}
			
		}
	}
}