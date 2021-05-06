import 'package:flutter_bloc/flutter_bloc.dart';
import 'oth_auth_session_cubit.dart';
import 'oth_auth_auth_state.dart';
import 'oth_auth_auth_credential.dart';

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit sessionCubit;

  AuthCubit({this.sessionCubit}) : super(AuthState.login);

  AuthCredentials credentials;

  void showLogin() => emit(AuthState.login);

  void showSignUp() => emit(AuthState.signUp);

  void showConfirmSignUp({
    String username,
    String email,
    String password,
  }) {
    credentials = AuthCredentials(
      username: username,
      email: email,
      password: password,
    );
    emit(AuthState.confirmSignUp);
  }

  void launchSession(AuthCredentials credentials) {
      sessionCubit.showSession(credentials);
  }
     
}