import 'package:contacts_app/features/auth/domain/entities/session.dart';

class SessionModel extends SessionEntity {
  const SessionModel({String? email, String? authToken})
      : super(email: email, authToken: authToken);

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
        email: json["email"] ?? "", authToken: json["token"] ?? "");
  }

  Map<String, dynamic> toMap() {
    return {'email': email, 'token': authToken};
  }

  SessionModel copyWith({
    String? email,
    String? authToken,
  }) =>
      SessionModel(
        email: email ?? this.email,
        authToken: authToken ?? this.authToken,
      );
}
