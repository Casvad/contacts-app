import 'package:contacts_app/features/contacts/data/models/contact.dart';
import 'package:equatable/equatable.dart';

abstract class ContactAllState extends Equatable {
  final List<ContactModel>? contacts;
  final ContactModel? contact;

  const ContactAllState({this.contacts, this.contact});

  @override
  List<Object> get props => [contacts ?? "", contact ?? ""];
}

class LoadingContactAllState extends ContactAllState {
  const LoadingContactAllState() : super();
}

class LoadedContactAllState extends ContactAllState {
  const LoadedContactAllState(List<ContactModel> contacts)
      : super(contacts: contacts);
}

class ContactLoaded extends ContactAllState {
  const ContactLoaded(ContactModel contact) : super(contact: contact);
}
