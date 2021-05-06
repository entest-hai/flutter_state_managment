import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'oth_auth_repository.dart';
import 'oth_auth_auth_cubit.dart';
import 'oth_auth_login_cubit.dart';
import 'oth_auth_login_state.dart';
import 'oth_auth_form_state.dart';


class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTH Authentication"),
      ),
      body: BlocProvider(
        create: (context) =>
            LoginBloc(authRepo: context.read<AuthRepository>(), authCubit: context.read<AuthCubit>()),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [_loginForm(), _showSignUpButton(context)],
        ),
      ),
    );
  }

  Widget _showSignUpButton(BuildContext context) {
    return SafeArea(
        child: TextButton(
      onPressed: () => context.read<AuthCubit>().showSignUp(),
      child: Text("Don't have an account, please sign up"),
    ));
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