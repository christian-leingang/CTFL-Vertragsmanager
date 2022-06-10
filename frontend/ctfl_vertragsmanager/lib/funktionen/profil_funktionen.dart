import 'package:ctfl_vertragsmanager/constants/colors.dart';
import 'package:ctfl_vertragsmanager/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  TextEditingController pwControl = TextEditingController();
  TextEditingController pwControlConfirm = TextEditingController();
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
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Altes Passwort',
                ),
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Neues Passwort',
                ),
                controller: pwControl,
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Neues Passwort bestätigen',
                ),
                controller: pwControlConfirm,
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
              onPressed: () async {
                if (pwControl.text.toString() == pwControlConfirm.text.toString()) {
                  bool passwordChanged = await changePassword(hashPW(pwControl.text.toString()));
                  print(passwordChanged);
                  if (passwordChanged) {
                    Profile profil = await getProfilFromPrefs();
                    profil.password = hashPW(pwControl.text.toString());
                    setProfilToPrefs(profil);
                    showToast("Passwort wurde erfolgreich geändert");
                    Navigator.of(context).pop();
                  } else {
                    showToast("Passwort konnte nicht geändert werden");
                  }
                } else {
                  showToast("Passwörter stimmen nicht überein");
                }
              },
              elevation: 5,
              child: const Text('OK'),
            ),
          ],
        );
      });
}

void showToast(String toastText) {
  Fluttertoast.showToast(
    msg: toastText,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

Future<dynamic> createAlertDialogDeleteProfile(BuildContext context) {
  String password = "";
  //Bei Bestätigung wieder auf LoginPage leiten
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Sind Sie sicher, dass sie ihr Konto löschen wollen?"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Geben Sie hierfür ihr Passwort ein:"),
              TextField(
                decoration: const InputDecoration(labelText: "Passwort"),
                obscureText: true,
                onChanged: (value) => password = value,
              )
            ],
          ),
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
                print(password);
                if (password != "") {
                  bool profileDeleted = await deleteProfile(hashPW(password));
                  if (profileDeleted) {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.clear();
                    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                  } else {
                    print("profile not deleted");
                    Fluttertoast.showToast(
                      msg: "Passwort ist falsch",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.TOP,
                      backgroundColor: ColorThemes.primaryColor,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                }
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
                bool sessionDeleted = false;
                sessionDeleted = await deleteSession();
                print(sessionDeleted);
                if (sessionDeleted) {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('profile', "");
                  Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                }
              },
              elevation: 5,
              child: const Text('Ja'),
            ),
          ],
        );
      });
}
