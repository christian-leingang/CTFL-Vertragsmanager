import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'db_functions.dart';

Future<dynamic> createAlertDialogChangeName(BuildContext context) {
  TextEditingController nameController = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Name ändern"),
          content: TextField(
            controller: nameController,
          ),
          actions: [
            MaterialButton(
              elevation: 5,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Abbruch"),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(nameController.text.toString());
              },
              elevation: 5,
              child: const Text('OK'),
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
          title: const Text("Passwort ändern"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextField(
                decoration: InputDecoration(
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
              elevation: 5,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Abbruch"),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop(passwordController.text.toString());
              },
              elevation: 5,
              child: const Text('OK'),
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
          title: const Text("Sind Sie sicher, dass sie ihr Konto löschen wollen?"),
          actions: [
            MaterialButton(
              elevation: 5,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Nein"),
            ),
            MaterialButton(
              onPressed: () async {
                deleteProfile();
                deleteSession(); //TODO: Konto löschen implementieren

                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('profile', "");

                Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
              },
              elevation: 5,
              child: const Text('Ja'),
            ),
          ],
        );
      });
}

Future<dynamic> logout(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Sind Sie sicher, dass Sie sich ausloggen möchten?"),
          actions: [
            MaterialButton(
              elevation: 5,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Nein"),
            ),
            MaterialButton(
              onPressed: () async {
                await deleteSession();

                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('profile', "");
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
              },
              elevation: 5,
              child: const Text('Ja'),
            ),
          ],
        );
      });
}
