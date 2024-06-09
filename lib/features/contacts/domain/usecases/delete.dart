import 'package:contacts_app/core/resources/data_state.dart';
import 'package:contacts_app/core/usecases/usecase.dart';
import 'package:contacts_app/features/contacts/data/models/contact.dart';
import 'package:contacts_app/features/contacts/domain/repository/contact_repository.abs.dart';

class DeleteContactUseCase implements UseCase<DataState<ContactModel>, int> {
  final ContactRepository _contactRepository;

  DeleteContactUseCase(this._contactRepository);

  @override
  Future<DataState<ContactModel>> call({required int params}) async {
    return await _contactRepository.deleteContact(params);
  }
}
