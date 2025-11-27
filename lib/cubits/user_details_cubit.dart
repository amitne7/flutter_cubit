import 'package:personal_security_officer/app/general_imports.dart';

abstract class UserDetailsState {}

class UserDetailsInitial extends UserDetailsState {}

class UserDetails extends UserDetailsState {
  UserDetails(this.userDetailsModel);

  final UserModel userDetailsModel;
}

class UserDetailsCubit extends Cubit<UserDetailsState> {
  UserDetailsCubit() : super(UserDetailsInitial());
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  void setUserDetails(final UserModel details) {
    emit(UserDetails(details));
  }

  Future<void> getUserDetailsFromServer(final String? mobileNumber) async {
    try {
      final UserModel userDetailsModel =
          await _authenticationRepository.getUserDetails(mobileNumber: mobileNumber);
      //
      emit(UserDetails(userDetailsModel));
    } catch (_) {}
  }

  void loadUserDetails() {
    final Map detailsMap =
        HiveRepository.getAllValueOf(boxName: HiveRepository.userDetailBoxKey);

    final UserModel userDetailsModel =
        UserModel.fromMap(Map.from(detailsMap));
    emit(UserDetails(userDetailsModel));
  }

  void changeUserDetails(final UserModel details) {
    if (state is UserDetails) {
      final UserModel oldDetails =
          (state as UserDetails).userDetailsModel;

      final UserModel newDetails = oldDetails.copyWith(
        email: details.email,
        username: details.username,
        image: details.image,
        phone: details.phone,
        latitude: details.latitude,
        longitude: details.longitude,
        countryCode: details.countryCode,
        countryCodeName: details.countryCodeName,
        userLoginType: details.userLoginType,
      );
      emit(UserDetails(newDetails));
    }
  }

  void clearCubit() {
    emit(UserDetails(UserModel.fromMap({})));
  }

  UserModel getUserDetails() {
    if (state is UserDetails) {
      return (state as UserDetails).userDetailsModel;
    }
    return UserModel.fromMap({});
  }
}
