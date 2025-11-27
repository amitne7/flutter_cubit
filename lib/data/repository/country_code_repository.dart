import 'package:personal_security_officer/app/general_imports.dart';

import 'package:flutter/material.dart';
import 'package:personal_security_officer/data/model/country_code_model.dart';

class CountryCodeRepository {
  Future<List<CountryCodeModel>> getCountries(BuildContext context) async {
    final String rawData =
        await rootBundle.loadString('assets/countryCodes/countryCodes.json');
    final parsed = json.decode(rawData.toString()).cast<Map<String, dynamic>>();
    return parsed
        .map<CountryCodeModel>((json) => CountryCodeModel.fromJson(json))
        .toList();
  }

  Future<CountryCodeModel> getCountryByCountryCode(
      BuildContext context, String countryCode) async {
    final list = await getCountries(context);
    return list.firstWhere((element) => element.countryCode == countryCode);
  }
}
