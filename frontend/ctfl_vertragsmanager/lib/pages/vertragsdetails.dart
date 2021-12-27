import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:ctfl_vertragsmanager/models/vertragsdaten.dart';
import 'package:flutter/material.dart';

int vertragsId = 0;

class VertragsDetailsPage extends StatelessWidget {
  List<Vertrag> vertraege = Vertragsdaten().vertraege;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xffD72324),
        title: Text(vertraege[vertragsId].name),
        actions: [
          Icon(
            Icons.delete_outlined,
            size: 30,
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 5,
        children: [
          Text("Name"),
          Text(
            vertraege[vertragsId].name,
            style: const TextStyle(fontSize: 25),
          ),
          Text("Beschreibung"),
          Text(
            vertraege[vertragsId].description,
            style: const TextStyle(fontSize: 15),
          )
        ],
      ),

      // Center(
      //   child: Column(
      //     mainAxisSize: MainAxisSize.max,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Row(
      //         children: [
      //           Text("Name"),
      //           SizedBox(
      //             width: 20,
      //           ),
      //           Text(
      //             vertraege[vertragsId].name,
      //             style: const TextStyle(fontSize: 25),
      //           )
      //         ],
      //       ),
      //       Row(
      //         children: [
      //           Text("Beschreibung"),
      //           SizedBox(
      //             width: 20,
      //           ),
      //           Text(
      //             vertraege[vertragsId].description,
      //             style: const TextStyle(fontSize: 15),
      //           )
      //         ],
      //       ),
      //       Row(
      //         children: [
      //           Text("Label"),
      //           SizedBox(
      //             width: 20,
      //           ),
      //           Text(
      //             vertraege[vertragsId].label.toString(),
      //             style: const TextStyle(fontSize: 15),
      //           )
      //         ],
      //       ),
      //       Text(
      //         "Vertragsinformationen",
      //         style: const TextStyle(fontSize: 25),
      //       ),
      //       Row(
      //         children: [
      //           Text("Vertragspartner"),
      //           SizedBox(
      //             width: 20,
      //           ),
      //           Text(
      //             vertraege[vertragsId].vertragspartner,
      //             style: const TextStyle(fontSize: 15),
      //           )
      //         ],
      //       ),
      //       Row(
      //         children: [
      //           Text("Vertragsbeginn"),
      //           SizedBox(
      //             width: 20,
      //           ),
      //           Text(
      //             vertraege[vertragsId].getVertragsBeginn(),
      //             style: const TextStyle(fontSize: 15),
      //           )
      //         ],
      //       ),
      //       Row(
      //         children: [
      //           Text("Vertragsende"),
      //           SizedBox(
      //             width: 20,
      //           ),
      //           Text(
      //             vertraege[vertragsId].getVertragsEnde(),
      //             style: const TextStyle(fontSize: 15),
      //           )
      //         ],
      //       ),
      //       Row(
      //         children: [
      //           Text("Kündigungsfrist"),
      //           SizedBox(
      //             width: 20,
      //           ),
      //           Text(
      //             vertraege[vertragsId].getKuendigungsfrist(),
      //             style: const TextStyle(fontSize: 15),
      //           )
      //         ],
      //       ),
      //       Text(
      //         "Zahlungsinformationen",
      //         style: const TextStyle(fontSize: 25),
      //       ),
      //       Row(
      //         children: [
      //           Text("Intervall"),
      //           SizedBox(
      //             width: 20,
      //           ),
      //           Text(
      //             vertraege[vertragsId].intervall.toString(),
      //             style: const TextStyle(fontSize: 15),
      //           )
      //         ],
      //       ),
      //       Row(
      //         children: [
      //           Text("Beitrag"),
      //           SizedBox(
      //             width: 20,
      //           ),
      //           Text(
      //             vertraege[vertragsId].beitrag.toString(),
      //             style: const TextStyle(fontSize: 15),
      //           )
      //         ],
      //       ),
      //       Row(
      //         children: [
      //           Text("Erstzahlung"),
      //           SizedBox(
      //             width: 20,
      //           ),
      //           Text(
      //             vertraege[vertragsId].getErstzahlung(),
      //             style: const TextStyle(fontSize: 15),
      //           )
      //         ],
      //       ),
      //       Row(
      //         children: [
      //           Text("nächste Zahlung"),
      //           SizedBox(
      //             width: 20,
      //           ),
      //           Text(
      //             vertraege[vertragsId].getNaechsteZahlung(),
      //             style: const TextStyle(fontSize: 15),
      //           )
      //         ],
      //       ),
      //     ],
      //   ),

      floatingActionButton: FloatingActionButton(child: Icon(Icons.edit), onPressed: () {}),
    );
  }
}
