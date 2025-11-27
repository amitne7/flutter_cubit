// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:personal_security_officer/app/general_imports.dart';

abstract class LogoutState {}

class LogoutInitial extends LogoutState {}

class LogoutInProgress extends LogoutState {}

class LogoutSuccess extends LogoutState {
  final String error;
  final String message;

  LogoutSuccess({
    required this.error,
    required this.message,
  });
}

class LogoutFailure extends LogoutState {
  final String errorMessage;

  LogoutFailure(this.errorMessage);
}

class LogoutCubit extends Cubit<LogoutState> {
  final UserRepository _userRepository = UserRepository();

  LogoutCubit() : super(LogoutInitial());

  Future<void> logoutUser({
    final String? fcmID,
    required final String platform,
  }) async {
    try {
      emit(LogoutInProgress());
      final response =
      await _userRepository.logout(fcmId: fcmID, platform: platform);
      emit(
        LogoutSuccess(
          message: response['message'],
          error: response['error'].toString(),
        ),
      );
    } catch (e) {
      emit(LogoutFailure(e.toString()));
    }
  }
}
