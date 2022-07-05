import 'package:ctfl_vertragsmanager/funktionen/db_functions.dart';
import 'package:ctfl_vertragsmanager/funktionen/hive_functions.dart';
import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math' as math;

class CustomSearchDropdown extends StatefulWidget {
  final dynamic onSaved;
  final dynamic callback;

  const CustomSearchDropdown({Key? key, this.onSaved, this.callback}) : super(key: key);

  @override
  State<CustomSearchDropdown> createState() => _CustomSearchDropdownState();
}

class _CustomSearchDropdownState extends State<CustomSearchDropdown> {
  bool loading = true;

  List<Label> labelsHive = [];

  List<Map<String, String>> _labels = [];

  void getHiveLabels() async {
    labelsHive = await getHiveAllLabels();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHiveLabels();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Text("Loading");
    _labels = labelsHive.map((label) => {'name': label.name}).toList();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: DropdownFormField<Map<String, String>>(
        // onEmptyActionPressed: () async {
        //   dynamic test = await createNewLabel(context, widget.callback, _labels);
        //   print(test);
        // },
        dropdownColor: SchedulerBinding.instance.window.platformBrightness == Brightness.dark
            ? Colors.black54
            : Colors.white,
        searchTextStyle: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.arrow_drop_down),
          labelText: "Label",
        ),
        displayItemFn: (dynamic item) => Text(
          (item ?? {})['name'] ?? '',
          style: const TextStyle(fontSize: 16),
        ),
        findFn: (dynamic str) async => _labels,
        filterFn: (dynamic item, str) => item['name'].toLowerCase().indexOf(str.toLowerCase()) >= 0,
        dropdownItemFn: (dynamic item, position, focused, dynamic lastSelectedItem, onTap) =>
            ListTile(
          title: Text(item['name']),
          tileColor: focused ? const Color.fromARGB(20, 0, 0, 0) : Colors.transparent,
          onTap: onTap,
        ),
        emptyText: "Kein Label gefunden!",
        emptyActionText: "",
        dropdownHeight: 155,
        onSaved: widget.onSaved,
        onChanged: widget.callback,
      ),
    );
  }

  Future<dynamic> createNewLabel(BuildContext context, callback, List<Map<String, String>> labels) {
    TextEditingController labelController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Label hinzufügen"),
            content: TextField(
              autofocus: true,
              controller: labelController,
            ),
            actions: [
              MaterialButton(
                elevation: 5,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Abbruch"),
              ),
              MaterialButton(
                onPressed: () async {
                  Label newLabel = Label(
                    name: labelController.text.toString(),
                    colorValue: (math.Random().nextDouble() * 0xFFFFFF).toInt(),
                  );
                  labels.add({'name': newLabel.name});
                  await addLabel(newLabel);
                  await callback(newLabel);
                  // _labels.add({"name": labelController.text.toString()});

                  return Navigator.of(context).pop(labelController.text.toString());
                },
                elevation: 5,
                child: const Text('OK'),
              ),
            ],
          );
        });
  }
}
