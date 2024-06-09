import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? email;
  final String? name;
  final String? password;

  const UserEntity({this.email, this.name, this.password});

  @override
  List<Object?> get props => [email, name, password];
}
