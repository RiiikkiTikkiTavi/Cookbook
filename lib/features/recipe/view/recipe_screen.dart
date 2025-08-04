import 'dart:io';
import 'package:cookbook/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  String? recipeName;
  File? imageFile;
  final ImagePicker picker = ImagePicker();

  List<IngredientRow> ingredientRows = [];

  Future<void> selectImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  void addIngredient() {
    setState(() {
      ingredientRows.add(const IngredientRow());
    });
  }

// оюеспечивает передачу параметров с recipe_list_screen
/*
  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is String, 'You must provide String args');
    recipeName = args as String;
    setState(() {});
    super.didChangeDependencies();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //title: Text(recipeName ?? '...'),
          title: const Text("Recipe"),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            GestureDetector(
                onTap: selectImage,
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: imageFile != null
                      ? Image.file(
                          imageFile!,
                          fit: BoxFit.cover,
                        )
                      : const Image(
                          image: AssetImage(AppImages.placeholder),
                          fit: BoxFit.cover,
                        ),
                )),
            const SizedBox(height: 24),
            Row(
              children: [
                const Text(
                  'Ингредиенты',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  iconSize: 18,
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    addIngredient();
                    // ...
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(children: [
              ...ingredientRows,
            ]),
            const SizedBox(height: 24),
            const Text(
              'Описание',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const TextField(
              maxLines: 8,
              decoration: InputDecoration(
                hintText: 'Введите описание рецепта...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ));
  }
}

class IngredientRow extends StatelessWidget {
  const IngredientRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextFormField(
              decoration: const InputDecoration(
            hintText: 'введите ингредиент',
            labelText: 'Ингредиент',
          )),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(
              hintText: 'введите количество',
              labelText: 'Количество',
            ),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
