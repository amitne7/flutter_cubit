import 'package:personal_security_officer/app/general_imports.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticatedState extends AuthenticationState {}

class UnAuthenticatedState extends AuthenticationState {}

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial()) {
    checkStatus();
  }

  void checkStatus() {
    if (HiveRepository.isUserLoggedIn) {
      emit(AuthenticatedState());
    } else {
      emit(UnAuthenticatedState());
    }
  }
}
