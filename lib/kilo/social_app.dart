import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_provider/kilo/social_auth/social_auth_repository.dart';
import 'package:flutter_provider/kilo/social_auth/social_session_cubit.dart';
import 'package:flutter_provider/kilo/social_auth/social_navigator.dart';
import 'package:flutter_provider/kilo/social_profile/social_user_profile_view.dart';

class KiloScialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: RepositoryProvider(
       create: (context) => AuthRepository(),
       child: BlocProvider(
         create: (context) => SessionCubit(authRepo: context.read<AuthRepository>()),
         child: UserProfileView(),
       ),
     ),
    );
  }
}

