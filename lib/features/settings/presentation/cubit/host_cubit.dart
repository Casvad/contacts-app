import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../auth/data/data_sources/local/host.dart';
import 'host_state.dart';

class HostCubit extends Cubit<HostState> {
  final HostStorage _hostStorage;

  HostCubit(this._hostStorage)
      : super(InitialHost(dotenv.env['API_HOST'] ?? ''));

  Future<void> setHost(String host) async {
    _hostStorage.setHost(host);
    emit(PersistedHost(host));
  }

  Future<void> getHost() async {
    final host = await _hostStorage.getHost();
    if (host != "") {
      emit(PersistedHost(host));
    }
  }
}
