import 'package:flutter_bloc/flutter_bloc.dart';
import 'oth_auth_session_state.dart';
import 'oth_auth_repository.dart';
import 'oth_auth_auth_credential.dart';

// Session Cubit
class SessionCubit extends Cubit<SessionState> {
  final AuthRepository authRepo;

  SessionCubit({this.authRepo}) : super(UnknownSessionState()) {
    attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    try {
      final userId = await authRepo.attemptAutoLogin();
      // final user = dataRepo.getUser(userId);
      final user = AuthCredentials(username: "HaiTran", userId: userId, email: "hai@bio-rithm.com");
      emit(Authenticated(user: user));
    } on Exception {
      emit(Unauthenticated());
    }
  }

  void showAuth() => emit(Unauthenticated());

  void showSession(AuthCredentials credentials) {
    // final user = dataRepo.getUser(credentials.userId);
    print("launch sessions username: ${credentials.username} token: ${credentials.userId}");
    credentials.userId = credentials.userId.toString();
    emit(Authenticated(user: credentials));
  }

  void signOut() {
    authRepo.signOut();
    emit(Unauthenticated());
  }
}