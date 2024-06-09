import 'package:contacts_app/features/auth/domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({String? email, String? name, String? password})
      : super(email: email, name: name, password: password);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json["email"] ?? "",
        name: json["name"] ?? "",
        password: json["password"] ?? "");
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'password': password,
    };
  }
}
