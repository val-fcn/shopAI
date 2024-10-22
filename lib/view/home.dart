import 'package:flutter/material.dart';
import 'package:shop_ai/data/dummy_data.dart';
import 'package:shop_ai/view/add_list.dart';
import 'package:shop_ai/view/list_details.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Shopping list'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddListView(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: groceryList.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(groceryList[index].name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListDetailsView(
                    groceryList: groceryList[index],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
