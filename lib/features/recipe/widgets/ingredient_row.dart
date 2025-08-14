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
          child: TextFormField(
              controller: nameController,
              readOnly: isReadOnly,
              decoration: InputDecoration(
                hintText: 'введите ингредиент',
                labelText: 'Ингредиент',
                border: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey), // рамка в обычном состоянии
                ),
                focusedBorder: isReadOnly
                    ? const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey), // цвет в режиме чтения
                      )
                    : const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green), //цвет в режиме редактирования
                      ),
              )),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: quantityController,
            readOnly: isReadOnly,
            decoration: InputDecoration(
              hintText: 'введите количество',
              labelText: 'Количество',
              border: const OutlineInputBorder(),
              enabledBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.grey), // рамка в обычном состоянии
              ),
              focusedBorder: isReadOnly
                  ? const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // цвет в режиме чтения
                    )
                  : const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.green), //цвет в режиме редактирования
                    ),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: unitController,
            readOnly: isReadOnly,
            decoration: InputDecoration(
              hintText: 'введите ед.изм.',
              labelText: 'Единица изменрения',
              border: const OutlineInputBorder(),
              enabledBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.grey), // рамка в обычном состоянии
              ),
              focusedBorder: isReadOnly
                  ? const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // цвет в режиме чтения
                    )
                  : const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.green), //цвет в режиме редактирования
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
