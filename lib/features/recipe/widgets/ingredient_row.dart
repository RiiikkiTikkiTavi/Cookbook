import 'package:cookbook/features/recipe/widgets/widgets.dart';
import 'package:flutter/material.dart';

class IngredientRow extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController quantityController;
  final TextEditingController unitController;
  final FocusNode nameFocus;
  final FocusNode quantityFocus;
  final FocusNode unitFocus;
  final bool isReadOnly;
  final Widget? trailing;

  const IngredientRow({
    super.key,
    required this.nameController,
    required this.quantityController,
    required this.unitController,
    required this.nameFocus,
    required this.quantityFocus,
    required this.unitFocus,
    this.isReadOnly = false,
    this.trailing,
  });

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
              focusNode: nameFocus,
              onSumnitted: (_) =>
                  FocusScope.of(context).requestFocus(quantityFocus),
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
            focusNode: quantityFocus,
            onSumnitted: (_) => FocusScope.of(context).requestFocus(unitFocus),
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
            focusNode: unitFocus,
            textInputAction: TextInputAction.done,
            onSumnitted: (_) => FocusScope.of(context).unfocus(),
            hint: 'ед.изм.',
            readOnly: isReadOnly,
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
