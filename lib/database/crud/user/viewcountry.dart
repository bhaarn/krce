import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/country.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<Country> countryList = [];

Future<List<Country>> viewCountry() async {
  final response = await http.get(
      Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_COUNTRY));

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> country = [];
    country = jsonDecode(response.body);
    if (country.length > 0) {
      for (int i = 0; i < country.length; i++) {
        if (country[i] != null) {
          Map<String, dynamic> map = country[i];
          countryList.add(Country.fromJson(map));
        }
      }
    }
    return countryList;
  } else {
    throw Exception(Strings.COUNTRY_FAILED_EXCEPTION);
  }
}
