import 'package:flutter/material.dart';

class IngredientRow extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController quantityController;
  final TextEditingController unitController;

  const IngredientRow(
      {super.key,
      required this.nameController,
      required this.quantityController,
      required this.unitController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'введите ингредиент',
                labelText: 'Ингредиент',
                border: OutlineInputBorder(),
              )),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: quantityController,
            decoration: const InputDecoration(
              hintText: 'введите количество',
              labelText: 'Количество',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
              controller: unitController,
              decoration: const InputDecoration(
                hintText: 'введите ед.изм.',
                labelText: 'Единица изменрения',
                border: OutlineInputBorder(),
              )),
        ),
      ],
    );
  }
}
