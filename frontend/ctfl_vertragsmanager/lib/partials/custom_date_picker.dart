import 'package:ctfl_vertragsmanager/constants/colors.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

class CustomDatePicker extends StatelessWidget {
  final String labelText;
  String? initialValue;
  final dynamic onSaved;
  String? selectedDate;

  CustomDatePicker({
    Key? key,
    required this.labelText,
    this.initialValue,
    required this.onSaved,
  }) : super(key: key);

  final format = DateFormat("dd.MM.yyyy");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: DateTimeField(
        onSaved: onSaved,
        format: format,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              locale: const Locale('de', 'DE'),
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