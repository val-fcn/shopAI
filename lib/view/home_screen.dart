import 'package:flutter/material.dart';
import 'package:shop_ai/data/test_data.dart';
import 'package:shop_ai/models/shopping_item.dart';
import 'package:shop_ai/services/ai_service.dart';
import 'package:shop_ai/services/storage_service.dart';
import 'package:shop_ai/view/create_list_screen.dart';
//import 'package:shop_ai/view/add_list.dart';
import 'package:shop_ai/view/details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.storageService,
  });

  final StorageService storageService;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ShoppingList> _shoppingLists = [];

  @override
  void initState() {
    super.initState();
    _loadLists();
  }

  Future<void> _loadLists() async {
    final lists = await widget.storageService.getLists();
    if (lists.isEmpty) {
      // Charger les données de test si aucune donnée n'existe
      await TestData.loadTestData(widget.storageService);
      final testLists = await widget.storageService.getLists();
      setState(() {
        _shoppingLists = testLists;
      });
    } else {
      setState(() {
        _shoppingLists = lists;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping list'),
      ),
      body: ListView.builder(
          itemCount: _shoppingLists.length,
          itemBuilder: (context, index) {
            final list = _shoppingLists[index];
            return Dismissible(
              key: Key(list.id),
              direction: DismissDirection.endToStart,
              onDismissed: (_) async {
                await widget.storageService.deleteList(
                  (list.id),
                );
                _loadLists();
              },
              child: Card(
                child: ListTile(
                  title: Text(list.title),
                  subtitle: Text(
                    "${list.createdAt.day}/${list.createdAt.month}/${list.createdAt.year}",
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          shoppingList: list,
                          storageService: widget.storageService,
                        ),
                      ),
                    ).then((_) => _loadLists());
                  },
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateListScreen(
                storageService: widget.storageService,
                aiService: AiService(),
              ),
            ),
          ).then((_) => _loadLists());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
