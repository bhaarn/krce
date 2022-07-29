import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/city.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<City> cityList = [];

Future<List<City>> viewCity(String pinCode) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_CITY),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{
      Strings.DB_PIN_CODE: pinCode,
    }),
  );

  cityList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> city = [];
    city = jsonDecode(response.body);
    if (city.length > 0) {
      for (int i = 0; i < city.length; i++) {
        if (city[i] != null) {
          Map<String, dynamic> map = city[i];
          cityList.add(City.fromJson(map));
        }
      }
    }
    return cityList;
  } else {
    throw Exception(Strings.CITY_FAILED_EXCEPTION);
  }
}
