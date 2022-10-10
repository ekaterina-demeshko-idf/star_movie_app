class UserFacebookModel {
  final String email;
  final String id;

  UserFacebookModel(
      this.email,
      this.id,
      );

  factory UserFacebookModel.fromJson(
      Map<String, dynamic> json,
      ) =>
      UserFacebookModel(
        json['email'],
        json['id'],
      );

}
