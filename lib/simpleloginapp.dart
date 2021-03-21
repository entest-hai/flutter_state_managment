import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleLoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => AuthCubit(),
        child: AuthNavigator(),
      ),
    );
  }
}

class AuthNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Navigator(
        pages: [
          // Show login
          if (state == AuthState.login) MaterialPage(child: SimpleLoginView()),

          // Allow push animation
          if (state == AuthState.signUp ||
              state == AuthState.confirmSingUp) ...[
            // Show sign up
            MaterialPage(child: SignupView()),

            // Show confirm sign up
            if (state == AuthState.confirmSingUp)
              MaterialPage(child: ConfirmationView())
          ]
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}

class ConfirmationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Confirmation View"),
      ),
    );
  }
}

class SignupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _signUpForm(),
          _showLoginButton(context),
        ],
      ),
    );
  }

  Widget _signUpForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _userNameField(),
          _passwordField(),
          _signUpButton(),
        ],
      ),
    );
  }

  Widget _showLoginButton(BuildContext context) {
    return SafeArea(
        child: TextButton(
      onPressed: () {
        context.read<AuthCubit>().showLogin();
      },
      child: Text("Back to log in view"),
    ));
  }

  Widget _signUpButton() {
    return ElevatedButton(onPressed: () {}, child: Text("SignUp"));
  }

  Widget _userNameField() {
    return TextFormField(
      onChanged: (value) {},
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        hintText: "Username",
      ),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(Icons.security),
        hintText: "Passowrd",
      ),
    );
  }
}

class SimpleLoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("login"),
      ),
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [_loginForm(), _showSignupButton(context)],
          ),
        ),
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_userNameField(), _passwordField(), _loginButton()],
          ),
        ),
      ),
    );
  }

  Widget _showSignupButton(BuildContext context) {
    return SafeArea(
        child: TextButton(
      onPressed: () {
        context.read<AuthCubit>().showSignUp();
      },
      child: Text("Don't have an account, please sign up"),
    ));
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                context.read<LoginBloc>().add(LoginSumitted());
              },
              child: Text("Login"));
    });
  }

  Widget _userNameField() {
    return TextFormField(
      onChanged: (value) {},
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        hintText: "Username",
      ),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(Icons.security),
        hintText: "Passowrd",
      ),
    );
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

class LoginSumitted extends LoginEvent {}

// Login State
abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class SubmissionSuccess extends FormSubmissionStatus {}

class SubmissionFailed extends FormSubmissionStatus {
  final Exception exception;
  SubmissionFailed({this.exception});
}

class LoginState {
  final String username;
  final String password;
  final FormSubmissionStatus formStatus;
  LoginState({
    this.username,
    this.password,
    this.formStatus,
  });

  LoginState copyWith({
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

// Auth Repository
class AuthRepository {
  Future<String> login() async {
    await Future.delayed(Duration(seconds: 3));
    print("loged in ok");
    throw Exception("Account not existed yet, please sign up");
  }
}

// Login Bloc
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _authRepository = AuthRepository();
  LoginBloc() : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // Username changed
    if (event is LoginUsernameChanged) {
      yield state.copyWith(username: event.username);
    }
    // Password changed
    else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);
    }

    // Form submitted
    else if (event is LoginSumitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final userId = await _authRepository.login();
        yield state.copyWith(formStatus: SubmissionSuccess());
        print(userId);
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(exception: e));
        print(e);
      }
    }
  }
}

// Add SignUp Bloc

// Auth Cubit
enum AuthState { login, signUp, confirmSingUp }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.login);

  void showLogin() => emit(AuthState.login);

  void showSignUp() => emit(AuthState.signUp);
}
