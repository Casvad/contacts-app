import 'dart:convert';

import 'package:contacts_app/features/auth/data/data_sources/local/host.dart';
import 'package:contacts_app/features/auth/domain/repository/user_repository.abs.dart';
import 'package:contacts_app/features/settings/presentation/cubit/host_cubit.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../../../core/resources/data_state.dart';
import '../models/session.dart';
import '../models/user.dart';

class UserRepositoryImpl implements UserRepository {
  final HostStorage _hostStorage;

  UserRepositoryImpl(this._hostStorage);

  @override
  Future<DataState<SessionModel>> login(
      {required String email, required String password}) async {
    final response = await http.post(
      Uri.parse("${await _hostStorage.getHost()}/api/contacts/users/login"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final sessionJson = jsonDecode(response.body);
      return DataSuccess(SessionModel.fromJson(sessionJson));
    } else {
      return DataFailed(
          DioException(error: response.body, requestOptions: RequestOptions())
      );
    }
  }

  @override
  Future<DataState<UserModel>> register({required UserModel user}) async {
    final response = await http.post(
      Uri.parse("${await _hostStorage.getHost()}/api/contacts/users/register"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toMap()),
    );

    if (response.statusCode == 200) {
      final sessionJson = jsonDecode(response.body);
      return DataSuccess(UserModel.fromJson(sessionJson));
    } else {

      return DataFailed(
          DioException(error: response.body, requestOptions: RequestOptions())
      );
    }
  }
}
