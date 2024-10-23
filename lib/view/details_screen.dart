import 'package:flutter/material.dart';
import 'package:shop_ai/models/shopping_item.dart';
import 'package:shop_ai/services/storage_service.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    super.key,
    required this.shoppingList,
    required this.storageService,
  });

  final ShoppingList shoppingList;
  final StorageService storageService;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late ShoppingList _currentList;

  @override
  void initState() {
    super.initState();
    _currentList = widget.shoppingList;
  }

  void _toggleItem(ShoppingItem item) {
    setState(() {
      final index = _currentList.items.indexWhere((i) => i.id == item.id);
      if (index != -1) {
        _currentList.items[index].isChecked = !item.isChecked;
        widget.storageService.updateList(_currentList);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentList.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Crée le ${_currentList.createdAt.day}/${_currentList.createdAt.month}/${_currentList.createdAt.year}",
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _currentList.items.length,
              itemBuilder: (context, index) {
                final item = _currentList.items[index];
                return CheckboxListTile(
                  title: Text(item.name),
                  subtitle: Text(item.quantity),
                  value: item.isChecked,
                  onChanged: (_) => _toggleItem(item),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
