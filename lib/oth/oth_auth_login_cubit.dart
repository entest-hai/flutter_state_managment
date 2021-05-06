import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'oth_auth_login_state.dart';
import 'oth_auth_repository.dart';
import 'oth_auth_auth_cubit.dart';
import 'oth_auth_form_state.dart';
import 'oth_auth_auth_credential.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  LoginBloc({this.authRepo, this.authCubit}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // Username updated
    if (event is LoginUsernameChanged) {
      yield state.copyWith(username: event.username);

      // Password updated
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);

      // Form submitted
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
      try {
        final userId = await authRepo.login(
          username: state.username,
          password: state.password,
        );
        yield state.copyWith(formStatus: SubmissionSuccess());

        print("lanuch session view ");
        authCubit.launchSession(AuthCredentials(
          username: state.username,
          userId: userId,
          email: "hai@bio-rithm.com",
          password: state.password,
        ));
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(exception: e));
      }
    }
  }
}
