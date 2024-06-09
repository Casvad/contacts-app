import 'dart:convert';

import 'package:contacts_app/features/auth/data/models/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SessionStorage {
  String getAccessToken();

  Future<SessionModel?> getSession();

  Future<void> setSession(SessionModel session);

  Future<void> clearSession();
}

class SessionStorageImpl extends SessionStorage {
  static const sessionConst = 'session';
  SessionModel? _sessionCache;

  @override
  Future<void> clearSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(sessionConst);
    _sessionCache = null;
  }

  @override
  String getAccessToken() {
    return "Bearer ${_sessionCache?.authToken}";
  }

  @override
  Future<SessionModel?> getSession() async {
    if (_sessionCache != null) {
      return _sessionCache;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final sessionJson = prefs.getString(sessionConst);
    if (sessionJson != null) {
      final session = SessionModel.fromJson(jsonDecode(sessionJson));

      _sessionCache = session;
      return session;
    }

    return null;
  }

  @override
  Future<void> setSession(SessionModel session) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(sessionConst, jsonEncode(session.toMap()));
    _sessionCache = session;
  }
}
