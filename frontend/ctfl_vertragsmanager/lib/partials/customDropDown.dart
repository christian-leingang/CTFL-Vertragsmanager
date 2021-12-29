import 'package:ctfl_vertragsmanager/models/labels.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String labelText;
  final initialValue;

  CustomDropdown({required this.labelText, this.initialValue});
  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  List<String> labels = Labels.getLabelsString();
  List<String> intervall = ["monatlich", "vierteljährlich", "halbjährlich", "jährlich"];
  List<String> list = [];

  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    if (widget.labelText == "Label") {
      list = labels;
    } else if (widget.labelText == "Intervall") {
      list = intervall;
    }
    print(widget.initialValue);
    if (widget.initialValue != "") {
      this.selectedItem = widget.initialValue;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.black45, width: 1)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(widget.labelText),
          value: this.selectedItem,
          isExpanded: true,
          items: list.map(buildMenuItem).toList(),
          onChanged: (value) => setState(() => this.selectedItem = value),
        ),
      ),
    );
  }
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      child: Text(item),
      value: item,
    );
