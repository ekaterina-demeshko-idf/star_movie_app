import 'package:domain/model/user/user_facebook_model.dart';

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

  factory UserModel.fromFacebook(
    UserFacebookModel user,
  ) =>
      UserModel(
        user.email,
        user.id,
      );

  Map<String, dynamic> toJson() => <String, String>{
        'email': email,
        'password': password,
      };
}
