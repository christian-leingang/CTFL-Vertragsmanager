import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:ctfl_vertragsmanager/pages/vertragsdetails.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VertragsCardPage extends StatelessWidget {
  String name;
  String date; //TODO: welcher Datentyp kommt hier an? Date nicht gefunden
  double price;
  Label label; //TODO: welcher Datentyp kommt hier an? Evtl. Array oder Enum nehmen
  int vertragsId;

  VertragsCardPage(
      {Key? key,
      required this.name,
      required this.date,
      required this.price,
      required this.label,
      required this.vertragsId})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/vertragsDetails',
                  arguments: ScreenArguments(
                    vertragsId,
                  ));
            },
            child: Card(
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
                          style: const TextStyle(
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
                            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
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
          ),
        ],
      );
}

class ScreenArguments {
  final int vertragsId;

  ScreenArguments(this.vertragsId);
}
