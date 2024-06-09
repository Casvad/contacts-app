import 'package:contacts_app/core/resources/data_state.dart';
import 'package:contacts_app/core/usecases/usecase.dart';
import 'package:contacts_app/features/contacts/data/models/contact.dart';
import 'package:contacts_app/features/contacts/domain/repository/contact_repository.abs.dart';

class FindAllContactUseCase
    implements UseCase<DataState<List<ContactModel>>, void> {
  final ContactRepository _contactRepository;

  FindAllContactUseCase(this._contactRepository);

  @override
  Future<DataState<List<ContactModel>>> call({void params}) async {
    return await _contactRepository.findAllContacts();
  }
}
