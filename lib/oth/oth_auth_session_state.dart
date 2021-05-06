import 'package:flutter/material.dart';
import 'oth_auth_auth_credential.dart';

abstract class SessionState {}

class UnknownSessionState extends SessionState {}

class Unauthenticated extends SessionState {}

class Authenticated extends SessionState {
  final AuthCredentials user;

  Authenticated({@required this.user});
}
