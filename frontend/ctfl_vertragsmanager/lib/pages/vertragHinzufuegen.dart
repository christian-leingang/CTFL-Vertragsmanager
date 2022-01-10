import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:ctfl_vertragsmanager/models/labels.dart';
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
  final List<TextEditingController> _controllers = List.generate(8, (i) => TextEditingController());

  int vertragsId = -1;

  @override
  Widget build(BuildContext context) {
    final dynamic arguments = ModalRoute.of(context)!.settings.arguments;
    vertragsId = arguments != null ? ModalRoute.of(context)!.settings.arguments as int : -1;
    if (vertragsId >= 0) {
      vertrag = vertraegedaten.getVertragById(vertragsId);
      //vertrag = vertraege[vertragsId];
    } else {
      vertrag = Vertrag(name: "");
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
                onPressed: () {
                  if (validateVertrag(vertrag)) {
                    //fillVertrag();

                    vertraegedaten.saveVertrag(vertrag!);
                  }
                  Navigator.popAndPushNamed(context, '/vertragsDetails', arguments: vertrag!.id);
                },
              ),
            ),
          ],
        ),
        body: vertrag != null
            ? StepperHinzufuegen(
                vertrag: vertrag,
                controllers: _controllers,
                setIntervall: setIntervall,
                setLabel: setLabel,
              )
            : StepperHinzufuegen(
                controllers: _controllers,
                setIntervall: setIntervall,
                setLabel: setLabel,
              ));
  }

  setName(String newName) {
    setState(() {
      vertrag!.name = newName;
    });
  }

  bool validateVertrag(Vertrag? vertrag) {
    return true;
  }

  fillVertrag() {
    setState(() {
      vertrag!.name = _controllers[0].text;
      vertrag!.beschreibung = _controllers[1].text;
      vertrag!.vertragspartner = _controllers[2].text;
      vertrag!.vertragsBeginn = vertrag!.setDate(_controllers[3].text);
      vertrag!.vertragsEnde = vertrag!.setDate(_controllers[4].text);
      vertrag!.kuendigungsfrist = vertrag!.setDate(_controllers[5].text);
      vertrag!.beitrag = double.parse(_controllers[6].text);
      vertrag!.erstzahlung = vertrag!.setDate(_controllers[7].text);
    });
  }

  setLabel(newValue) {
    print(newValue);
    if (newValue == null) return;
    vertrag!.label.name = newValue;
  }

  setIntervall(newValue) {
    if (newValue == null) return;
    vertrag!.intervall = newValue;
  }
}

class StepperHinzufuegen extends StatefulWidget {
  final Vertrag? vertrag;
  final List<TextEditingController> controllers;
  Function setLabel;
  Function setIntervall;
  StepperHinzufuegen(
      {this.vertrag,
      required this.controllers,
      required this.setIntervall,
      required this.setLabel});

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
                    inputController: widget.controllers[0],
                  ),
                  CustomInputField(
                    labelText: "Beschreibung",
                    initialValue: widget.vertrag != null ? widget.vertrag!.beschreibung : "",
                    inputController: widget.controllers[1],
                  ),
                  CustomDropdown(
                    labelText: "Label",
                    initialValue: widget.vertrag != null ? widget.vertrag!.getLabelName() : "",
                    callback: widget.setLabel,
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
                    inputController: widget.controllers[2],
                  ),
                  CustomDatePicker(
                    labelText: "Vertragsbeginn",
                    initialValue: widget.vertrag != null ? widget.vertrag!.getVertragsBeginn() : "",
                    inputController: widget.controllers[3],
                  ),
                  CustomDatePicker(
                    labelText: "Vertragsende",
                    initialValue: widget.vertrag != null ? widget.vertrag!.getVertragsEnde() : "",
                    inputController: widget.controllers[4],
                  ),
                  CustomDatePicker(
                    labelText: "Kündigungsfrist",
                    initialValue:
                        widget.vertrag != null ? widget.vertrag!.getKuendigungsfrist() : "",
                    inputController: widget.controllers[5],
                  ),
                ],
              )),
          Step(
              title: Text("Zahlungsinformationen"),
              content: Column(
                children: [
                  CustomDropdown(
                    labelText: "Intervall",
                    initialValue:
                        widget.vertrag != null ? widget.vertrag!.intervall : "kein Intervall",
                    callback: widget.setIntervall,
                  ),
                  CustomInputField(
                    labelText: "Beitrag",
                    keyboardType: TextInputType.number,
                    initialValue: widget.vertrag != null ? widget.vertrag!.getBeitragNumber() : "",
                    inputController: widget.controllers[6],
                  ),
                  CustomDatePicker(
                    labelText: "Erstzahlung",
                    initialValue: widget.vertrag != null ? widget.vertrag!.getErstzahlung() : "",
                    inputController: widget.controllers[7],
                  ),
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
