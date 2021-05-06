import 'package:flutter_bloc/flutter_bloc.dart';
import 'oth_auth_signup_state.dart';
import 'oth_auth_repository.dart';
import 'oth_auth_auth_cubit.dart';
import 'oth_auth_form_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  SignUpBloc({this.authRepo, this.authCubit}) : super(SignUpState());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    // Username updated
    if (event is SignUpUsernameChanged) {
      yield state.copyWith(username: event.username);

      // Email updated
    } else if (event is SignUpEmailChanged) {
      yield state.copyWith(email: event.email);

      // Password updated
    } else if (event is SignUpPasswordChanged) {
      yield state.copyWith(password: event.password);

      // Form submitted
    } else if (event is SignUpSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        await authRepo.signUp(
          username: state.username,
          email: state.email,
          password: state.password,
        );
        yield state.copyWith(formStatus: SubmissionSuccess());

        authCubit.showConfirmSignUp(
          username: state.username,
          email: state.email,
          password: state.password,
        );
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed(exception: e));
      }
    }
  }
}