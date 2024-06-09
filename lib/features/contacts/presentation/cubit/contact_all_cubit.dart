import 'package:contacts_app/core/resources/data_state.dart';
import 'package:contacts_app/features/contacts/data/models/contact.dart';
import 'package:contacts_app/features/contacts/domain/usecases/find_all.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/create.dart';
import '../../domain/usecases/delete.dart';
import '../../domain/usecases/find.dart';
import '../../domain/usecases/update.dart';
import 'contact_all_state.dart';

class ContactAllCubit extends Cubit<ContactAllState> {
  final FindAllContactUseCase _findAllContactUseCase;
  final DeleteContactUseCase _deleteContactUseCase;
  final UpdateContactUseCase _updateContactUseCase;
  final CreateContactUseCase _createContactUseCase;
  final FindContactByIdUseCase _findContactByIdUseCase;

  ContactAllCubit(this._findAllContactUseCase, this._deleteContactUseCase,
      this._updateContactUseCase, this._createContactUseCase, this._findContactByIdUseCase)
      : super(const LoadingContactAllState());

  Future<void> loadAllContacts() async {
    emit(const LoadingContactAllState());
    final contactsResponse = await _findAllContactUseCase();

    if (contactsResponse is DataSuccess) {
      emit(LoadedContactAllState(contactsResponse.data ?? []));
    } else {
      print("Could not load contacts: ${contactsResponse.error?.error}");
      //TODO handle error
    }
  }

  Future<void> deleteContact(int id) async {
    await _deleteContactUseCase(params: id);
    await loadAllContacts();
  }

  Future<void> updateContact(ContactModel contact) async {
    await _updateContactUseCase(params: contact);
    await loadAllContacts();
  }

  Future<void> createContact(ContactModel contact) async {
    final response = await _createContactUseCase(params: contact);

    if (response is DataSuccess){
      await loadAllContacts();
    } else {
      print("Could not create contact: ${response.error?.error}");
      //TODO handle error
    }
  }

  Future<void> findContactById(int id) async {
    final modelResponse = await _findContactByIdUseCase(params: id);

    if (modelResponse is DataSuccess) {
      emit(ContactLoaded(modelResponse.data!));
    }
  }
}
