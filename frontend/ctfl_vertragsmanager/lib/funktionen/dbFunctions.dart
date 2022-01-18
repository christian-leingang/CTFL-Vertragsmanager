import 'dart:convert';
import 'dart:io';
import 'package:ctfl_vertragsmanager/funktionen/hiveFunctions.dart';
import 'package:ctfl_vertragsmanager/models/label.dart';
import 'package:ctfl_vertragsmanager/models/vertrag.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:ctfl_vertragsmanager/provider/vertrag_provider.dart';
import 'package:ctfl_vertragsmanager/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/src/provider.dart';

Future<bool> createUser(Profile profil) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Uri url = getUrl("users");
  Map<String, String> body = {
    "email": profil.email,
    "password": profil.password,
  };
  String body_json = jsonEncode(body);
  http.Response response = await http.post(
    url,
    body: body_json,
    headers: {"Content-Type": "application/json"},
  );
  return response.statusCode == 200;
}

createSession(Profile profil) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Create Post-Request
  //Uri url = getUrl("sessions");

  Uri url = getUrl("sessions");

  Map<String, String> body = {
    "email": profil.email,
    "password": profil.password,
  };
  String body_json = jsonEncode(body);
  http.Response response = await http.post(
    url,
    body: body_json,
    headers: {"Content-Type": "application/json"},
  );
  //Create UserProfile with Tokens
  if (response.body.startsWith("Invalid")) return false;

  Map<String, dynamic> responseMap = jsonDecode(response.body);

  Profile newUser = Profile(
    id: profil.id,
    email: profil.email,
    password: profil.password,
    accessToken: responseMap["accessToken"],
    refreshToken: responseMap["refreshToken"],
  );
  Map<String, dynamic> userMap = {
    'id': newUser.id,
    'email': newUser.email,
    'password': newUser.password,
    'accessToken': newUser.accessToken,
    'refreshToken': newUser.refreshToken,
  };
  String rawJason = jsonEncode(userMap);
  prefs.setString('profile', rawJason);

  return response.statusCode == 200;
}

//todo: Absprache gibt uns alle aktuell angemeldeten User zurück, brauchen wir nicht, oder?

deleteSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Profile user = await getProfilFromPrefs();
  Uri url = getUrl("sessions");
  http.Response response = await http.delete(
    url,
    headers: {"Content-Type": "application/json", "x-refresh": user.refreshToken},
  );
  if (response.body.startsWith("Invalid")) return false;
  return response.statusCode == 200;
}

Future<String> createVertrag(Vertrag newVertrag) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Create Post-Request
  Uri url = getUrl("products");
  Profile user = await getProfilFromPrefs();

  Map<String, String> body = {
    "name": newVertrag.name,
    if (newVertrag.getLabelName() != null) "label": newVertrag.getLabelName(),
    if (newVertrag.beschreibung != null) "description": newVertrag.beschreibung,
    if (newVertrag.intervall != null) "intervall": newVertrag.intervall,
    if (newVertrag.getBeitragNumber() != null) "beitrag": newVertrag.getBeitragNumber(),
    if (newVertrag.getVertragsBeginn() != null) "vertragsBeginn": newVertrag.getVertragsBeginn(),
    if (newVertrag.getVertragsBeginn() != null) "vertragsEnde": newVertrag.getVertragsEnde(),
    if (newVertrag.getKuendigungsfrist() != null)
      "kuendigungsfrist": newVertrag.getKuendigungsfrist(),
    if (newVertrag.getErstzahlung() != null) "erstZahlung": newVertrag.getErstzahlung(),
  };
  String body_json = jsonEncode(body);
  http.Response response = await http.post(
    url,
    body: body_json,
    headers: {"Content-Type": "application/json", "x-refresh": user.refreshToken},
  );
  //Create UserProfile with Tokens
  debugPrint('Response Body: ${response.body}');

  if (response.body.startsWith("Invalid") || response.body.startsWith("Forbidden")) return "Error";

  Map<String, dynamic> responseMap = jsonDecode(response.body);

  Vertrag returnedVertrag = Vertrag(
    id: responseMap["id"],
    name: responseMap["name"],
    label: responseMap["label"],
    beschreibung: responseMap["description"],
    intervall: responseMap["intervall"],
    beitrag: responseMap["beitrag"],
    vertragsBeginn: responseMap["vertragsBeginn"],
    vertragsEnde: responseMap["vertragsEnde"],
    kuendigungsfrist: responseMap["kuendigungsfrist"],
    erstZahlung: responseMap["erstZahlung"],
  );

  Map<String, dynamic> userMap = {
    "name": newVertrag.name,
    "label": newVertrag.getLabelName(),
    "beschreibung": newVertrag.beschreibung,
    "intervall": newVertrag.intervall,
    "beitrag": newVertrag.getBeitragNumber(),
    "vertragsBeginn": newVertrag.getVertragsBeginn(),
    "vertragsEnde": newVertrag.getVertragsEnde(),
    "kuendigungsfrist": newVertrag.getKuendigungsfrist(),
    "erstZahlung": newVertrag.getErstzahlung(),
  };
  String rawJason = jsonEncode(userMap);
  prefs.setString('profile', rawJason);

  //createHiveVertrag(returnedVertrag);

  return returnedVertrag.id ?? "Error connection";
}

Future<String> updateVertrag(Vertrag newVertrag) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Create Post-Request
  Uri url = getUrl("products");
  Map<String, String> body = {
    "name": newVertrag.name,
    if (newVertrag.getLabelName() != null) "label": newVertrag.getLabelName(),
    if (newVertrag.beschreibung != null) "description": newVertrag.beschreibung,
    if (newVertrag.intervall != null) "intervall": newVertrag.intervall,
    if (newVertrag.getBeitragNumber() != null) "beitrag": newVertrag.getBeitragNumber(),
    if (newVertrag.getVertragsBeginn() != null) "vertragsBeginn": newVertrag.getVertragsBeginn(),
    if (newVertrag.getVertragsBeginn() != null) "vertragsEnde": newVertrag.getVertragsEnde(),
    if (newVertrag.getKuendigungsfrist() != null)
      "kuendigungsfrist": newVertrag.getKuendigungsfrist(),
    if (newVertrag.getErstzahlung() != null) "erstZahlung": newVertrag.getErstzahlung(),
  };
  String body_json = jsonEncode(body);
  http.Response response = await http.put(
    url,
    body: body_json,
    headers: {"Content-Type": "application/json"},
  );
  //Create UserProfile with Tokens
  if (response.body.startsWith("Invalid")) return "Error";

  Map<String, dynamic> responseMap = jsonDecode(response.body);

  Vertrag returnedVertrag = Vertrag(
    id: responseMap["id"],
    name: responseMap["name"],
    label: responseMap["label"],
    beschreibung: responseMap["description"],
    intervall: responseMap["intervall"],
    beitrag: responseMap["beitrag"],
    vertragsBeginn: responseMap["vertragsBeginn"],
    vertragsEnde: responseMap["vertragsEnde"],
    kuendigungsfrist: responseMap["kuendigungsfrist"],
    erstZahlung: responseMap["erstZahlung"],
  );

  Map<String, dynamic> userMap = {
    "name": newVertrag.name,
    "label": newVertrag.getLabelName(),
    "beschreibung": newVertrag.beschreibung,
    "intervall": newVertrag.intervall,
    "beitrag": newVertrag.getBeitragNumber(),
    "vertragsBeginn": newVertrag.getVertragsBeginn(),
    "vertragsEnde": newVertrag.getVertragsEnde(),
    "kuendigungsfrist": newVertrag.getKuendigungsfrist(),
    "erstZahlung": newVertrag.getErstzahlung(),
  };
  String rawJason = jsonEncode(userMap);
  prefs.setString('profile', rawJason);
  createHiveVertrag(returnedVertrag);

  return returnedVertrag.id ?? "Error connection";
} //TODO

Future<bool> deleteVertrag(String vertragId) async {
  Uri url = getUrl("products/$vertragId");

  http.Response response = await http.delete(
    url,
    headers: {"Content-Type": "application/json"},
  );
  if (response.body.startsWith("Invalid")) return false;

  Map<String, dynamic> responseMap = jsonDecode(response.body);
  deleteHiveVertrag(vertragId);

  return true;
}

getAllVertraege(String userId) async {
  Uri url = getUrl("productsUser/$userId");

  http.Response response = await http.get(
    url,
    headers: {"Content-Type": "application/json"},
  );
  if (response.body.startsWith("Invalid")) return false;

  //TODO:
  List<Vertrag> returnedVertraege = [];
  List<dynamic> responseArray = jsonDecode(response.body);

  for (var vertrag in responseArray) {
    returnedVertraege.add(Vertrag(
      id: int.parse(vertrag["id"]),
      name: vertrag["name"],
      label: vertrag["label"],
      beschreibung: vertrag["description"],
      intervall: vertrag["intervall"],
      beitrag: vertrag["beitrag"],
      vertragsBeginn: vertrag["vertragsBeginn"],
      vertragsEnde: vertrag["vertragsEnde"],
      kuendigungsfrist: vertrag["kuendigungsfrist"],
      erstZahlung: vertrag["erstZahlung"],
    ));
  }
  updateHiveAllVertraege(returnedVertraege);
  return true;
}

Future<Profile> getProfilFromPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final rawJson = prefs.getString('profile');
  Map<String, dynamic> map = jsonDecode(rawJson!);
  final user = Profile(
    email: map['email'],
    password: map['password'],
    accessToken: map['accessToken'],
    refreshToken: map['refreshToken'],
  );
  return user;
}

Uri getUrl(String apiEndpoint) {
  return Platform.isAndroid
      ? Uri.parse('http://10.0.2.2:8080/api/${apiEndpoint}')
      : Uri.parse('http://localhost:8080/api/${apiEndpoint}');
}

addLabel(Label label) async {
  Uri url = getUrl("labels");
  Map<String, String> body = {
    "labelName": label.name,
    "labelColor": label.colorValue.toString(),
  };
  String body_json = jsonEncode(body);

  http.Response response = await http.post(
    url,
    body: body_json,
    headers: {"Content-Type": "application/json"},
  );
  if (response.body.startsWith("Invalid")) return false;
  print("Label wurde an DB gesendet");
}

Future<List<Label>?> getAllLabels() async {
  Uri url = getUrl("labels");

  http.Response response = await http.get(
    url,
    headers: {"Content-Type": "application/json"},
  );
  if (response.body.startsWith("Invalid")) return null;
  List<Label> returnedLabels = [];
  List<dynamic> responseArray = jsonDecode(response.body);

  for (var label in responseArray) {
    returnedLabels.add(Label(
      name: label["labelName"],
      colorValue: int.parse(label["labelColor"]),
    ));
  }

  updateHiveAllLabels(returnedLabels);

  return returnedLabels;
}
