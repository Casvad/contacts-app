import 'dart:convert';

import 'package:contacts_app/features/auth/data/models/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HostStorage {
  Future<String> getHost();

  Future<void> setHost(String host);
}

class HostStorageImpl extends HostStorage {
  static const hostConst = 'host';
  String? _hostCache;

  @override
  Future<String> getHost() async {

    if (_hostCache != null) {
      return _hostCache!;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final hostStr = prefs.getString(hostConst);
    return hostStr ?? "";
  }

  @override
  Future<void> setHost(String host) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(hostConst, host);
    _hostCache = host;
  }
}
