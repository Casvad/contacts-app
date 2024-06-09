import 'package:contacts_app/core/resources/data_state.dart';
import 'package:contacts_app/core/usecases/usecase.dart';
import 'package:contacts_app/features/auth/data/models/user.dart';
import 'package:contacts_app/features/auth/domain/entities/session.dart';
import 'package:contacts_app/features/auth/domain/repository/user_repository.abs.dart';

class RegisterUseCase implements UseCase<DataState<UserModel>, UserModel> {
  final UserRepository _userRepository;

  RegisterUseCase(this._userRepository);

  @override
  Future<DataState<UserModel>> call({required UserModel params}) {
    return _userRepository.register(user: params);
  }
}
