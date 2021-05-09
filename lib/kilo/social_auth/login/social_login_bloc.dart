import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_provider/kilo/social_auth/social_auth_repository.dart';
import 'package:flutter_provider/kilo/social_auth/social_auth_cubit.dart';
import 'package:flutter_provider/kilo/social_auth/social_auth_submission_status.dart';
import 'package:flutter_provider/kilo/social_auth/social_auth_credentials.dart';
import 'social_login_state.dart';
import 'social_login_event.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AuthRepository authRepo;
  final AuthCubit authCubit;

  LoginBloc({this.authRepo, this.authCubit}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // Username updated 
    if (event is LoginUsernameChanged) {
      yield state.copyWith(
        username: event.username
      );
      // Password updated 
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(
        password: event.password
      );
      // Form submitted 
    } else if (event is LoginSubmitted) {
      try {
        
        final userId = await authRepo.login(
          username: state.username,
          password: state.password);

        yield state.copyWith(formStatus: SubmissionSuccess());
        
        authCubit.launchSession(AuthCredentials(
          username: state.username,
          userId: userId
        )) ;
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(exception: e));
      }
    } 
  }
}