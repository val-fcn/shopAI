import 'package:uuid/uuid.dart';

class ShoppingItem {
  final String id;
  final String name;
  final num quantity;
  final String unit;
  bool isChecked;

  ShoppingItem({
    String? id,
    required this.name,
    required this.quantity,
    required this.unit,
    this.isChecked = false,
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'unit': unit,
      'isChecked': isChecked,
    };
  }

  factory ShoppingItem.fromJson(Map<String, dynamic> json) {
    return ShoppingItem(
      name: json['name'],
      quantity: json['quantity'],
      unit: json['unit'],
      isChecked: json['isChecked'] ?? false,
    );
  }
}

class ShoppingList {
  final String id;
  final String title;
  final DateTime createdAt;
  final List<ShoppingItem> items;

  ShoppingList({
    String? id,
    required this.title,
    DateTime? createdAt,
    List<ShoppingItem>? items,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        items = items ?? [];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  factory ShoppingList.fromJson(Map<String, dynamic> json) {
    return ShoppingList(
      id: json['id'],
      title: json['title'],
      createdAt: DateTime.parse(json['createdAt']),
      items: (json['items'] as List)
          .map((item) => ShoppingItem.fromJson(item))
          .toList(),
    );
  }
}
