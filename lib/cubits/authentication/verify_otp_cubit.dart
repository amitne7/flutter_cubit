// ignore_for_file: file_names



import 'package:personal_security_officer/app/general_imports.dart';

abstract class VerifyOtpState {}

class VerifyOtpInitial extends VerifyOtpState {}

class VerifyOtpInProcess extends VerifyOtpState {}

class VerifyOtpSuccess extends VerifyOtpState {
  VerifyOtpSuccess(
      {this.signinCredential, this.message, required this.authenticationType});

  final String? message;
  final String authenticationType;
  UserCredential? signinCredential;
}

class VerifyOtpFail extends VerifyOtpState {
  VerifyOtpFail(this.error);

  final dynamic error;
}

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit() : super(VerifyOtpInitial());
  final AuthenticationRepository authRepo = AuthenticationRepository();

  Future<void> verifyOtp({
    required String otp,
    required String authenticationType,
    required String countryCode,
    required String mobileNumber,
  }) async {
    try {
      emit(VerifyOtpInProcess());
      if (authenticationType == "sms_gateway") {
        final Map<String, dynamic> response =
            await authRepo.verifyOTPUsingSMSGateway(
          otp: otp,
          mobileNumber: mobileNumber,
          countryCode: countryCode,
        );
        if (response["error"]) {
          emit(VerifyOtpFail(response["message"]));
        } else {
          emit(VerifyOtpSuccess(
            authenticationType: authenticationType,
            message: response["message"],
          ));
        }
      } 
    } catch (e) {
      emit(VerifyOtpFail(e));
    }
  }

  void setInitialState() {
    if (state is VerifyOtpFail) {
      emit(VerifyOtpInitial());
    }
    if (state is VerifyOtpSuccess) {
      emit(VerifyOtpInitial());
    }
  }
}
