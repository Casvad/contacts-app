import 'package:contacts_app/core/resources/data_state.dart';
import 'package:contacts_app/core/usecases/usecase.dart';
import 'package:contacts_app/features/contacts/data/models/contact.dart';
import 'package:contacts_app/features/contacts/domain/repository/contact_repository.abs.dart';

class UpdateContactUseCase implements UseCase<DataState<ContactModel>, ContactModel> {
  final ContactRepository _contactRepository;

  UpdateContactUseCase(this._contactRepository);

  @override
  Future<DataState<ContactModel>> call({required ContactModel params}) async {
    return await _contactRepository.updateContact(params);
  }
}
