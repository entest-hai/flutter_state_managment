import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_provider/kilo/social_auth/social_auth_cubit.dart';
import 'package:flutter_provider/kilo/social_auth/login/social_login_view.dart';
import 'package:flutter_provider/kilo/social_auth/signup/social_signup_view.dart';
import 'package:flutter_provider/kilo/social_auth/confirm/social_confirmation_view.dart';

class AuthNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state){
      return Navigator(
        pages: [
          // Show login 
          if (state == AuthState.login) MaterialPage(child: LoginView()),

          // Allow push animation 
          if (state == AuthState.signUp || state == AuthState.confirmSignUp) ...[
            
            // Show sign up 
            MaterialPage(
              child: SignUpView()
            ),

            // Show confirm sign up 
            if (state == AuthState.confirmSignUp) 
              MaterialPage(
                child: ConfirmationView()
              )
          ]
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}