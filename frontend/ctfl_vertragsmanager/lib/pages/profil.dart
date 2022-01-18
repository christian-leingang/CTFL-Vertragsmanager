import 'dart:convert';
import 'dart:io';
import 'package:ctfl_vertragsmanager/constants/Color_Themes.dart';
import 'package:ctfl_vertragsmanager/funktionen/dbFunctions.dart';
import 'package:ctfl_vertragsmanager/funktionen/profilFunktionen.dart';
import 'package:ctfl_vertragsmanager/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilPage extends StatefulWidget {
  late Profile user = Profile(email: "", password: "");
  File? profilePicture = null;

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  getUserInformation() async {
    Profile user = await getProfilFromPrefs();
    setState(() {
      widget.user = user;
    });
  }

  @override
  void initState() {
    getUserInformation();
  }

  Future _createDialogChangeProfilePicture(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Bild auswählen'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () async {
                  _imgFromGalleryOrCamera("camera");
                },
                child: const Text('Kamera'),
              ),
              SimpleDialogOption(
                onPressed: () async {
                  _imgFromGalleryOrCamera("Gallery");
                },
                child: const Text('Galerie'),
              ),
            ],
          );
        });
  }

  Future _imgFromGalleryOrCamera(String location) async {
    ImageSource source;
    if (location == "Gallery")
      source = ImageSource.gallery;
    else
      source = ImageSource.camera;
    try {
      final image = await ImagePicker().pickImage(source: source, imageQuality: 50);
      if (image == null) return;
      final imageTemp = File(image.path);
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                  subtitle: Text("Möchten Sie Ihr Konto unwiderruflich löschen?"),
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
