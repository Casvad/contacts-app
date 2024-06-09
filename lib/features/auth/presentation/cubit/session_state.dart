import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/session.dart';

abstract class SessionState extends Equatable {
  final SessionModel? sessionModel;
  final DioException? error;

  const SessionState({this.sessionModel, this.error});

  @override
  List<Object> get props => [sessionModel ?? "", error ?? ""];
}

class SessionLoading extends SessionState {
  const SessionLoading();
}

class NotLoggedSession extends SessionState {
  const NotLoggedSession();
}

class SessionLoaded extends SessionState {
  const SessionLoaded(SessionModel session) : super(sessionModel: session);
}

class SessionError extends SessionState {
  const SessionError(DioException error) : super(error: error);
}
