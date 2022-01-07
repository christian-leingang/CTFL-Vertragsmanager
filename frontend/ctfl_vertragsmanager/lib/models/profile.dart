import 'dart:io';

import 'package:ctfl_vertragsmanager/funktionen/imageUtils.dart';
import 'package:flutter/material.dart';

class Profile {
  int _id;
  int get id => this._id;

  set id(int value) => this._id = value;

  String _email;
  String get email => this._email;

  set email(String value) => this._email = value;

  String _password;
  String get password => this._password;

  set password(String value) => this._password = value;

  File _profilbild;
  File get profilbild => this._profilbild;

  set profilbild(File value) => this._profilbild = value;

  Profile({
    required email,
    password,
    profilbild,
  })  : _id = 1,
        _email = email,
        _password = password,
        _profilbild = profilbild ??
            File(
                "/data/user/0/com.example.ctfl_vertragsmanager/cache/profile.png");
}
