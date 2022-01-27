import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:ctfl_vertragsmanager/funktionen/dbFunctions.dart';
import 'package:ctfl_vertragsmanager/funktionen/hiveFunctions.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:ctfl_vertragsmanager/models/vertragsdaten.dart';
import 'package:ctfl_vertragsmanager/partials/customLabeledText.dart';
import 'package:ctfl_vertragsmanager/provider/all_vertraege_provider.dart';
import 'package:ctfl_vertragsmanager/provider/cur_vertrag_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/src/provider.dart';

class VertragsDetailsPage extends StatefulWidget {
  VertragsDetailsPage({Key? key}) : super(key: key);

  @override
  State<VertragsDetailsPage> createState() => _VertragsDetailsPageState();
}

class _VertragsDetailsPageState extends State<VertragsDetailsPage> {
  bool loading = true;

  //TODO: Zahlungsinfos 2x2
  late Vertrag vertrag;

  final vertragsBox = HiveFunctions.getHiveVertraege();

  getVertrag() async {
    vertrag = await context.read<cur_Vertrag_Provider>().get_cur_Vertrag();
    context.read<cur_Vertrag_Provider>().set_cur_Vertrag_id(vertrag.id!);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getVertrag();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return Text("Loading");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.read<cur_Vertrag_Provider>().reset_cur_Vertrag_id();
              Navigator.popAndPushNamed(context, '/main');
            },
            icon: Icon(Icons.arrow_back)),
        centerTitle: true,
        backgroundColor: vertrag.label == null || vertrag.label!.colorValue == Colors.white.value
            ? ColorThemes.primaryColor
            : Color(vertrag.label!.colorValue),
        title: Text(
          vertrag.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              deleteVertrag(vertrag.id!);
              context.read<cur_Vertrag_Provider>().reset_cur_Vertrag_id();
              context.read<all_Vertraege_Provider>().notifyOurListeners();
              Navigator.popAndPushNamed(context, '/main');
            },
            icon: Icon(
              Icons.delete_outlined,
              size: 30,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          DetailsTile(value: vertrag.name, description: "Name"),
          if (vertrag.beschreibung != null && vertrag.beschreibung!.trim().length > 0)
            DetailsTile(value: vertrag.beschreibung!, description: "Beschreibung"),
          if (vertrag.label != null && vertrag.label!.name.trim().length > 0)
            DetailsTile(value: vertrag.getLabelName()!, description: "Label"),
          SizedBox(height: 20),
          if (vertrag.intervall != null ||
              vertrag.getBeitragNumber() != null ||
              vertrag.getErstzahlung() != null ||
              vertrag.getNaechsteZahlung() != null)
            Text(
              "Zahlungsinformationen",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          if (vertrag.intervall != null)
            DetailsTile(value: vertrag.intervall!, description: "Intervall"),
          if (vertrag.getBeitragNumber() != null)
            DetailsTile(value: vertrag.getBeitragEuro()!, description: "Beitrag"),
          if (vertrag.getErstzahlung() != null)
            DetailsTile(value: vertrag.getErstzahlung()!, description: "Erstzahlung"),
          if (vertrag.getNaechsteZahlung() != null &&
              vertrag.getNaechsteZahlung()!.trim().length > 0)
            DetailsTile(value: vertrag.getNaechsteZahlung()!, description: "nächste Zahlung"),
          SizedBox(height: 20),
          if ((vertrag.vertragspartner != null) ||
              vertrag.getVertragsBeginn() != null ||
              vertrag.getVertragsEnde() != null ||
              vertrag.getKuendigungsfrist() != null)
            Text(
              "Vertragsinformationen",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          if (vertrag.vertragspartner != null)
            DetailsTile(value: vertrag.vertragspartner!, description: "Vertragspartner"),
          if (vertrag.getVertragsBeginn() != null)
            DetailsTile(value: vertrag.getVertragsBeginn()!, description: "Vertragsbeginn"),
          if (vertrag.getVertragsEnde() != null)
            DetailsTile(value: vertrag.getVertragsEnde()!, description: "Vertragsende"),
          if (vertrag.getKuendigungsfrist() != null)
            DetailsTile(value: vertrag.getKuendigungsfrist()!, description: "Kündigungsfrist"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, '/vertragHinzufuegen');
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
