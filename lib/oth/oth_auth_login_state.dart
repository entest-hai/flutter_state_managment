import 'oth_auth_form_state.dart';


abstract class LoginEvent {}

class LoginUsernameChanged extends LoginEvent {
  final String username;
  LoginUsernameChanged({this.username});
}

class LoginPasswordChanged extends LoginEvent {
  final String password;
  LoginPasswordChanged({this.password});
}

class LoginSubmitted extends LoginEvent {}

// Login State with data {username, password, formStatus}
class LoginState {
  final String username;
  bool get isValidUsername => username.length > 3;

  final String password;
  bool get isValidPassword => password.length > 6;

  final FormSubmissionStatus formStatus;

  LoginState({
    this.username = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String username,
    String password,
    FormSubmissionStatus formStatus,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}