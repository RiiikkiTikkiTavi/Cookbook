import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String label;
  final int maxLines;
  final bool readOnly;
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.hint,
    this.label = '',
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
