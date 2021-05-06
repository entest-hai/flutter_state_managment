import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'oth_auth_repository.dart';
import 'oth_auth_session_cubit.dart';
import 'oth_auth_session_state.dart';
import 'oth_auth_auth_cubit.dart';
import 'oth_auth_auth_state.dart';
import 'oth_auth_login_view.dart';
import 'oth_auth_confirmation_view.dart';
import 'oth_auth_signup_view.dart';

class OthAuthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider(
          create: (context) => AuthRepository(),
          child: BlocProvider(
            create: (context) =>
                SessionCubit(authRepo: context.read<AuthRepository>()),
            child: AppNavigator(),
          )),
    );
  }
}

// AppNavigator
class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      return Navigator(
        pages: [
          // Show loading screen
          if (state is UnknownSessionState) MaterialPage(child: LoadingView()),

          // Show auth flow
          if (state is Unauthenticated)
            MaterialPage(
              child: BlocProvider(
                create: (context) =>
                    AuthCubit(sessionCubit: context.read<SessionCubit>()),
                child: AuthNavigator(),
              ),
            ),

          // Show session flow
          if (state is Authenticated) MaterialPage(child: SessionView())
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}

// Navigator Auth
class AuthNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Navigator(
        pages: [
          // Show login
          if (state == AuthState.login) MaterialPage(child: LoginView()),

          // Allow push animation
          if (state == AuthState.signUp ||
              state == AuthState.confirmSignUp) ...[
            // Show Sign up
            MaterialPage(child: SignUpView()),

            // Show confirm sign up
            if (state == AuthState.confirmSignUp)
              MaterialPage(child: ConfirmationView())
          ]
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}

// Loading View
class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// Session View
class SessionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Session View'),
            TextButton(
              child: Text('sign out'),
              onPressed: () => BlocProvider.of<SessionCubit>(context).signOut(),
            )
          ],
        ),
      ),
    );
  }
}






