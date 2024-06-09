import 'package:equatable/equatable.dart';

class SessionEntity extends Equatable {
  final String? email;
  final String? authToken;

  const SessionEntity({this.email, this.authToken});

  @override
  List<Object?> get props => [email, authToken];

}
