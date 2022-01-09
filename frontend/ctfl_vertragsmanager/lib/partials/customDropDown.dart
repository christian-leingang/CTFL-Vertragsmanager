import 'package:ctfl_vertragsmanager/models/labels.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String labelText;
  final initialValue;
  Function callback;

  CustomDropdown({required this.labelText, this.initialValue, required this.callback});
  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  List<String> labels = Labels.getLabelsString();
  List<String> intervall = Vertrag.getAllIntervalle();
  List<String> list = [];

  String? selectedItem;

  @override
  void initState() {
    super.initState();
    if (widget.labelText == "Label") {
      list = labels;
    } else if (widget.labelText == "Intervall") {
      list = intervall;
      //this.selectedItem = "kein Intervall";
    }
    this.selectedItem = null;
  }

  @override
  Widget build(BuildContext context) {
    print(list);

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
          onTap: widget.callback(this.selectedItem),
          hint: Text(widget.labelText),
          value: this.selectedItem == null ? null : this.selectedItem,
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
