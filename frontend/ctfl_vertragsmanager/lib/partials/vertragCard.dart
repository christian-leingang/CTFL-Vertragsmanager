import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:ctfl_vertragsmanager/pages/vertragsdetails.dart';
import 'package:ctfl_vertragsmanager/provider/cur_vertrag_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

// ignore: must_be_immutable
class VertragCardPage extends StatelessWidget {
  Vertrag vertrag;

  VertragCardPage({
    Key? key,
    required this.vertrag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              context.read<cur_Vertrag_Provider>().set_cur_Vertrag_id(vertrag.id!);
              Navigator.pushNamed(context, '/vertragsDetails');
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          vertrag.name,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          vertrag.getNaechsteZahlung() ?? '',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    Row(
                      children: [
                        vertrag.label != null
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Color(vertrag.label!.colorValue),
                                  borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      vertrag.label!.name,
                                    )),
                              )
                            : Text(""),
                        Text(
                          vertrag.getBeitragEuro()!,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        )
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
