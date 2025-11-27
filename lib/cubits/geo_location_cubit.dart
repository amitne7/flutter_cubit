import 'package:personal_security_officer/app/general_imports.dart';


abstract class GeolocationState {}

class GeolocationInitial extends GeolocationState {}

class GetGeolocationInProgress extends GeolocationState {}

class GetGeolocationSuccess extends GeolocationState {
  final Placemark placemark;

  GetGeolocationSuccess({required this.placemark});
}

class GetGeolcationError extends GeolocationState {
  final dynamic error;

  GetGeolcationError(this.error);
}

class GeolocationCubit extends Cubit<GeolocationState> {
  GeolocationCubit() : super(GeolocationInitial());

  Future<void> getGeoLocation() async {
    try {
      emit(GetGeolocationInProgress());
      final getLocation =
      await LocationRepository.getCurrentLocationAndStoreDataIntoHive();

      emit(GetGeolocationSuccess(placemark: getLocation));
    } catch (e) {
      emit(GetGeolcationError(e));
    }
  }
}
