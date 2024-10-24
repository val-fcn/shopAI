import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_ai/env/env.dart';
import 'package:shop_ai/models/shopping_item.dart';

class OpenAIService {
  final String apiKey = Env.openAIKey;
  static final String baseUrl = Env.apiUrl;
  final List<Map<String, dynamic>> _previousIngredients = [];

  Future<List<ShoppingItem>> analyzeFile(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-4o-mini',
        'messages': [
          {
            'role': 'user',
            'content': [
              {
                'type': 'text',
                'text':
                    '''Analysez cette image de recette et retourne uniquement une liste d'ingrédients au format JSON, pour les ingrédients sans quantité mets juste 1.
                Format attendu: {
                  "ingredients": [
                    {"name": "farine", "quantity": 200, "unit": "g"},
                    {"name": "oeufs", "quantity": 3, "unit": "pièce"}
                  ]
                }'''
              },
              {
                'type': 'image_url',
                'image_url': {
                  'url': 'data:image/jpeg;base64,$base64Image',
                },
              },
            ],
          },
        ],
        'max_tokens': 500,
      }),
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      final data = jsonDecode(response.body);
      final content = data['choices'][0]['message']['content'];

      // Nettoyer le contenu JSON de la réponse
      final cleanContent =
          content.replaceAll('```json\n', '').replaceAll('\n```', '').trim();

      final jsonData = jsonDecode(cleanContent);

      // Extraire la liste d'ingrédients avec décodage UTF-8
      final ingredientsList = (jsonData['ingredients'] as List).map((item) {
        return ShoppingItem.fromJson({
          ...item,
          'name': utf8.decode(latin1.encode(item['name'] as String)),
          'unit': utf8.decode(latin1.encode(item['unit'] as String)),
        });
      }).toList();

      return ingredientsList;
    } else {
      throw Exception('Erreur lors de l\'analyse de l\'image');
    }
  }
}
