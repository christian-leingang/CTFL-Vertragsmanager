class Profile {
  String? id;

  String email;

  String password;

  String accessToken;

  String refreshToken;

  Profile({
    required this.email,
    required this.password,
    this.id,
    accessToken,
    refreshToken,
  })  : accessToken = accessToken ?? "",
        refreshToken = refreshToken ?? "";
}
