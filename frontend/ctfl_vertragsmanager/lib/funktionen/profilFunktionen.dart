import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ctfl_vertragsmanager/models/profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> createAlertDialogChangeName(BuildContext context) {
  TextEditingController nameController = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Name ändern"),
          content: TextField(
            controller: nameController,
          ),
          actions: [
            MaterialButton(
              child: Text("Abbruch"),
              elevation: 5,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(nameController.text.toString());
              },
              child: Text('OK'),
              elevation: 5,
            ),
          ],
        );
      });
}

Future<dynamic> createAlertDialogChangePassword(BuildContext context) {
  //TODO: Überprüfen, ob altes Passwort mit dem aus DB übereinstimmt
  TextEditingController passwordController = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Passwort ändern"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Altes Passwort',
                ),
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Neues Passwort',
                ),
                controller: passwordController,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Neues Passwort bestätigen',
                ),
                controller: passwordController,
              ),
            ],
          ),
          actions: [
            MaterialButton(
              child: Text("Abbruch"),
              elevation: 5,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(passwordController.text.toString());
              },
              child: Text('OK'),
              elevation: 5,
            ),
          ],
        );
      });
}

Future<dynamic> createAlertDialogDeleteProfile(BuildContext context) {
  //Bei Bestätigung wieder auf LoginPage leiten
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Sind Sie sicher, dass sie ihr Konto löschen wollen?"),
          actions: [
            MaterialButton(
              child: Text("Nein"),
              elevation: 5,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
                //TODO: Konto löschen implementieren
              },
              child: Text('Ja'),
              elevation: 5,
            ),
          ],
        );
      });
}
