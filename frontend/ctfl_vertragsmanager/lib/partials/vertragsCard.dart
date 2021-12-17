import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:flutter/material.dart';

class VertragsCardPage extends StatelessWidget {
  String name;
  String date; //TODO: welcher Datentyp kommt hier an? Date nicht gefunden
  double price;
  Label label; //TODO: welcher Datentyp kommt hier an? Evtl. Array oder Enum nehmen

  VertragsCardPage(
      {required this.name, required this.date, required this.price, required this.label});

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            // TODO: Umrandung überlegen
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(5.0),
            //   side: BorderSide(
            //     color: label.color,
            //   ),
            // ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(date),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: label.color,
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            label.name,
                          ),
                        ),
                      ),
                      Text("€" + price.toString())
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  )
                ],
              ),
            ),
            borderOnForeground: true,
            elevation: 5,
          ),
        ],
      );
}
