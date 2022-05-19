import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputField extends StatelessWidget {
  final String labelText;
  TextInputType? keyboardType;
  final String? inputController;
  String? initialValue;
  final dynamic onSaved;

  CustomInputField(
      {Key? key,
      required this.labelText,
      this.keyboardType,
      this.initialValue,
      this.inputController,
      this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (initialValue != null) inputController.text = initialValue!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: TextFormField(
        inputFormatters: keyboardType == null
            ? [FilteringTextInputFormatter.deny("")]
            : [FilteringTextInputFormatter.allow(RegExp(r"^\d+[.,]?\d{0,2}"))],
        keyboardType: keyboardType ?? TextInputType.text,
        // controller: inputController,
        cursorColor: Colors.black87,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
        onSaved: onSaved,
        initialValue: initialValue,
      ),
    );
  }
}
