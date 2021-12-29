import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:ctfl_vertragsmanager/models/vertragsdaten.dart';
import 'package:ctfl_vertragsmanager/pages/vertragsdetails.dart';
import 'package:ctfl_vertragsmanager/partials/customDatePicker.dart';
import 'package:ctfl_vertragsmanager/partials/customDropDown.dart';
import 'package:ctfl_vertragsmanager/partials/customInputField.dart';

import 'package:flutter/material.dart';

class VertragHinzufuegenPage extends StatelessWidget {
  List<Vertrag> vertraege = Vertragsdaten().vertraege;

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenEditArguments;
    //int vertragsId = args.vertragsId;

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

  @override
  Widget build(BuildContext context) {
    //TODO: Steps farbig, wenn fertig;
    return Theme(
      data: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(primary: ColorThemes.primaryColor)),
      child: Stepper(
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
                  CustomDropdown(
                    labelText: "Label",
                  ),
                ],
              )),
          Step(
              title: Text("Vertragsinformationen"),
              content: Column(
                children: [
                  CustomInputField(labelText: "Vertragspartner"),
                  CustomDatePicker(labelText: "Vertragsbeginn"),
                  CustomDatePicker(labelText: "Vertragsende"),
                  CustomDatePicker(labelText: "Kündigungsfrist"),
                ],
              )),
          Step(
              title: Text("Zahlungsinformationen"),
              content: Column(
                children: [
                  CustomDropdown(
                    labelText: "Intervall",
                  ),
                  CustomInputField(labelText: "Beitrag", keyboardType: TextInputType.number),
                  CustomDatePicker(labelText: "Erstzahlung"),
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
          if (_index <= 1) {
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
      ),
    );
  }
}
