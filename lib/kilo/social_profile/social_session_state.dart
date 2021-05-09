import 'package:flutter_provider/oth/oth_auth_session_state.dart';

import 'social_user_model.dart';
import 'package:flutter/foundation.dart';

abstract class SessionState {}

class UnknownSessionState extends SessionState {}

class Unauthenticated extends SessionState {}

class Authenticated extends SessionState {
  final User user;
  User selectedUser;
  Authenticated({@required this.user});
}