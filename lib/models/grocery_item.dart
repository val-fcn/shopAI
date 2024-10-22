class GroceryItem {
  GroceryItem({
    required this.name,
    required this.quantity,
    required this.purchased,
  });

  final String name;
  final int quantity;
  final bool purchased;
}

class GroceryList {
  GroceryList({required this.name, required this.items});

  final String name;
  final List<GroceryItem> items;
}
