import 'dart:io';
import 'package:cookbook/features/recipe/widgets/widgets.dart';
import 'package:cookbook/repositories/recipe_repository/recipe_repository.dart';
import 'package:cookbook/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  Recipe? recipe;
  File? imageFile;
  final ImagePicker picker = ImagePicker();

  List<Ingredient> ingredients = [
    const Ingredient(name: '', quantity: 0, unit: '')
  ];

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
      ingredients.add(const Ingredient(name: '', quantity: 0, unit: ''));
    });
  }

  void updateIngredientName(int index, String name) {
    setState(() {
      ingredients[index] = ingredients[index].copyWith(name: name);
    });
  }

  void updateIngredientQuant(int index, int quantity) {
    setState(() {
      ingredients[index] = ingredients[index].copyWith(quantity: quantity);
    });
  }

  void updateIngredientUnit(int index, String unit) {
    setState(() {
      ingredients[index] = ingredients[index].copyWith(unit: unit);
    });
  }

  void saveRecipe() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //title: Text(recipeName ?? '...'),
          title: const Text("Создание рецепта"),
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
            const Text(
              'Название',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Введите название рецепта...',
                border: OutlineInputBorder(),
              ),
            ),
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
              ...ingredients.asMap().entries.map((entry) {
                final index = entry.key;
                final ingredient = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: IngredientRow(
                    name: ingredient.name,
                    quantity: ingredient.quantity,
                    unit: ingredient.unit,
                    onNameChanged: (val) => updateIngredientName(index, val),
                    onQuantChanged: (val) => updateIngredientQuant(index, val),
                    onUnitChanged: (val) => updateIngredientUnit(index, val),
                  ),
                );
              }),
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
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: saveRecipe,
              child: const Text('Сохранить'),
            ),
          ],
        ));
  }
}
