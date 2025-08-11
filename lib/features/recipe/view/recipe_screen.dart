import 'dart:io';
import 'package:cookbook/features/bloc/recipe_bloc.dart';
import 'package:cookbook/features/recipe/widgets/widgets.dart';
import 'package:cookbook/repositories/recipe_repository/recipe_repository.dart';
import 'package:cookbook/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  final _recipeBloc = RecipeBloc(GetIt.I<AbstractRecipeSource>());
  File? imageFile;
  final ImagePicker picker = ImagePicker();

  // контроллер для текстового поля - название
  final _titleController = TextEditingController();
  // контроллер для текстового поля - описание
  final _descrController = TextEditingController();
  // список контроллеров для ингредиентов
  final List<IngredientControllers> _ingrControllers = [];

// при инициализации страницы сразу добавляется первый контроллер
// для первой строки ингредиентов
  @override
  void initState() {
    addIngrController();
    super.initState();
  }

// метод добавления новых контроллеров ингредиентов
  void addIngrController() {
    setState(() {
      _ingrControllers.add(
        IngredientControllers(
          nameController: TextEditingController(),
          quantityController: TextEditingController(),
          unitController: TextEditingController(),
        ),
      );
    });
  }

// освобождение памяти, удаление ненужных контроллеров
  void removeIngrController(int index) {
    setState(() {
      _ingrControllers[index].nameController.dispose();
      _ingrControllers[index].quantityController.dispose();
      _ingrControllers[index].unitController.dispose();
      _ingrControllers.removeAt(index);
    });
  }

  Future<void> selectImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  void saveRecipe() {
    final id = DateTime.now().millisecondsSinceEpoch;
    final title = _titleController.text.trim();
    final description = _descrController.text.trim();

    final ingredients = <Ingredient>[];
    for (final ingr in _ingrControllers) {
      final name = ingr.nameController.text.trim();
      final quantity = double.tryParse(ingr.quantityController.text) ?? 0;
      final unit = ingr.unitController.text.trim();

      ingredients.add(Ingredient(name: name, quantity: quantity, unit: unit));
    }

    Recipe recipe = Recipe(
        id: id, title: title, descr: description, ingredient: ingredients);

    _recipeBloc.add(AddRecipe(recipe: recipe));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text(recipeName ?? '...'),
        title: const Text("Создание рецепта"),
      ),
      body: BlocBuilder<RecipeBloc, RecipeState>(
        bloc: _recipeBloc,
        builder: (context, state) {
          return ListView(
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
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
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
                    iconSize: 20,
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      // метод добавления нового ингредиента
                      addIngrController();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  //..._ingrControllers перечисление всех ингредиентов
                  // asMap() преобразованных в мапу
                  // entries в виде пары ключ (номер п/п) - значение
                  // map((entry) для каждого значения выполняем следующее
                  ..._ingrControllers.asMap().entries.map((entry) {
                    final index = entry.key;
                    final contollers = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      // виджет строки ингредиента
                      child: IngredientRow(
                        nameController: contollers.nameController,
                        quantityController: contollers.quantityController,
                        unitController: contollers.unitController,
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Описание',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descrController,
                maxLines: 8,
                decoration: const InputDecoration(
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
          );
        },
      ),
    );
  }
}

class IngredientControllers {
  final TextEditingController nameController;
  final TextEditingController quantityController;
  final TextEditingController unitController;

  IngredientControllers({
    required this.nameController,
    required this.quantityController,
    required this.unitController,
  });
}
