

public class Item {
	private final long id;
	private String name;
	private int quantity;
	private double price;
	 public Item(long id, String
	name, double
	price, int quantity)
	{
	this.id = id;
	 this.name = name;
	 this.price = price;
	 this.quantity =
	quantity;
	}

	 public long getId()
	{
	return id;
	}

	public String getName()
	{
	return name;
	}
	public int getQuantity()
	{
	return quantity;
	}
	public double getPrice()
	{
	return price;
	}

}
