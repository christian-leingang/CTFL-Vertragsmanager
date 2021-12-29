import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  final String labelText;
  String? initialValue;

  CustomDatePicker({required this.labelText, this.initialValue});
  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.initialValue != null) inputController.text = widget.initialValue!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: TextFormField(
          controller: inputController,
          onTap: () => pickDate(context),
          readOnly: true,
          cursorColor: Colors.black87,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorThemes.primaryColor),
            ),
            labelStyle: TextStyle(color: Colors.black87),
            labelText: widget.labelText,
          )),
    );
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        locale: Locale('de', 'DE'),
        firstDate: DateTime(DateTime.now().year - 50),
        initialDate: initialDate,
        lastDate: DateTime(DateTime.now().year + 50),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: ColorThemes.primaryColor,
              ),
            ),
            child: child!,
          );
        }).then((selectedDate) {
      if (selectedDate != null) {
        inputController.text = "${selectedDate.day}.${selectedDate.month}.${selectedDate.year}";
      }
    });
  }
}
