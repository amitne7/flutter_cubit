

import 'package:personal_security_officer/app/general_imports.dart';
import 'package:personal_security_officer/data/model/home_screen_model.dart';

class HomeScreenRepository {
  //
  ///This method is used to fetch sectionList
  Future<HomeScreenModel> fetchHomeScreenData({
    required final String latitude,
    required final String longitude,
  }) async {
    try {
      final result = await Api.post(
        parameter: {Api.latitude: latitude, Api.longitude: longitude},
        url: Api.getHomeScreenData,
        useAuthToken: true,
      );

      if ((result["data"] as Map).isEmpty) {
        return HomeScreenModel([], [], []);
      }
      return HomeScreenModel.fromJson(Map.from(result['data']));
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}
