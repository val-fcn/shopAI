import 'package:flutter/material.dart';

class AddListView extends StatefulWidget {
  const AddListView({super.key});

  @override
  State<AddListView> createState() => _AddListViewState();
}

class _AddListViewState extends State<AddListView> {
  var isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New shopping list'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt),
          )
        ],
      ),
      body: Center(
          child: Column(
        children: [
          const Text('take picture'),
          Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  isChecked = !isChecked;
                },
              ),
              const Text('beurre'),
              const Text('6'),
            ],
          )
        ],
      )),
    );
  }
}
