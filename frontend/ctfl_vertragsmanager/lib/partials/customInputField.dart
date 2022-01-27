import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputField extends StatelessWidget {
  final String labelText;
  TextInputType? keyboardType;
  final inputController;
  String? initialValue;
  final onSaved;

  CustomInputField(
      {required this.labelText,
      this.keyboardType,
      this.initialValue,
      this.inputController,
      this.onSaved});

  @override
  Widget build(BuildContext context) {
    // if (initialValue != null) inputController.text = initialValue!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: TextFormField(
        inputFormatters: keyboardType == null
            ? [FilteringTextInputFormatter.deny("")]
            : [FilteringTextInputFormatter.allow(RegExp(r"\d{1,3}(?:[.,]\d{3})*(?:[.,]\d{2})?"))],
        keyboardType: keyboardType ?? TextInputType.text,
        // controller: inputController,
        cursorColor: Colors.black87,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
        ),
        onSaved: onSaved,
        initialValue: initialValue,
      ),
    );
  }
}
