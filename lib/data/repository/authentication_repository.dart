// ignore_for_file: non_constant_identifier_names

import 'package:personal_security_officer/app/general_imports.dart';
import 'package:personal_security_officer/data/model/user_model.dart';


class AuthenticationRepository {
  static String? kPhoneNumber;
  static String? verificationId;

  

  bool get isLoggedIn => false;

 

  Future resendOTPUsingSMSGateway({
    required final String phoneNumber,
    required final String countryCode,
  }) async {
    kPhoneNumber = phoneNumber;
    final Map<String, dynamic> response = await Api.post(
        url: Api.resendOTP,
        parameter: {
          Api.mobile: "$countryCode$phoneNumber",
        },
        useAuthToken: false);

    return response;
  }

  static Future<UserModel> loginUser({
    required final String latitude,
    required final String longitude,
    final String? mobileNumber,
    final String? countryCode,
    required final String uid,
    final String? fcmId,
    required final LogInType loginType,
  }) async {
    try {
      final parameters = <String, dynamic>{
        Api.countryCode: countryCode,
        Api.uid: uid,
        Api.mobile: mobileNumber,
        Api.latitude: latitude,
        Api.longitude: longitude,
        Api.loginType: loginType.name.toString(),
      };
      if (fcmId != null) {
        parameters[Api.fcmId] = fcmId;
        parameters[Api.platform] = Platform.isAndroid ? "android" : "ios";
      }

      parameters.removeWhere((key, value) => value == null || value == "null");

      final Map<String, dynamic> result = await Api.post(
          url: Api.manageUser, parameter: parameters, useAuthToken: false);

      final UserModel userDetailsModel =
          UserModel.fromMap(result["data"]);

      HiveRepository.setUserToken = result["token"];

      final Map<String, dynamic> map = userDetailsModel.toMap();

      final LocationPermission permisison = await Geolocator.checkPermission();

      if (permisison == LocationPermission.denied ||
          permisison == LocationPermission.deniedForever) {
        map.remove("latitude");
        map.remove("longitude");
      }

      await HiveRepository.putAllValue(
          boxName: HiveRepository.userDetailBoxKey, values: map);

      HiveRepository.setLatitude = latitude;
      HiveRepository.setLongitude = longitude;
      return userDetailsModel;
    } catch (e) {
      throw ApiException(e.toString());
    }
  }



  Future<Map<String, dynamic>> verifyOTPUsingSMSGateway({
    required final String mobileNumber,
    required final String countryCode,
    required final String otp,
  }) async {
    try {
      final Map<String, dynamic> parameter = <String, dynamic>{
        Api.phone: mobileNumber,
        Api.countryCode: countryCode,
        Api.otp: otp,
      };

      final response = await Api.post(
          parameter: parameter, url: Api.verifyOTP, useAuthToken: false);
      return {
        "error": response['error'],
        "message": response['message'],
      };
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<Map<String, dynamic>> isUserExists({
    final String? mobileNumber,
    final String? countryCode,
    required String uid,
  }) async {
    try {
      final Map<String, dynamic> parameter = <String, dynamic>{
        Api.mobile: mobileNumber,
        Api.countryCode: countryCode,
        Api.uid: uid,
      };
      parameter.removeWhere(
        (key, value) => value == null || value == "null",
      );

      final response = await Api.post(
          parameter: parameter, url: Api.verifyUser, useAuthToken: false);

      return {
        "error": response['error'],
        "message": response['message'],
        "status_code": response['message_code'],
        "authenticationType": response['authentication_mode']
      };
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  Future<Map<String, dynamic>> deleteUserAccount() async {
    try {
      //delete account from Firebase
     

      //delete account from database
      final Map<String, dynamic> accountData = await Api.post(
          url: Api.deleteUserAccount, parameter: {}, useAuthToken: true);

      return {"error": accountData['error'], "message": accountData['message']};
    } catch (e) {
      if (e.toString().contains('firebase_auth/requires-recent-login')) {
        return {"error": true, "message": "pleaseReLoginAgainToDeleteAccount"};
      }
      return {"error": true, "message": e.toString()};
    }
  }

  Future<UserModel> getUserDetails({final String? mobileNumber}) async {
    try {
      final Map<String, dynamic> parameter = <String, dynamic>{
        Api.mobile: mobileNumber,
      };
      parameter.removeWhere(
            (key, value) => value == null || value == "null",
      );
      final Map<String, dynamic> result = await Api.post(
          url: Api.getUserDetails, parameter: parameter, useAuthToken: true);

      final UserModel userDetailsModel =
          UserModel.fromMap(result["data"]);

      final Map<String, dynamic> map = userDetailsModel.toMap();
//
      final latitude = HiveRepository.getLatitude;
      final longitude = HiveRepository.getLongitude;

      await HiveRepository.putAllValue(
          boxName: HiveRepository.userDetailBoxKey, values: map);

      HiveRepository.setLatitude = latitude;
      HiveRepository.setLongitude = longitude;

      return userDetailsModel;
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}
