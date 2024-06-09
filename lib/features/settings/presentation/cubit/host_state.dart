import 'package:equatable/equatable.dart';

abstract class HostState extends Equatable {
  final String? host;

  const HostState({this.host});

  @override
  List<Object> get props => [host!];
}

class InitialHost extends HostState {
  const InitialHost(String host): super(host: host);
}

class PersistedHost extends HostState {
  const PersistedHost(String host): super(host: host);
}