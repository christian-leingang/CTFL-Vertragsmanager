import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:ctfl_vertragsmanager/models/vertragsdaten.dart';
import 'package:ctfl_vertragsmanager/partials/customDatePicker.dart';
import 'package:ctfl_vertragsmanager/partials/customDropDown.dart';
import 'package:ctfl_vertragsmanager/partials/customInputField.dart';

import 'package:flutter/material.dart';

class VertragHinzufuegenPage extends StatefulWidget {
  @override
  State<VertragHinzufuegenPage> createState() => _VertragHinzufuegenPageState();
}

class _VertragHinzufuegenPageState extends State<VertragHinzufuegenPage> {
  Vertragsdaten vertraegedaten = Vertragsdaten();
  late Vertrag? vertrag;

  int vertragsId = -1;

  @override
  Widget build(BuildContext context) {
    final dynamic arguments = ModalRoute.of(context)!.settings.arguments;
    vertragsId = arguments != null ? ModalRoute.of(context)!.settings.arguments as int : -1;
    if (vertragsId >= 0) {
      vertrag = vertraegedaten.getVertragById(vertragsId);
      //vertrag = vertraege[vertragsId];
    } else {
      vertrag = null;
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Vertrag hinzufügen"),
          backgroundColor: ColorThemes.primaryColor,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: new Icon(
                  Icons.save_outlined,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        body: vertrag != null ? StepperHinzufuegen(vertrag: vertrag) : StepperHinzufuegen());
  }
}

class StepperHinzufuegen extends StatefulWidget {
  final Vertrag? vertrag;
  StepperHinzufuegen({this.vertrag});

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
                  CustomInputField(
                    labelText: "Name",
                    initialValue: widget.vertrag != null ? widget.vertrag!.name : "",
                  ),
                  CustomInputField(
                    labelText: "Beschreibung",
                    initialValue: widget.vertrag != null ? widget.vertrag!.description : "",
                  ),
                  CustomDropdown(
                    labelText: "Label",
                    initialValue: widget.vertrag != null ? widget.vertrag!.getLabelName() : "",
                  ),
                ],
              )),
          Step(
              title: Text("Vertragsinformationen"),
              content: Column(
                children: [
                  CustomInputField(
                    labelText: "Vertragspartner",
                    initialValue: widget.vertrag != null ? widget.vertrag!.vertragspartner : "",
                  ),
                  CustomDatePicker(
                      labelText: "Vertragsbeginn",
                      initialValue:
                          widget.vertrag != null ? widget.vertrag!.getVertragsBeginn() : ""),
                  CustomDatePicker(
                      labelText: "Vertragsende",
                      initialValue:
                          widget.vertrag != null ? widget.vertrag!.getVertragsEnde() : ""),
                  CustomDatePicker(
                      labelText: "Kündigungsfrist",
                      initialValue:
                          widget.vertrag != null ? widget.vertrag!.getKuendigungsfrist() : ""),
                ],
              )),
          Step(
              title: Text("Zahlungsinformationen"),
              content: Column(
                children: [
                  CustomDropdown(
                    labelText: "Intervall",
                    initialValue: widget.vertrag != null ? widget.vertrag!.getIntervall() : "",
                  ),
                  CustomInputField(
                    labelText: "Beitrag",
                    keyboardType: TextInputType.number,
                    initialValue: widget.vertrag != null ? widget.vertrag!.getBeitragNumber() : "",
                  ),
                  CustomDatePicker(
                      labelText: "Erstzahlung",
                      initialValue: widget.vertrag != null ? widget.vertrag!.getErstzahlung() : ""),
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
