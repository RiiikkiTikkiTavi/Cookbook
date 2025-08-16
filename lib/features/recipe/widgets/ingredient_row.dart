import 'package:cookbook/features/recipe/widgets/widgets.dart';
import 'package:flutter/material.dart';

class IngredientRow extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController quantityController;
  final TextEditingController unitController;
  final bool isReadOnly;

  const IngredientRow(
      {super.key,
      required this.nameController,
      required this.quantityController,
      required this.unitController,
      this.isReadOnly = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextFieldWidget(
              controller: nameController,
              hint: 'введите ингредиент',
              label: 'Ингредиент',
              readOnly: isReadOnly),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFieldWidget(
            controller: quantityController,
            hint: 'кол-во',
            label: 'Количество',
            readOnly: isReadOnly,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFieldWidget(
            controller: unitController,
            hint: 'ед.изм.',
            label: 'Ед. измерения',
            readOnly: isReadOnly,
          ),
        ),
      ],
    );
  }
}
