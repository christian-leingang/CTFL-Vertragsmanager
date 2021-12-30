import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputField extends StatelessWidget {
  final String labelText;
  TextInputType? keyboardType;
  final inputController;
  String? initialValue;

  CustomInputField(
      {required this.labelText, this.keyboardType, this.initialValue, this.inputController});

  @override
  Widget build(BuildContext context) {
    if (initialValue != null) inputController.text = initialValue!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: TextFormField(
        inputFormatters: keyboardType == null
            ? [FilteringTextInputFormatter.deny("")]
            : [FilteringTextInputFormatter.allow(RegExp(r"\d{1,3}(?:[.,]\d{3})*(?:[.,]\d{2})?"))],
        keyboardType: keyboardType ?? TextInputType.text,
        controller: inputController,
        cursorColor: Colors.black87,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
