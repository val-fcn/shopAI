import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_ai/models/shopping_item.dart';

class StorageService {
  static const String _key = 'shopping_lists';
  late final SharedPreferences _prefs;

  StorageService(this._prefs);

  Future<List<ShoppingList>> getLists() async {
    final String? listsJson = _prefs.getString(_key);
    if (listsJson == null) return [];

    List<dynamic> decoded = jsonDecode(listsJson);
    return decoded.map((json) => ShoppingList.fromJson(json)).toList();
  }

  Future<void> saveLists(List<ShoppingList> lists) async {
    final String encoded =
        jsonEncode(lists.map((list) => list.toJson()).toList());
    await _prefs.setString(_key, encoded);
  }

  Future<void> addList(ShoppingList list) async {
    final lists = await getLists();
    lists.add(list);
    await saveLists(lists);
  }

  Future<void> updateList(ShoppingList updatedList) async {
    final lists = await getLists();
    final index = lists.indexWhere((list) => list.id == updatedList.id);
    if (index != -1) {
      lists[index] = updatedList;
      await saveLists(lists);
    }
  }

  Future<void> deleteList(String id) async {
    final lists = await getLists();
    lists.removeWhere((list) => list.id == id);
    await saveLists(lists);
  }
}
