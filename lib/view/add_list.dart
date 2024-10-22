import 'package:flutter/material.dart';

class AddListView extends StatefulWidget {
  const AddListView({super.key});

  @override
  State<AddListView> createState() => _AddListViewState();
}

class _AddListViewState extends State<AddListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New list'),
      ),
      body: Center(
        child: Column(
          children: [
            Form(
                child: Column(
              children: [
                const Text('take picture'),
                TextFormField(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
