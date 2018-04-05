

import java.util.ArrayList;
import java.util.Scanner;

public class Inventory {

	static ArrayList<Item> itemList;
	static ArrayList<Order> orderCollection;
	public static int itemId=0;
	
	public static void main(String[] args) {
		
		Inventory inventory = new Inventory();
		itemList = new ArrayList<Item>();
		orderCollection = new ArrayList<Order>();
		
		System.out.println("How many items would you like to create?");
		Scanner input = new Scanner(System.in);
		int numberOfItems = input.nextInt();
			
		for(int i=0; i<numberOfItems; i++){
			System.out.println("Please enter the name, price and quantity (separatad by commas) for item number:" +(i+1));
			String itemData = input.next();
			String[] itemDataArray = itemData.split(",");
			String itemName = itemDataArray[0];
			double itemPrice = Double.parseDouble(itemDataArray[1]);
			int quantity = Integer.parseInt(itemDataArray[2]);
			for(int index=0; index<itemList.size();index++)
			{
				Item tempItem = itemList.get(index);
				if(itemPrice==tempItem.getPrice() && (itemName.equalsIgnoreCase(tempItem.getName())))
					quantity++;
			}
			inventory.addItem(itemName, itemPrice, quantity);
			inventory.createOrder(itemList.get(i));
	
		}
	}
	public void addItem(String itemName, double itemPrice, int itemQuantity){
		
		Item item = new Item(itemId++, itemName, itemPrice, itemQuantity);
		itemList.add(item);
		System.out.println("Item added.");
	}
	public void createOrder(Item item){
		Order order = new Order(item);
		order.setOrderID(order.getOrderID()+1);
		orderCollection.add(order);
	}
}
