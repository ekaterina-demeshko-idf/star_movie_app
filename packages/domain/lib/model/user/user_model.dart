class UserModel {
  final String email;
  final String password;

  UserModel(
    this.email,
    this.password,
  );

  Map<String, dynamic> toJson() => <String, String>{
        'email': email,
        'password': password,
      };
}
