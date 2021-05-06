import 'package:flutter_bloc/flutter_bloc.dart';
import 'oth_auth_repository.dart';
import 'oth_auth_auth_cubit.dart';
import 'oth_auth_form_state.dart';
import 'oth_auth_confirmation_state.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  ConfirmationBloc({
    this.authRepo,
    this.authCubit,
  }) : super(ConfirmationState());

  @override
  Stream<ConfirmationState> mapEventToState(ConfirmationEvent event) async* {
    // Confirmation code updated
    if (event is ConfirmationCodeChanged) {
      yield state.copyWith(code: event.code);

      // Form submitted
    } else if (event is ConfirmationSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final userId = await authRepo.confirmSignUp(
          username: authCubit.credentials.username,
          confirmationCode: state.code,
        );
        print(userId);
        yield state.copyWith(formStatus: SubmissionSuccess());

        final credentials = authCubit.credentials;
        credentials.userId = userId;
        print(credentials);
        authCubit.launchSession(credentials);
      } catch (e) {
        print(e);
        yield state.copyWith(formStatus: SubmissionFailed());
      }
    }
  }
}