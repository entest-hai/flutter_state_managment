import 'package:flutter_bloc/flutter_bloc.dart';
import 'social_confirmation_event.dart';
import 'social_confirmation_state.dart';
import 'package:flutter_provider/kilo/social_auth/social_auth_submission_status.dart';
import 'package:flutter_provider/kilo/social_auth/social_auth_cubit.dart';
import 'package:flutter_provider/kilo/social_auth/social_auth_repository.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  ConfirmationBloc({
    this.authRepo, 
    this.authCubit,
  }) : super(ConfirmationState());

  @override
  Stream<ConfirmationState> mapEventToState(ConfirmationEvent event) async* {
    // Configuration code updated 
    if (event is ConfirmationCodeChanged) {
      yield state.copyWith(code: event.code);
    }
    
    // Form submitted 
    else if (event is ConfirmationSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());
    } 

    try {
        final userId = await authRepo.confirmSignUp(
          username: authCubit.credentials.username,
          confirmationCode: state.code,);

        print(userId);

        yield state.copyWith(
          formStatus: SubmissionSuccess()
        );

        final credentials = authCubit.credentials;
        credentials.userId = userId;
        print(credentials);
        authCubit.launchSession(credentials);

    } catch (e) {
      print(e);
      yield state.copyWith(formStatus: SubmissionFailed(
        exception: e
      ));
    }

    ;
  }
}
