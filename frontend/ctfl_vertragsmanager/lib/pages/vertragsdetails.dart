import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:ctfl_vertragsmanager/models/vertragsdaten.dart';
import 'package:ctfl_vertragsmanager/partials/customLabeledText.dart';
import 'package:ctfl_vertragsmanager/partials/vertragscard.dart';
import 'package:flutter/material.dart';

class VertragsDetailsPage extends StatelessWidget {
  VertragsDetailsPage({Key? key}) : super(key: key);
  //TODO: Zahlungsinfos 2x2
  Vertragsdaten vertraegedaten = Vertragsdaten();
  late Vertrag vertrag;

  @override
  Widget build(BuildContext context) {
    final dynamic arguments = ModalRoute.of(context)!.settings.arguments;
    final int vertragsId =
        arguments != null ? ModalRoute.of(context)!.settings.arguments as int : 1;

    vertrag = vertraegedaten.getVertragById(vertragsId);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: vertrag.label.color,
        title: Text(
          vertrag.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Icon(
            Icons.delete_outlined,
            size: 30,
          ),
        ],
      ),
      body: ListView(
        children: [
          DetailsTile(value: vertrag.name, description: "Name"),
          DetailsTile(value: vertrag.description, description: "Beschreibung"),
          DetailsTile(value: vertrag.getLabelName(), description: "Label"),
          SizedBox(height: 20),
          Text(
            "Zahlungsinformationen",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          DetailsTile(value: vertrag.getIntervall(), description: "Intervall"),
          DetailsTile(value: vertrag.getBeitragEuro(), description: "Beitrag"),
          DetailsTile(value: vertrag.getErstzahlung(), description: "Erstzahlung"),
          DetailsTile(value: vertrag.getNaechsteZahlung(), description: "nächste Zahlung"),
          SizedBox(height: 20),
          Text(
            "Vertragsinformationen",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          DetailsTile(value: vertrag.vertragspartner, description: "Vertragspartner"),
          DetailsTile(value: vertrag.getVertragsBeginn(), description: "Vertragsbeginn"),
          DetailsTile(value: vertrag.getVertragsEnde(), description: "Vertragsende"),
          DetailsTile(value: vertrag.getKuendigungsfrist(), description: "Kündigungsfrist"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/vertragHinzufuegen', arguments: vertragsId);
        },
        backgroundColor: ColorThemes.primaryColor,
        child: const Icon(
          Icons.edit,
          size: 25,
        ),
      ),
    );
  }
}
