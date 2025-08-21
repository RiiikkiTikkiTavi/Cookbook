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
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Обязательно";
                }
                if (!RegExp(r"^[a-zA-Zа-яА-Я\s]+$").hasMatch(value)) {
                  return "Некорректно";
                }
                return null;
              },
              hint: 'ингредиент',
              readOnly: isReadOnly),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFieldWidget(
            controller: quantityController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Обязательно";
              }
              if (!RegExp(r"^\d+([.,]\d+)?$").hasMatch(value)) {
                return "Некорректно";
              }
              return null;
            },
            hint: 'кол-во',
            readOnly: isReadOnly,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFieldWidget(
            controller: unitController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Обязательно";
              }
              if (!RegExp(r"^[a-zA-Zа-яА-Я]+$").hasMatch(value)) {
                return "Некорректно";
              }
              return null;
            },
            hint: 'ед.изм.',
            readOnly: isReadOnly,
          ),
        ),
      ],
    );
  }
}
