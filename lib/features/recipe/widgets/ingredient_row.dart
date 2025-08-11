import 'package:flutter/material.dart';

class IngredientRow extends StatelessWidget {
  final String name;
  final int quantity;
  final String unit;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<int> onQuantChanged;
  final ValueChanged<String> onUnitChanged;

  const IngredientRow({
    super.key,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.onNameChanged,
    required this.onQuantChanged,
    required this.onUnitChanged,
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
            border: OutlineInputBorder(),
          )),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
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
