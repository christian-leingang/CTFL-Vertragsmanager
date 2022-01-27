import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  final String labelText;
  String? initialValue;
  final onSaved;
  String? selectedDate;

  CustomDatePicker({
    required this.labelText,
    this.initialValue,
    required this.onSaved,
  });

  final format = DateFormat("dd.MM.yyyy");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: DateTimeField(
        onSaved: onSaved,
        format: format,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
        ),
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              locale: Locale('de', 'DE'),
              firstDate: DateTime(2020),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: ColorThemes.primaryColor,
                    ),
                  ),
                  child: child!,
                );
              });
        },
      ),
    );
  }
}
