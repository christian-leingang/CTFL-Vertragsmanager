import 'dart:convert';

import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:ctfl_vertragsmanager/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilPage extends StatefulWidget {
  late Profile user = Profile(email: "", password: "");
  /*String name = "Max Mustermann";
  String email = "max.mustermann@xyz.de";
  String passwort = "********";*/

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  getUserInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final rawJson = prefs.getString('profile');
    Map<String, dynamic> map = jsonDecode(rawJson!);
    final user = Profile(email: map['email'], password: map['password']);
    setState(() {
      widget.user = user;
    });
  }

  Future<void> createAlertDialogChangePicture() async {
    final ImagePicker _picker = ImagePicker();

    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Bild auswählen'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () async {
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.camera);

                  Navigator.pop(context);
                },
                child: const Text('Kamera'),
              ),
              SimpleDialogOption(
                onPressed: () async {
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);

                  Navigator.pop(context);
                },
                child: const Text('Galerie'),
              ),
            ],
          );
        })) {
      case "Camera":
        // Let's go.
        // ...
        break;
      case "Galerie":
        // ...
        break;
      case null:
        // dialog dismissed
        break;
    }
  }

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

  @override
  void initState() {
    getUserInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(40),
              width: 150,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    child: Icon(
                      Icons.account_circle_outlined,
                      size: 150,
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      createAlertDialogChangePicture();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      primary: ColorThemes.primaryColor,
                    ),
                    child: Icon(Icons.camera_alt),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: [
                const Text("E-Mail:"),
                Text(
                  widget.user.email,
                  style: const TextStyle(fontSize: 25),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.password),
                  subtitle: Text("Möchten Sie Ihr Passwort ändern?"),
                  title: Text(
                    "Passwort ändern",
                  ),
                  onTap: () {
                    createAlertDialogChangePassword(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete),
                  subtitle:
                      Text("Möchten Sie Ihr Konto unwiderruflich löschen?"),
                  title: Text("Konto löschen"),
                  onTap: () {
                    createAlertDialogDeleteProfile(context);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
