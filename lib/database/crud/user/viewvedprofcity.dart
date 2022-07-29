import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/city.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<City> vedProfCityList = [];

Future<List<City>> viewVedProfCity() async {
  final response = await http.get(Uri.http(
      Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_VED_PROF_CITY));

  vedProfCityList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> city = [];
    city = jsonDecode(response.body);
    if (city.length > 0) {
      for (int i = 0; i < city.length; i++) {
        if (city[i] != null) {
          Map<String, dynamic> map = city[i];
          vedProfCityList.add(City.fromJson(map));
        }
      }
    }
    return vedProfCityList;
  } else {
    throw Exception(Strings.CITY_FAILED_EXCEPTION);
  }
}
