import 'package:flutter_provider/kilo/social_auth/social_auth_submission_status.dart';

class ConfirmationState {
  final String code;
  bool get isValidCode => code.length == 0; 

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
      formStatus: formStatus ?? this.formStatus
    );
  }
  
}