import 'package:flutter/material.dart';
import 'package:shop_ai/env/view/add_list.dart';

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
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No shopping list yet'),
          ],
        ),
      ),
    );
  }
}
