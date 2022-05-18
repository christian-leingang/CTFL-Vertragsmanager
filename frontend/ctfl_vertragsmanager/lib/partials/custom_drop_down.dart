import 'package:ctfl_vertragsmanager/funktionen/hive_functions.dart';
import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String labelText;
  final dynamic initialValue;
  Function callback;

  CustomDropdown({Key? key, required this.labelText, this.initialValue, required this.callback})
      : super(key: key);
  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late List<Label> labels;
  List<String> intervall = Vertrag.getAllIntervalle();
  List<String> list = [];

  String? selectedItem;

  void getHiveLabels() async {
    labels = await getHiveAllLabels();
  }

  @override
  void initState() {
    super.initState();
    getHiveLabels();
    if (widget.labelText == "Label") {
      list = labels.map((label) => label.name).toList();
    } else if (widget.labelText == "Intervall") {
      list = intervall;
    }
    selectedItem = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.black45, width: 1)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          onTap: widget.callback(selectedItem),
          hint: Text(widget.labelText),
          value: selectedItem,
          isExpanded: true,
          items: list.map(buildMenuItem).toList(),
          onChanged: (value) => setState(() => selectedItem = value),
        ),
      ),
    );
  }
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item),
    );
