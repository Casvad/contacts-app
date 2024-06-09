import 'package:contacts_app/core/resources/data_state.dart';
import 'package:contacts_app/core/usecases/usecase.dart';
import 'package:contacts_app/features/contacts/data/models/contact.dart';
import 'package:contacts_app/features/contacts/domain/repository/contact_repository.abs.dart';

class CreateContactUseCase implements UseCase<DataState<ContactModel>, ContactModel> {
  final ContactRepository _contactRepository;

  CreateContactUseCase(this._contactRepository);

  @override
  Future<DataState<ContactModel>> call({required ContactModel params}) async {

    return await _contactRepository.createContact(params);
  }
}
