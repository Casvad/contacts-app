import 'package:contacts_app/core/resources/data_state.dart';
import 'package:contacts_app/core/usecases/usecase.dart';
import 'package:contacts_app/features/auth/data/models/user.dart';
import 'package:contacts_app/features/auth/domain/repository/user_repository.abs.dart';

import '../../data/models/session.dart';

class LoginUseCase implements UseCase<DataState<SessionModel>, UserModel> {
  final UserRepository _userRepository;

  LoginUseCase(this._userRepository);

  @override
  Future<DataState<SessionModel>> call({required UserModel params}) {
    return _userRepository.login(
        email: params.email ?? "", password: params.password ?? "");
  }
}
