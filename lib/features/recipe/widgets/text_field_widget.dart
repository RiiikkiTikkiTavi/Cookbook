import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final String label;
  final int maxLines;
  final bool readOnly;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onSumnitted;
  const TextFieldWidget({
    super.key,
    required this.controller,
    this.validator,
    required this.hint,
    this.label = '',
    this.maxLines = 1,
    this.readOnly = false,
    this.keyboardType,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.onSumnitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      focusNode: focusNode,
      maxLines: maxLines,
      readOnly: readOnly,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onSumnitted,
      decoration: InputDecoration(
        hintText: hint,
        // labelText: label,
        // labelStyle: const TextStyle(color: Colors.black54), // обычное состояние
        // floatingLabelStyle: TextStyle(
        //   color: readOnly ? Colors.black26 : Colors.green, // цвет при фокусе
        // ),

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
