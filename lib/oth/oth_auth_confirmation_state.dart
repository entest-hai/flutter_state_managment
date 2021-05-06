import 'oth_auth_form_state.dart';

abstract class ConfirmationEvent {}

class ConfirmationCodeChanged extends ConfirmationEvent {
  final String code;

  ConfirmationCodeChanged({this.code});
}

class ConfirmationSubmitted extends ConfirmationEvent {}

// Confirmation State
class ConfirmationState {
  final String code;
  bool get isValidCode => code.length == 6;

  final FormSubmissionStatus formStatus;

  ConfirmationState({
    this.code = '',
    this.formStatus = const InitialFormStatus(),
  });

  ConfirmationState copyWith({
    String code,
    FormSubmissionStatus formStatus,
  }) {
    return ConfirmationState(
      code: code ?? this.code,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}