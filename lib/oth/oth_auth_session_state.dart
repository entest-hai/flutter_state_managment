import 'package:flutter/material.dart';

abstract class SessionState {}

class UnknownSessionState extends SessionState {}

class Unauthenticated extends SessionState {}

class Authenticated extends SessionState {
  final dynamic user;

  Authenticated({@required this.user});
}
