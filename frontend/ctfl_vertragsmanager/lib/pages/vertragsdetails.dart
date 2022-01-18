import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:ctfl_vertragsmanager/funktionen/hiveFunctions.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:ctfl_vertragsmanager/models/vertragsdaten.dart';
import 'package:ctfl_vertragsmanager/partials/customLabeledText.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class VertragsDetailsPage extends StatelessWidget {
  VertragsDetailsPage({Key? key}) : super(key: key);
  //TODO: Zahlungsinfos 2x2
  //Vertragsdaten vertraegedaten = Vertragsdaten();
  late Vertrag vertrag;
  final vertragsBox = HiveFunctions.getHiveVertraege();

  @override
  Widget build(BuildContext context) {
    final dynamic arguments = ModalRoute.of(context)!.settings.arguments;
    final String vertragsId =
        arguments != null ? ModalRoute.of(context)!.settings.arguments as String : "1";

    vertrag = vertragsBox.get(vertragsId)!;
    //vertrag = vertraegedaten.getVertragById(vertragsId);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:
            vertrag.label.colorValue == null || vertrag.label.colorValue == Colors.white.value
                ? ColorThemes.primaryColor
                : Color(vertrag.label.colorValue),
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
          if (vertrag.beschreibung.trim().length > 0)
            DetailsTile(value: vertrag.beschreibung, description: "Beschreibung"),
          if (vertrag.label.name.trim().length > 0)
            DetailsTile(value: vertrag.getLabelName(), description: "Label"),
          SizedBox(height: 20),
          if (vertrag.intervall.trim().length > 0 ||
              vertrag.getBeitragNumber().trim().length > 0 ||
              vertrag.getErstzahlung().trim().length > 0 ||
              vertrag.getNaechsteZahlung().trim().length > 0)
            Text(
              "Zahlungsinformationen",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          if (vertrag.intervall == "kein Intervall")
            DetailsTile(value: vertrag.intervall, description: "Intervall"),
          if (vertrag.getBeitragNumber().trim().length > 0)
            DetailsTile(value: vertrag.getBeitragEuro(), description: "Beitrag"),
          if (vertrag.getErstzahlung().trim().length > 0)
            DetailsTile(value: vertrag.getErstzahlung(), description: "Erstzahlung"),
          if (vertrag.getNaechsteZahlung().trim().length > 0)
            DetailsTile(value: vertrag.getNaechsteZahlung(), description: "nächste Zahlung"),
          SizedBox(height: 20),
          if (vertrag.vertragspartner.trim().length > 0 ||
              vertrag.getVertragsBeginn().trim().length > 0 ||
              vertrag.getVertragsEnde().trim().length > 0 ||
              vertrag.getKuendigungsfrist().trim().length > 0)
            Text(
              "Vertragsinformationen",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          if (vertrag.vertragspartner.trim().length > 0)
            DetailsTile(value: vertrag.vertragspartner, description: "Vertragspartner"),
          if (vertrag.getVertragsBeginn().trim().length > 0)
            DetailsTile(value: vertrag.getVertragsBeginn(), description: "Vertragsbeginn"),
          if (vertrag.getVertragsEnde().trim().length > 0)
            DetailsTile(value: vertrag.getVertragsEnde(), description: "Vertragsende"),
          if (vertrag.getKuendigungsfrist().trim().length > 0)
            DetailsTile(value: vertrag.getKuendigungsfrist(), description: "Kündigungsfrist"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, '/vertragHinzufuegen', arguments: vertragsId);
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
