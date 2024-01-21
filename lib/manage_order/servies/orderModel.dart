class OrderItem {
  final String itemName;
  final double price;
  int quantity;

  OrderItem({required this.itemName, required this.price, this.quantity = 1});
}