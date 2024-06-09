import 'package:contacts_app/features/contacts/domain/entities/contact.dart';

class ContactModel extends ContactEntity {
  ContactModel(
      {int? id,
      String? email,
      String? name,
      String? phone,
      String? prefixPhone})
      : super(
            id: id,
            email: email,
            name: name,
            phone: phone,
            prefixPhone: prefixPhone);

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json["id"] ?? 0,
      email: json["email"] ?? "",
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      prefixPhone: json["prefix_phone"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'prefix_phone': prefixPhone,
    };
  }

  ContactModel copyWith({
    int? id,
    String? email,
    String? name,
    String? phone,
    String? prefixPhone,
  }) =>
      ContactModel(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        prefixPhone: prefixPhone ?? this.prefixPhone,
      );
}
