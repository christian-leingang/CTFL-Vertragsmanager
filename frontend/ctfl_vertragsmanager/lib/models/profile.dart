class Profile {
  String? _id;
  String? get id => this._id;

  set id(String? value) => this._id = value;

  String _email;
  String get email => this._email;

  set email(String value) => this._email = value;

  String _password;
  String get password => this._password;

  set password(String value) => this._password = value;

  String _accessToken;
  String get accessToken => this._accessToken;

  set accessToken(String value) => this._accessToken = value;

  String _refreshToken;
  String get refreshToken => this._refreshToken;

  set refreshToken(String value) => this._refreshToken = value;

  Profile({
    required email,
    id,
    password,
    accessToken,
    refreshToken,
  })  : _id = id,
        _email = email,
        _password = password,
        _accessToken = accessToken ?? "",
        _refreshToken = refreshToken ?? "";
}
