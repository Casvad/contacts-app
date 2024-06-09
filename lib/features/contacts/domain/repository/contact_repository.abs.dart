import 'package:contacts_app/core/resources/data_state.dart';
import 'package:contacts_app/features/contacts/data/models/contact.dart';

abstract class ContactRepository {
  Future<DataState<List<ContactModel>>> findAllContacts();

  Future<DataState<ContactModel>> createContact(ContactModel contact);

  Future<DataState<ContactModel>> updateContact(ContactModel contact);

  Future<DataState<ContactModel>> findContactById(int id);

  Future<DataState<ContactModel>> deleteContact(int id);
}
