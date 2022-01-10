import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:ctfl_vertragsmanager/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> createUser(Profile profil) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var url = Uri.parse('http://10.0.2.2:8080/api/users');
  var body = {
    "email": profil.email,
    "password": profil.password,
    "passwordConfirmation": profil.password,
    "name": "Max Default" //TODO entfernen wenn im Backend angepasst
    //TODO Profilbild ergänzen wenn im Backend angepasst
  };
  var body_json = jsonEncode(body);
  var response = await http.post(
    url,
    body: body_json,
    headers: {"Content-Type": "application/json"},
  );
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  return response.statusCode == 200;
}

createSession(Profile profil) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Create Post-Request
  var url = Uri.parse('http://10.0.2.2:8080/api/sessions');
  var body = {
    "email": profil.email,
    "password": profil.password,
  };
  var body_json = jsonEncode(body);
  var response = await http.post(
    url,
    body: body_json,
    headers: {"Content-Type": "application/json"},
  );
  //Create UserProfile with Tokens
  if (response.body.startsWith("Invalid")) return false;

  Map<String, dynamic> responseMap = jsonDecode(response.body);

  Profile newUser = Profile(
    email: profil.email,
    password: profil.password,
    accessToken: responseMap["accessToken"],
    refreshToken: responseMap["refreshToken"],
  );
  Map<String, dynamic> userMap = {
    'email': newUser.email,
    'password': newUser.password,
    'accessToken': newUser.accessToken,
    'refreshToken': newUser.refreshToken
  };
  String rawJason = jsonEncode(userMap);
  prefs.setString('profile', rawJason);

  return response.statusCode == 200;
}

getSession() async {}

deleteSession() async {}

createVertrag() async {}

getVertrag() async {}

updateVertrag() async {}

deleteVertrag() async {}

getAllVertraege() async {}

Future<Profile> getProfilFromPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final rawJson = prefs.getString('profile');
  Map<String, dynamic> map = jsonDecode(rawJson!);
  final user = Profile(
      email: map['email'],
      password: map['password'],
      accessToken: ['accessToken'],
      refreshToken: ['refreshToken']); //TODO Profilbild ergänzen
  return user;
}
