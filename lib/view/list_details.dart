import 'package:flutter/material.dart';
import 'package:shop_ai/data/dummy_data.dart';
import 'package:shop_ai/models/grocery_item.dart';

class ListDetailsView extends StatefulWidget {
  const ListDetailsView({
    super.key,
    required this.groceryList,
  });

  final GroceryList groceryList;

  @override
  State<ListDetailsView> createState() => _ListDetailsViewState();
}

class _ListDetailsViewState extends State<ListDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groceryList.name),
      ),
      body: ListView.builder(
        itemCount: widget.groceryList.items.length,
        itemBuilder: (context, index) => CheckboxListTile(
          value: widget.groceryList.items[index].purchased,
          onChanged: (value) {
            setState(() {
              value = value;
            });
          },
          title: Text(
            "${widget.groceryList.items[index].name} ${widget.groceryList.items[index].quantity}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
