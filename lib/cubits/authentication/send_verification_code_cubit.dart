import 'package:personal_security_officer/app/general_imports.dart';


abstract class SendVerificationCodeState {}

class SendVerificationCodeInitialState extends SendVerificationCodeState {}

class SendVerificationCodeInProgressState extends SendVerificationCodeState {}

class SendVerificationCodeSuccessState extends SendVerificationCodeState {
  final String phoneNumber;
  final String userAuthenticationCode;
  final String authenticationType;

  SendVerificationCodeSuccessState(
      {required this.phoneNumber,
      required this.userAuthenticationCode,
      required this.authenticationType});
}

class SendVerificationCodeFailureState extends SendVerificationCodeState {
  SendVerificationCodeFailureState(this.error);

  final dynamic error;
}

class SendVerificationCodeCubit extends Cubit<SendVerificationCodeState> {
  SendVerificationCodeCubit() : super(SendVerificationCodeInitialState());
  final AuthenticationRepository authRepo = AuthenticationRepository();

  void setInitialState() {
    if (state is SendVerificationCodeSuccessState) {
      emit(SendVerificationCodeInitialState());
    }
  }
}
