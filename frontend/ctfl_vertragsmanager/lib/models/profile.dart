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

  Profile({
    email,
    password,
  })  : _id = 1,
        _email = email,
        _password = password;
}
