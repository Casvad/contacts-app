import 'package:contacts_app/features/auth/domain/entities/login.dart';

class LoginModel extends LoginEntity {
  const LoginModel({String? email, String? password})
      : super(email: email, password: password);

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        email: json["email"] ?? "", password: json["password"] ?? "");
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}
