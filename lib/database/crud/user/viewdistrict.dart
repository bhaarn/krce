import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/district.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<District> districtList = [];

Future<List<District>> viewDistrict(String state) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_DISTRICT),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{Strings.DB_STATE: state}),
  );

  districtList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> district = [];
    district = jsonDecode(response.body);
    if (district.length > 0) {
      for (int i = 0; i < district.length; i++) {
        if (district[i] != null) {
          Map<String, dynamic> map = district[i];
          districtList.add(District.fromJson(map));
        }
      }
    }
    return districtList;
  } else {
    throw Exception(Strings.DISTRICT_FAILED_EXCEPTION);
  }
}
