import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:ctfl_vertragsmanager/funktionen/dbFunctions.dart';
import 'package:ctfl_vertragsmanager/funktionen/hiveFunctions.dart';
import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:ctfl_vertragsmanager/models/vertragsdaten.dart';
import 'package:ctfl_vertragsmanager/partials/customDatePicker.dart';
import 'package:ctfl_vertragsmanager/partials/customDropDown.dart';
import 'package:ctfl_vertragsmanager/partials/customInputField.dart';
import 'package:ctfl_vertragsmanager/partials/customSearchDropDown.dart';
import 'package:ctfl_vertragsmanager/provider/vertrag_provider.dart';
import 'package:dropdown_plus/dropdown_plus.dart';

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class VertragHinzufuegenPage extends StatefulWidget {
  @override
  State<VertragHinzufuegenPage> createState() => _VertragHinzufuegenPageState();
}

class _VertragHinzufuegenPageState extends State<VertragHinzufuegenPage> {
  int _index = 0;
  final _formKey = GlobalKey<FormState>();

  //Vertragsdaten vertraegedaten = Vertragsdaten();
  late Vertrag? vertrag;
  //final List<TextEditingController> _controllers = List.generate(4, (i) => TextEditingController());

  String vertragsId = "Error invalid";

  @override
  Widget build(BuildContext context) {
    final dynamic arguments = ModalRoute.of(context)!.settings.arguments;
    vertragsId = arguments != null ? ModalRoute.of(context)!.settings.arguments as String : "-1";
    if (vertragsId != "-1") {
      //vertrag = vertraegedaten.getVertragById(vertragsId);
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
              onPressed: () async {
                _formKey.currentState!.save();

                if (validateVertrag(vertrag)) {
                  Vertrag newVertrag = context.read<Vertrag_Provider>().newVertrag;

                  vertragsId = await createVertrag(newVertrag);
                  if (vertragsId.startsWith("Error")) {
                    final snackBar = SnackBar(
                      content: const Text(
                          'Ein Fehler ist aufgetreten, probieren Sie es mit einer Internetverbindung erneut.'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    Navigator.popAndPushNamed(context, '/vertragsDetails', arguments: vertrag!.id);
                  }
                }
              },
            ),
          ),
        ],
      ),
      body: Theme(
        data: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(primary: ColorThemes.primaryColor)),
        child: Form(
          key: _formKey,
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
                        onSaved: (value) {
                          context.read<Vertrag_Provider>().addVertragName(value);
                        },
                        labelText: "Name",
                        initialValue: vertrag != null ? vertrag!.name : "",
                      ),
                      CustomSearchDropdown(
                        onSaved: (value) async {
                          if (value != null) {
                            String labelName = value.toString().split(":")[1].trim();
                            labelName = labelName.replaceAll("}", "");

                            Label label = await getHiveLabelByName(labelName);
                            context.read<Vertrag_Provider>().addVertragLabel(label);
                          }
                        },
                      ),
                      CustomInputField(
                        onSaved: (value) {
                          context.read<Vertrag_Provider>().addVertragBeschreibung(value);
                        },
                        labelText: "Beschreibung",
                        initialValue: vertrag != null ? vertrag!.beschreibung : "",
                      ),
                      // CustomDropdown(
                      //   labelText: "Label",
                      //   initialValue: vertrag != null ? vertrag!.getLabelName() : "",
                      //   callback: setLabel,
                      // ),
                    ],
                  )),
              Step(
                  title: Text("Vertragsinformationen"),
                  content: Column(
                    children: [
                      CustomInputField(
                        labelText: "Vertragspartner",
                        initialValue: vertrag != null ? vertrag!.vertragspartner : "",
                        onSaved: (value) {
                          context.read<Vertrag_Provider>().addVertragPartner(value);
                        },
                      ),
                      CustomDatePicker(
                        labelText: "Vertragsbeginn",
                        initialValue: vertrag != null ? vertrag!.getVertragsBeginn() : "",
                        onSaved: (value) {
                          context.read<Vertrag_Provider>().addVertragsBeginn(value);
                        },
                      ),
                      CustomDatePicker(
                        labelText: "Vertragsende",
                        initialValue: vertrag != null ? vertrag!.getVertragsEnde() : "",
                        onSaved: (value) {
                          context.read<Vertrag_Provider>().addVertragEnde(value);
                        }, // inputController: controllers[4],
                      ),
                      CustomDatePicker(
                        labelText: "Kündigungsfrist",
                        initialValue: vertrag != null ? vertrag!.getKuendigungsfrist() : "",
                        onSaved: (value) {
                          context.read<Vertrag_Provider>().addVertragKuendigungsfrist(value);
                        },
                      ),
                    ],
                  )),
              Step(
                  title: Text("Zahlungsinformationen"),
                  content: Column(
                    children: [
                      CustomDropdown(
                        labelText: "Intervall",
                        initialValue: vertrag != null ? vertrag!.intervall : "kein Intervall",
                        callback: setIntervall,
                      ),
                      CustomInputField(
                        labelText: "Beitrag",
                        keyboardType: TextInputType.number,
                        initialValue: vertrag != null ? vertrag!.getBeitragNumber() : "",
                        onSaved: (value) {
                          context.read<Vertrag_Provider>().addVertragBeitrag(value);
                        },
                      ),
                      CustomDatePicker(
                        labelText: "Erstzahlung",
                        initialValue: vertrag != null ? vertrag!.getErstzahlung() : "",
                        onSaved: (value) {
                          context.read<Vertrag_Provider>().addVertragErstzahlung(value);
                        },
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
        ),
      ),
    );
  }

  setName(String newName) {
    setState(() {
      vertrag!.name = newName;
    });
  }

  bool validateVertrag(Vertrag? vertrag) {
    // if (_controllers[0].text != "") return true;
    return true;
  }

  fillVertrag() {
    setState(() {});
  }

  setLabel(newValue) {
    if (newValue == null) return;
    vertrag!.label.name = newValue;
  }

  setIntervall(newValue) {
    if (newValue == null) return;
    vertrag!.intervall = newValue;
  }
}
