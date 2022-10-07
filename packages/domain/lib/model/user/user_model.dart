class UserModel {
  final String email;
  final String password;

  UserModel(
    this.email,
    this.password,
  );

  factory UserModel.fromJson(
      Map<String, dynamic> json,
      ) =>
      UserModel(
        json['email'],
        json['password'],
      );

  factory UserModel.fromFacebookJson(
      Map<String, dynamic> json,
      ) =>
      UserModel(
        json['email'],
        json['id'],
      );

  Map<String, dynamic> toJson() => <String, String>{
        'email': email,
        'password': password,
      };
}
