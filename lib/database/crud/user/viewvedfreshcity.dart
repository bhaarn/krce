import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/city.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<City> vedFreshCityList = [];

Future<List<City>> viewVedFreshCity() async {
  final response = await http.get(Uri.http(
      Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_VED_FRESH_CITY));

  vedFreshCityList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> city = [];
    city = jsonDecode(response.body);
    if (city.length > 0) {
      for (int i = 0; i < city.length; i++) {
        if (city[i] != null) {
          Map<String, dynamic> map = city[i];
          vedFreshCityList.add(City.fromJson(map));
        }
      }
    }
    return vedFreshCityList;
  } else {
    throw Exception(Strings.CITY_FAILED_EXCEPTION);
  }
}
