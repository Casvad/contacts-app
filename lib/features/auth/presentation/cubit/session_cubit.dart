import 'package:contacts_app/core/resources/data_state.dart';
import 'package:contacts_app/features/auth/data/models/user.dart';
import 'package:contacts_app/features/auth/presentation/cubit/session_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_sources/local/session.dart';
import '../../data/models/session.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/register.dart';

class SessionCubit extends Cubit<SessionState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final SessionStorage _sessionStorage;

  SessionCubit(this._loginUseCase, this._registerUseCase, this._sessionStorage)
      : super(const SessionLoading());

  Future<void> setUserSession(SessionModel session) async {
    await _sessionStorage.setSession(session);
    emit(SessionLoaded(session));
  }

  Future<void> clearSession() async {
    await _sessionStorage.clearSession();
    emit(const NotLoggedSession());
  }

  Future<void> getUserSession() async {
    final session = await _sessionStorage.getSession();
    if (session != null) {
      emit(SessionLoaded(session));
    } else {
      emit(const NotLoggedSession());
    }
  }

  Future<void> getSessionFromServer(String email, String password) async {
    final model = UserModel(email: email, name: "", password: password);
    final sessionResponse = await _loginUseCase(params: model);

    if (sessionResponse is DataSuccess) {
      final session = sessionResponse.data!;
      setUserSession(session.copyWith(email: email));
    } else {
      print("Could not get session: ${sessionResponse.error?.error}");
      //TODO handle error
    }
  }

  Future<void> register(String email, String password, String name) async {
    final userResponse = await _registerUseCase(
        params: UserModel(email: email, name: name, password: password));

    if (userResponse is DataSuccess) {
      getSessionFromServer(email, password);
    } else {
      print("Could not register: ${userResponse.error?.error}");
      //TODO handle error
    }
  }
}
