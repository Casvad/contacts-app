import 'package:contacts_app/core/resources/data_state.dart';

import '../../data/models/session.dart';
import '../../data/models/user.dart';

abstract class UserRepository {
  Future<DataState<SessionModel>> login({
    required String email,
    required String password,
  });

  Future<DataState<UserModel>> register({required UserModel user});
}
