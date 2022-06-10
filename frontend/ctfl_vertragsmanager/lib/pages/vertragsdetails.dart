import 'package:ctfl_vertragsmanager/constants/colors.dart';
import 'package:ctfl_vertragsmanager/funktionen/db_functions.dart';
import 'package:ctfl_vertragsmanager/funktionen/hive_functions.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:ctfl_vertragsmanager/partials/custom_labeled_text.dart';
import 'package:ctfl_vertragsmanager/provider/all_vertraege_provider.dart';
import 'package:ctfl_vertragsmanager/provider/cur_vertrag_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VertragsDetailsPage extends StatefulWidget {
  const VertragsDetailsPage({Key? key}) : super(key: key);

  @override
  State<VertragsDetailsPage> createState() => _VertragsDetailsPageState();
}

class _VertragsDetailsPageState extends State<VertragsDetailsPage> {
  bool loading = true;
  late Color labelColor = ColorThemes.primaryColor;

  //TODO: Zahlungsinfos 2x2
  late Vertrag vertrag;

  final vertragsBox = HiveFunctions.getHiveVertraege();

  getVertrag() async {
    vertrag = await context.read<CurVertragProvider>().getCurVertrag();
    context.read<CurVertragProvider>().setCurVertragId(vertrag.id!);
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
    if (loading) return const Text("Loading");
    labelColor = vertrag.label == null || vertrag.label!.colorValue == Colors.white.value
        ? ColorThemes.primaryColor
        : Color(vertrag.label!.colorValue);
    if (vertrag.label != null) {}
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.read<CurVertragProvider>().resetCurVertragId();
              context.read<AllVertraegeProvider>().notifyOurListeners();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        backgroundColor: labelColor,
        title: Text(
          vertrag.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await deleteVertrag(vertrag.id!);
              context.read<CurVertragProvider>().resetCurVertragId();
              context.read<AllVertraegeProvider>().notifyOurListeners();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.delete_outlined,
              size: 30,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 15),
          DetailsTile(value: vertrag.name, description: "Name", lineColor: labelColor),
          if (vertrag.beschreibung != null && vertrag.beschreibung!.trim().isNotEmpty)
            DetailsTile(
                value: vertrag.beschreibung!, description: "Beschreibung", lineColor: labelColor),
          if (vertrag.label != null && vertrag.label!.name.trim().isNotEmpty)
            DetailsTile(
                value: vertrag.getLabelName()!, description: "Label", lineColor: labelColor),
          const SizedBox(height: 20),
          if (vertrag.intervall != null ||
              vertrag.getBeitragNumber() != null ||
              vertrag.getErstzahlung() != null ||
              vertrag.getNaechsteZahlung() != null)
            const Text(
              "Zahlungsinformationen",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          if (vertrag.intervall != null)
            DetailsTile(value: vertrag.intervall!, description: "Intervall", lineColor: labelColor),
          if (vertrag.getBeitragNumber() != null)
            DetailsTile(
                value: vertrag.getBeitragEuro(), description: "Beitrag", lineColor: labelColor),
          if (vertrag.getErstzahlung() != null)
            DetailsTile(
                value: vertrag.getErstzahlung()!,
                description: "Erstzahlung",
                lineColor: labelColor),
          if (vertrag.getNaechsteZahlung() != null &&
              vertrag.getNaechsteZahlung()!.trim().isNotEmpty)
            DetailsTile(
                value: vertrag.getNaechsteZahlung()!,
                description: "nächste Zahlung",
                lineColor: labelColor),
          const SizedBox(height: 20),
          if ((vertrag.vertragspartner != null) ||
              vertrag.getVertragsBeginn() != null ||
              vertrag.getVertragsEnde() != null ||
              vertrag.getKuendigungsfrist() != null)
            const Text(
              "Vertragsinformationen",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          if (vertrag.vertragspartner != null)
            DetailsTile(
                value: vertrag.vertragspartner!,
                description: "Vertragspartner",
                lineColor: labelColor),
          if (vertrag.getVertragsBeginn() != null)
            DetailsTile(
                value: vertrag.getVertragsBeginn()!,
                description: "Vertragsbeginn",
                lineColor: labelColor),
          if (vertrag.getVertragsEnde() != null)
            DetailsTile(
                value: vertrag.getVertragsEnde()!,
                description: "Vertragsende",
                lineColor: labelColor),
          if (vertrag.getKuendigungsfrist() != null)
            DetailsTile(
                value: vertrag.getKuendigungsfrist()!,
                description: "Kündigungsfrist",
                lineColor: labelColor),
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
