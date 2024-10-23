import 'dart:io';
import 'package:shop_ai/models/shopping_item.dart';

class AiService {
  // Simuler l'analyse d'une image et retourner une liste d'items
  // À remplacer par votre véritable appel API à l'IA
  Future<List<ShoppingItem>> analyzeImage(File image) async {
    // Simuler un délai d'analyse
    await Future.delayed(const Duration(seconds: 2));

    // Retourner une liste factice pour le développement
    return [
      ShoppingItem(
        name: 'Ingrédient détecté 1',
        quantity: '100g',
      ),
      ShoppingItem(
        name: 'Ingrédient détecté 2',
        quantity: '2 unités',
      ),
    ];
  }
}
