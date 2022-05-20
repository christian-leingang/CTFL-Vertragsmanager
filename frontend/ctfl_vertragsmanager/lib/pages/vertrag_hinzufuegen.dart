// ignore_for_file: use_build_context_synchronously

import 'package:ctfl_vertragsmanager/constants/colors.dart';
import 'package:ctfl_vertragsmanager/funktionen/db_functions.dart';
import 'package:ctfl_vertragsmanager/funktionen/hive_functions.dart';
import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:ctfl_vertragsmanager/partials/custom_date_picker.dart';
import 'package:ctfl_vertragsmanager/partials/custom_drop_down.dart';
import 'package:ctfl_vertragsmanager/partials/custom_input_field.dart';
import 'package:ctfl_vertragsmanager/partials/custom_search_dropdown.dart';
import 'package:ctfl_vertragsmanager/provider/all_vertraege_provider.dart';
import 'package:ctfl_vertragsmanager/provider/cur_vertrag_provider.dart';
import 'package:ctfl_vertragsmanager/provider/new_vertrag_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VertragHinzufuegenPage extends StatefulWidget {
  const VertragHinzufuegenPage({Key? key}) : super(key: key);

  @override
  State<VertragHinzufuegenPage> createState() => _VertragHinzufuegenPageState();
}

class _VertragHinzufuegenPageState extends State<VertragHinzufuegenPage> {
  int _index = 0;
  bool loading = true;

  final _formKey = GlobalKey<FormState>();

  //Vertragsdaten vertraegedaten = Vertragsdaten();
  late Vertrag vertrag;

  // String vertragsId = "Error invalid";
  String vertragsId = "abc123";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeVertrag();
  }

  initializeVertrag() async {
    vertragsId = context.read<CurVertragProvider>().curVertragId;
    if (vertragsId != "-1") {
      vertrag = await context.read<CurVertragProvider>().getCurVertrag();
    } else {
      context.read<NewVertragProvider>().resetNewVertrag();
      vertrag = Vertrag(name: "", beitrag: 0.0);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Text("Loading");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Vertrag hinzufügen"),
        backgroundColor: ColorThemes.primaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: IconButton(
              icon: const Icon(
                Icons.save_outlined,
                size: 30,
              ),
              onPressed: () async {
                _formKey.currentState!.save();

                if (validateVertrag(vertrag)) {
                  Vertrag newVertrag = context.read<NewVertragProvider>().newVertrag;

                  if (vertragsId != "-1") {
                    newVertrag.id = vertragsId;
                    vertragsId = await updateVertrag(newVertrag);
                  } else {
                    vertragsId = await createVertrag(newVertrag);
                  }

                  if (vertragsId.startsWith("Error")) {
                    const snackBar = SnackBar(
                      content: Text(
                          'Ein Fehler ist aufgetreten, probieren Sie es mit einer Internetverbindung erneut.'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    context.read<CurVertragProvider>().setCurVertragId(vertragsId);
                    context.read<AllVertraegeProvider>().notifyOurListeners();
                    Navigator.popAndPushNamed(context, '/vertragsDetails', arguments: vertrag.id);
                  }
                } else {
                  const snackBar = SnackBar(
                    content: Text('Bitte füllen Sie die Felder Name und Beitrag aus.'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  style: ElevatedButton.styleFrom(
                    primary: ColorThemes.primaryColor,
                  ),
                  child: const Text('Weiter'),
                ),
                TextButton(
                  onPressed: details.onStepCancel,
                  style: TextButton.styleFrom(
                    primary: ColorThemes.primaryColor,
                  ),
                  child: const Text('Zurück'),
                ),
              ],
            );
          },
          steps: [
            Step(
                title: const Text("Allgemeines"),
                content: Column(
                  children: [
                    CustomInputField(
                      onSaved: (value) {
                        context.read<NewVertragProvider>().addVertragName(value);
                      },
                      labelText: "Name  *",
                      initialValue: vertrag.name,
                    ),
                    CustomInputField(
                      labelText: "Beitrag *",
                      keyboardType: TextInputType.number,
                      initialValue: vertrag.beitrag != 0.0 ? vertrag.getBeitragNumber() : "",
                      onSaved: (value) {
                        context.read<NewVertragProvider>().addVertragBeitrag(value);
                      },
                    ),
                    CustomSearchDropdown(
                      onSaved: (value) async {
                        if (value != null) {
                          String labelName = value.toString().split(":")[1].trim();
                          labelName = labelName.replaceAll("}", "");

                          Label label = getHiveLabelByName(labelName);
                          context.read<NewVertragProvider>().addVertragLabel(label);
                        }
                      },
                    ),
                    CustomInputField(
                      onSaved: (value) {
                        context.read<NewVertragProvider>().addVertragBeschreibung(value);
                      },
                      labelText: "Beschreibung",
                      initialValue: vertrag.beschreibung ?? "",
                    ),
                    // CustomDropdown(
                    //   labelText: "Label",
                    //   initialValue: vertrag != null ? vertrag.getLabelName() : "",
                    //   callback: setLabel,
                    // ),
                  ],
                )),
            Step(
                title: const Text("Vertragsinformationen"),
                content: Column(
                  children: [
                    CustomInputField(
                      labelText: "Vertragspartner",
                      initialValue: vertrag.vertragspartner ?? "",
                      onSaved: (value) {
                        context.read<NewVertragProvider>().addVertragPartner(value);
                      },
                    ),
                    CustomDatePicker(
                      labelText: "Vertragsbeginn",
                      initialValue: vertrag.getVertragsBeginn() ?? "",
                      onSaved: (value) {
                        context.read<NewVertragProvider>().addVertragsBeginn(value);
                      },
                    ),
                    CustomDatePicker(
                      labelText: "Vertragsende",
                      initialValue: vertrag.getVertragsEnde() ?? "",
                      onSaved: (value) {
                        context.read<NewVertragProvider>().addVertragEnde(value);
                      }, // inputController: controllers[4],
                    ),
                    CustomDatePicker(
                      labelText: "Kündigungsfrist",
                      initialValue: vertrag.getKuendigungsfrist() ?? "",
                      onSaved: (value) {
                        context.read<NewVertragProvider>().addVertragKuendigungsfrist(value);
                      },
                    ),
                  ],
                )),
            Step(
                title: const Text("Zahlungsinformationen"),
                content: Column(
                  children: [
                    CustomDropdown(
                      labelText: "Intervall",
                      initialValue: vertrag.intervall ?? "kein Intervall",
                      callback: setIntervall,
                    ),
                    CustomDatePicker(
                      labelText: "Erstzahlung",
                      initialValue: vertrag.getErstzahlung() ?? "",
                      onSaved: (value) {
                        context.read<NewVertragProvider>().addVertragErstzahlung(value);
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
    );
  }

  setName(String newName) {
    setState(() {
      vertrag.name = newName;
    });
  }

  bool validateVertrag(Vertrag? vertrag) {
    Vertrag vertrag = context.read<NewVertragProvider>().newVertrag;
    if (vertrag.name != "Neuer Vertrag" && vertrag.beitrag != 0.0 && vertrag.name != "") {
      return true;
    }
    return false;
  }

  fillVertrag() {
    setState(() {});
  }

  setLabel(newValue) {
    if (newValue == null) return;
    vertrag.label!.name = newValue;
  }

  setIntervall(newValue) {
    if (newValue == null) return;
    vertrag.intervall = newValue;
  }
}
