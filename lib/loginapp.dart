import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginAppBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider(
        create: (context) => AuthRepository(),
        child: LoginView(),
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: BlocProvider(
        create: (context) =>
            LoginBloc(authRepo: context.read<AuthRepository>()),
        child: _loginForm(),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _userNameField(),
              _passwordFiled(),
              _loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  context.read<LoginBloc>().add(LoginSubmitted());
                }
              },
              child: Text("Login"));
    });
  }

  Widget _userNameField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        validator: (value) =>
            state.isValidUsername ? null : "User name is too short",
        onChanged: (value) {
          print(value);
          context.read<LoginBloc>().add(LoginUsernameChanged(username: value));
        },
        decoration: InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Username',
        ),
      );
    });
  }

  Widget _passwordFiled() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        validator: (value) =>
            state.isValidPassword ? null : "Password it too short",
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginPasswordChanged(password: value)),
        obscureText: true,
        decoration:
            InputDecoration(icon: Icon(Icons.security), hintText: 'Password'),
      );
    });
  }
}

// Login Event
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

// Login State
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

  LoginState copyWidth({
    String username,
    String password,
    FormSubmissionStatus formStatus,
  }) {
    return LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus);
  }
}

// Form Submission State
abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class SubmissionSuccess extends FormSubmissionStatus {}

class SubmissionFailed extends FormSubmissionStatus {
  final Exception exception;
  SubmissionFailed({this.exception});
}

// Auth Repository
class AuthRepository {
  Future<void> login() async {
    print("attempting to login ");
    await Future.delayed(Duration(seconds: 3));
    print("logged in ");
    throw Exception("failed log in ");
  }
}

// Login Bloc
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  LoginBloc({this.authRepo}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // Username updated
    if (event is LoginUsernameChanged) {
      yield state.copyWidth(username: event.username);

      // Password updated
    } else if (event is LoginPasswordChanged) {
      yield state.copyWidth(password: event.password);

      // Form submitted
    } else if (event is LoginSubmitted) {
      yield state.copyWidth(formStatus: FormSubmitting());

      try {
        await authRepo.login();
        yield state.copyWidth(formStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWidth(formStatus: SubmissionFailed());
      }
    }
  }
}
