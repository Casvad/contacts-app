import 'package:equatable/equatable.dart';

class ContactEntity extends Equatable {
  final int? id;
  final String? email;
  final String? name;
  final String? phone;
  final String? prefixPhone;

  ContactEntity(
      {this.id, this.email, this.name, this.phone, this.prefixPhone});

  @override
  List<Object?> get props => [id, email, name, phone, prefixPhone];
}
