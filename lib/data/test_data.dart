// lib/utils/test_data.dart
import 'package:shop_ai/models/shopping_item.dart';
import 'package:shop_ai/services/storage_service.dart';

class TestData {
  static List<ShoppingList> getSampleLists() {
    return [
      ShoppingList(
        id: '1',
        title: 'Recette Carbonara',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        items: [
          ShoppingItem(
            id: '1-1',
            name: 'Spaghetti',
            quantity: '500g',
            isChecked: true,
          ),
          ShoppingItem(
            id: '1-2',
            name: 'Lardons',
            quantity: '200g',
            isChecked: false,
          ),
          ShoppingItem(
            id: '1-3',
            name: 'Parmesan',
            quantity: '100g',
            isChecked: false,
          ),
          ShoppingItem(
            id: '1-4',
            name: 'Œufs',
            quantity: '4 unités',
            isChecked: true,
          ),
          ShoppingItem(
            id: '1-5',
            name: 'Poivre noir',
            quantity: '1 sachet',
            isChecked: false,
          ),
        ],
      ),
      ShoppingList(
        id: '2',
        title: 'Gâteau au chocolat',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        items: [
          ShoppingItem(
            id: '2-1',
            name: 'Chocolat noir',
            quantity: '200g',
            isChecked: false,
          ),
          ShoppingItem(
            id: '2-2',
            name: 'Beurre',
            quantity: '150g',
            isChecked: true,
          ),
          ShoppingItem(
            id: '2-3',
            name: 'Sucre',
            quantity: '150g',
            isChecked: true,
          ),
          ShoppingItem(
            id: '2-4',
            name: 'Farine',
            quantity: '80g',
            isChecked: false,
          ),
          ShoppingItem(
            id: '2-5',
            name: 'Œufs',
            quantity: '3 unités',
            isChecked: false,
          ),
          ShoppingItem(
            id: '2-6',
            name: 'Levure chimique',
            quantity: '1 sachet',
            isChecked: false,
          ),
        ],
      ),
      ShoppingList(
        id: '3',
        title: 'Salade César',
        createdAt: DateTime.now(),
        items: [
          ShoppingItem(
            id: '3-1',
            name: 'Salade romaine',
            quantity: '1 pièce',
            isChecked: false,
          ),
          ShoppingItem(
            id: '3-2',
            name: 'Blanc de poulet',
            quantity: '2 pièces',
            isChecked: false,
          ),
          ShoppingItem(
            id: '3-3',
            name: 'Parmesan',
            quantity: '50g',
            isChecked: false,
          ),
          ShoppingItem(
            id: '3-4',
            name: 'Croûtons',
            quantity: '100g',
            isChecked: true,
          ),
          ShoppingItem(
            id: '3-5',
            name: 'Sauce césar',
            quantity: '1 bouteille',
            isChecked: false,
          ),
        ],
      ),
    ];
  }

  // Fonction utilitaire pour charger les données de test dans le StorageService
  static Future<void> loadTestData(StorageService storageService) async {
    final lists = getSampleLists();
    await storageService.saveLists(lists);
  }
}
