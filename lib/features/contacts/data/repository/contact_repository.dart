import 'dart:convert';

import 'package:contacts_app/features/auth/data/data_sources/local/host.dart';
import 'package:contacts_app/features/contacts/data/models/contact.dart';
import 'package:contacts_app/features/contacts/domain/repository/contact_repository.abs.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../../../core/resources/data_state.dart';
import '../../../auth/data/data_sources/local/session.dart';

class ContactRepositoryImpl implements ContactRepository {
  final HostStorage _hostStorage;
  final SessionStorage _sessionStorage;

  ContactRepositoryImpl(this._hostStorage, this._sessionStorage);

  @override
  Future<DataState<ContactModel>> createContact(ContactModel contact) async {
    final reqBody = jsonEncode(contact.toMap());
    final response = await http.post(
      Uri.parse("${await _hostStorage.getHost()}/api/contacts/contacts/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': _sessionStorage.getAccessToken(),
      },
      body: reqBody,
    );

    if (response.statusCode == 200) {
      final contactResponse = jsonDecode(response.body);
      return DataSuccess(ContactModel.fromJson(contactResponse));
    } else {
      return DataFailed(
          DioException(error: response.body, requestOptions: RequestOptions()));
    }
  }

  @override
  Future<DataState<ContactModel>> deleteContact(int id) async {
    final response = await http.delete(
        Uri.parse("${await _hostStorage.getHost()}/api/contacts/contacts/$id"),
        headers: {
          'Authorization': _sessionStorage.getAccessToken(),
        });

    if (response.statusCode == 200) {
      final contactResponse = jsonDecode(response.body);
      return DataSuccess(ContactModel.fromJson(contactResponse));
    } else {
      return DataFailed(
          DioException(error: response.body, requestOptions: RequestOptions()));
    }
  }

  @override
  Future<DataState<List<ContactModel>>> findAllContacts() async {
    final response = await http.get(
        Uri.parse("${await _hostStorage.getHost()}/api/contacts/contacts/"),
        headers: {
          'Authorization': _sessionStorage.getAccessToken(),
        });

    if (response.statusCode == 200) {
      List<dynamic> contactResponse = jsonDecode(response.body);

      return DataSuccess(
          contactResponse.map((json) => ContactModel.fromJson(json)).toList());
    } else {
      return DataFailed(
          DioException(error: response.body, requestOptions: RequestOptions()));
    }
  }

  @override
  Future<DataState<ContactModel>> findContactById(int id) async {
    final response = await http.get(
        Uri.parse("${await _hostStorage.getHost()}/api/contacts/contacts/$id"),
        headers: {
          'Authorization': _sessionStorage.getAccessToken(),
        });

    if (response.statusCode == 200) {
      final contactResponse = jsonDecode(response.body);
      return DataSuccess(ContactModel.fromJson(contactResponse));
    } else {
      return DataFailed(
          DioException(error: response.body, requestOptions: RequestOptions()));
    }
  }

  @override
  Future<DataState<ContactModel>> updateContact(ContactModel contact) async {
    final response = await http.put(
      Uri.parse(
          "${await _hostStorage.getHost()}/api/contacts/contacts/${contact.id}"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': _sessionStorage.getAccessToken(),
      },
      body: jsonEncode(contact.toMap()),
    );

    if (response.statusCode == 200) {
      final contactResponse = jsonDecode(response.body);
      return DataSuccess(ContactModel.fromJson(contactResponse));
    } else {
      return DataFailed(
          DioException(error: response.body, requestOptions: RequestOptions()));
    }
  }
}
