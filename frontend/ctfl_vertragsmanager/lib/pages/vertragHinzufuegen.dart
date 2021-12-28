import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:ctfl_vertragsmanager/models/labels.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:ctfl_vertragsmanager/models/vertragsdaten.dart';

import 'package:flutter/material.dart';

class VertragHinzufuegenPage extends StatelessWidget {
  List<Vertrag> vertraege = Vertragsdaten().vertraege;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Vertrag hinzufügen"),
          backgroundColor: ColorThemes.primaryColor,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.save_outlined,
                size: 30,
              ),
            ),
          ],
        ),
        body: StepperHinzufuegen());
  }
}

class StepperHinzufuegen extends StatefulWidget {
  @override
  State<StepperHinzufuegen> createState() => _StepperHinzufuegenState();
}

class _StepperHinzufuegenState extends State<StepperHinzufuegen> {
  int _index = 0;
  List<String> labels = Labels.getLabelsString();
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    //TODO: Steps farbig, wenn fertig;
    return Stepper(
      controlsBuilder: (BuildContext context, ControlsDetails details) {
        return Row(
          children: <Widget>[
            ElevatedButton(
              onPressed: details.onStepContinue,
              child: Text('Weiter'),
              style: ElevatedButton.styleFrom(
                primary: ColorThemes.primaryColor,
              ),
            ),
            TextButton(
              onPressed: details.onStepCancel,
              child: Text('Zurück'),
              style: TextButton.styleFrom(
                primary: ColorThemes.primaryColor,
              ),
            ),
          ],
        );
      },
      steps: [
        Step(
            title: Text("Allgemeines"),
            content: Column(
              children: [
                CustomInputField(labelText: "Name"),
                CustomInputField(labelText: "Beschreibung"),
                //CustomInputField(labelText: "Label"),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.black45, width: 1)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text("Label"),
                      value: this.selectedItem,
                      isExpanded: true,
                      items: labels.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(() => this.selectedItem = value),
                    ),
                  ),
                ),
              ],
            )),
        Step(
            title: Text("Vertragsinformationen"),
            content: Column(
              children: [
                CustomInputField(labelText: "Vertragspartner"),
                CustomInputField(labelText: "Vertragsbeginn"), //TODO: Date
                CustomInputField(labelText: "Vertragsende"), //TODO: Date
                CustomInputField(labelText: "Kündigungsfrist"), //TODO: Date
              ],
            )),
        Step(
            title: Text("Zahlungsinformationen"),
            content: Column(
              children: [
                CustomInputField(labelText: "Intervall"), //TODO: Dropdown
                CustomInputField(labelText: "Beitrag"), //TODO: Number
                CustomInputField(labelText: "Erstzahlung"), //TODO: Date
              ],
            )),
      ],
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
    );
  }
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      child: Text(item),
      value: item,
    );

class CustomInputField extends StatelessWidget {
  final String labelText;

  CustomInputField({required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: TextField(
          cursorColor: Colors.black87,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorThemes.primaryColor),
            ),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.black87),
          )),
    );
  }
}
