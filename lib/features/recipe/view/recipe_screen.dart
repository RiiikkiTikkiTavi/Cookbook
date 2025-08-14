// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import 'package:cookbook/features/bloc/recipe_bloc.dart';
import 'package:cookbook/features/recipe/widgets/widgets.dart';
import 'package:cookbook/repositories/recipe_repository/recipe_repository.dart';
import 'package:cookbook/resources/resources.dart';

class RecipeScreen extends StatefulWidget {
  final String? recipeId;
  final bool isReadOnly;
  const RecipeScreen({super.key, this.recipeId, required this.isReadOnly});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  final _recipeBloc = RecipeBloc(GetIt.I<AbstractRecipeSource>());
  File? imageFile;
  final ImagePicker picker = ImagePicker();
  late bool isReadOnly;

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
    super.initState();
    isReadOnly = widget.isReadOnly;
    if (widget.recipeId != null) {
      _recipeBloc.add(OpenRecipe(id: widget.recipeId!));
    } else {
      addIngrController();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descrController.dispose();
    for (var ingr in _ingrControllers) {
      ingr.dispose();
    }
    super.dispose();
  }

// метод добавления новых контроллеров ингредиентов
  void addIngrController({Ingredient? ingredient}) {
    setState(() {
      _ingrControllers.add(
        IngredientControllers(
          nameController: TextEditingController(text: ingredient?.name ?? ''),
          quantityController: TextEditingController(
              text: ingredient?.quantity != null && ingredient!.quantity != 0
                  ? ingredient.quantity.toString()
                  : ''),
          unitController: TextEditingController(text: ingredient?.unit ?? ''),
        ),
      );
    });
  }

// освобождение памяти, удаление ненужных контроллеров
  void removeIngrController(int index) {
    setState(() {
      _ingrControllers[index].dispose();
      _ingrControllers.removeAt(index);
    });
  }

  Future<void> _selectImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  void saveRecipe() {
    final title = _titleController.text.trim();
    final description = _descrController.text.trim();

    final ingredients = <Ingredient>[];
    for (final ingr in _ingrControllers) {
      final name = ingr.nameController.text.trim();
      final quantity = double.tryParse(ingr.quantityController.text) ?? 0;
      final unit = ingr.unitController.text.trim();

      ingredients.add(Ingredient(name: name, quantity: quantity, unit: unit));
    }

    if (widget.recipeId == null) {
      Recipe recipe = Recipe(
          id: '', title: title, descr: description, ingredient: ingredients);

      _recipeBloc.add(AddRecipe(recipe: recipe));
    } else {
      Recipe recipe = Recipe(
          id: widget.recipeId!,
          title: title,
          descr: description,
          ingredient: ingredients);

      _recipeBloc.add(UpdateRecipe(recipe: recipe));
    }
  }

  void deleteRecipe() {
    _recipeBloc.add(DeleteRecipe(id: widget.recipeId!));
  }

  Future<void> confirmDelete() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить рецепт?'),
        content: const Text('Вы уверены, что хотите удалить этот рецепт?'),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(context).pop(false), // закрытие окошка
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context)
                .pop(true), // закрытие диалога с подтверждением
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
    if (shouldDelete ?? false) {
      deleteRecipe();
    }
  }

  void switchEditMode() {
    setState(() {
      isReadOnly = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipeId == null
            ? 'Создание рецепта'
            : isReadOnly
                ? 'Просмотр рецепта'
                : 'Редактирование рецепта'),
        actions: [
          if (widget.recipeId != null)
            PopupMenuButton<RecipeMenuOptions>(
                onSelected: (option) {
                  switch (option) {
                    case RecipeMenuOptions.edit:
                      switchEditMode();
                      break;
                    case RecipeMenuOptions.delete:
                      confirmDelete();
                      break;
                  }
                },
                itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: RecipeMenuOptions.edit,
                        child: Text('Изменить'),
                      ),
                      const PopupMenuItem(
                          value: RecipeMenuOptions.delete,
                          child: Text('Удалить')),
                    ])
        ],
      ),
      body: BlocListener<RecipeBloc, RecipeState>(
        bloc: _recipeBloc,
        listener: (context, state) {
          // если загружен существующий рецепт
          if (state is RecipeLoaded && widget.recipeId != null) {
            _fillFields(state.recipe);
          } else if (state is RecipeActionSuccess) {
            // если рецепт сохранен
            // возвращаемся назад на главный экран
            Navigator.of(context).pop();
          } else if (state is RecipeLoadingFailure) {
            // если ошибка
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Ошибка при сохранении: ${state.exception}')),
            );
          }
        },
        child: BlocBuilder<RecipeBloc, RecipeState>(
          bloc: _recipeBloc,
          builder: (context, state) {
            if (state is RecipeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              padding: const EdgeInsets.all(8),
              children: [
                ImagePickerWidget(
                  onTap: _selectImage,
                  imageFile: imageFile,
                ),
                const SizedBox(height: 24),
                const SectionTitle(
                  text: 'Название',
                ),
                const SizedBox(height: 16),
                TextFieldWidget(
                    controller: _titleController,
                    hint: 'Введите название рецепта...',
                    readOnly: isReadOnly),
                Row(
                  children: [
                    const SectionTitle(text: 'Ингредиенты'),
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
                          isReadOnly: isReadOnly,
                        ),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 24),
                const SectionTitle(text: 'Описание'),
                const SizedBox(height: 16),
                TextFieldWidget(
                    controller: _descrController,
                    hint: 'Введите описание рецепта...',
                    maxLines: 8,
                    readOnly: isReadOnly),
                const SizedBox(height: 16),
                if (!isReadOnly)
                  ElevatedButton(
                    onPressed: saveRecipe,
                    child: const Text('Сохранить'),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _fillFields(Recipe recipe) {
    _titleController.text = recipe.title;
    _descrController.text = recipe.descr;
    //_ingrControllers.clear();
    for (var ingr in recipe.ingredient) {
      addIngrController(ingredient: ingr);
    }
  }
}

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final bool readOnly;
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      readOnly: readOnly,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: readOnly
              ? const BorderSide(color: Colors.black26)
              : const BorderSide(
                  color: Colors.black54), // рамка в обычном состоянии
        ),
        focusedBorder: readOnly
            ? const OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.black26), // цвет в режиме чтения
              )
            : const OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.green), //цвет в режиме редактирования
              ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({
    super.key,
    required this.onTap,
    this.imageFile,
  });
  final VoidCallback onTap;
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, //_selectImage,
      child: SizedBox(
        width: 300,
        height: 300,
        child: imageFile != null
            ? Image.file(imageFile!, fit: BoxFit.cover)
            : const Image(
                image: AssetImage(AppImages.placeholder),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}

enum RecipeMenuOptions {
  edit,
  delete,
}

// обертка для контроллеров одного ингредиента
class IngredientControllers {
  final TextEditingController nameController;
  final TextEditingController quantityController;
  final TextEditingController unitController;

  IngredientControllers({
    required this.nameController,
    required this.quantityController,
    required this.unitController,
  });

  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    unitController.dispose();
  }
}
