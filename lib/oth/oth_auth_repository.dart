import 'package:flutter/material.dart';
import 'oth_api_service.dart';

class AuthRepository {
  final _dataservice = DataServie();
  Future<String> attemptAutoLogin() async {
    await Future.delayed(Duration(seconds: 1));
    throw Exception('not signed in');
  }

  Future<String> loginOth({
    @required String username,
    @required String password,
  }) async {
    print('try getting token from OTH');
    final token = _dataservice.getOthToken();
    return token;
  }

  Future<String> login({
    @required String username,
    @required String password,
  }) async {
    print('attempting login: $username and $password');
    await Future.delayed(Duration(seconds: 3));
    return username;
  }

  Future<void> signUp({
    @required String username,
    @required String email,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 2));
  }

  Future<String> confirmSignUp({
    @required String username,
    @required String confirmationCode,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    return 'abc';
  }

  Future<void> signOut() async {
    await Future.delayed(Duration(seconds: 2));
  }
}