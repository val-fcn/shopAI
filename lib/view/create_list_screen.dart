import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_ai/models/shopping_item.dart';
import '../services/ai_service.dart';
import '../services/storage_service.dart';

class CreateListScreen extends StatefulWidget {
  final StorageService storageService;
  final AiService aiService;

  const CreateListScreen({
    super.key,
    required this.storageService,
    required this.aiService,
  });

  @override
  State<CreateListScreen> createState() => _CreateListScreenState();
}

class _CreateListScreenState extends State<CreateListScreen> {
  File? _image;
  final _titleController = TextEditingController();
  List<ShoppingItem> _detectedItems = [];
  bool _isAnalyzing = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _takePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      setState(() {
        _image = File(photo.path);
        _isAnalyzing = true;
      });

      try {
        final items = await widget.aiService.analyzeImage(_image!);
        setState(() {
          _detectedItems = items;
          _isAnalyzing = false;
        });
      } catch (e) {
        setState(() {
          _isAnalyzing = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Erreur lors de l\'analyse de l\'image')),
          );
        }
      }
    }
  }

  Future<void> _saveList() async {
    if (!_formKey.currentState!.validate()) return;

    final newList = ShoppingList(
      title: _titleController.text,
      items: _detectedItems,
    );

    await widget.storageService.addList(newList);
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouvelle liste'),
        actions: [
          if (_detectedItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _saveList,
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Nom de la liste',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un nom pour la liste';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            if (_image == null)
              Center(
                child: ElevatedButton.icon(
                  onPressed: _takePicture,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Prendre une photo'),
                ),
              )
            else
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      _image!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _takePicture,
                    child: const Text('Reprendre la photo'),
                  ),
                ],
              ),
            const SizedBox(height: 16),
            if (_isAnalyzing)
              const Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 8),
                    Text('Analyse de l\'image en cours...'),
                  ],
                ),
              )
            else if (_detectedItems.isNotEmpty) ...[
              const Text(
                'Ingrédients détectés :',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _detectedItems.length,
                itemBuilder: (context, index) {
                  final item = _detectedItems[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text(item.quantity),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _detectedItems.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: _image == null
          ? null
          : FloatingActionButton(
              onPressed: () {
                // TODO: Ajouter la logique pour modifier manuellement la liste
              },
              child: const Icon(Icons.edit),
            ),
    );
  }
}
