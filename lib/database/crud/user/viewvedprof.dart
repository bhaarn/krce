import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/profileved.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<ProfileVed> vedList = [];

Future<List<ProfileVed>> viewVedProf(String presentCity) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_VED_PROF),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{
      Strings.DB_PRESENT_CITY: presentCity,
    }),
  );
  vedList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> ved = [];
    ved = jsonDecode(response.body);
    if (ved.length > 0) {
      for (int i = 0; i < ved.length; i++) {
        if (ved[i] != null) {
          Map<String, dynamic> map = ved[i];
          vedList.add(ProfileVed.fromJson(map));
        }
      }
    }
    return vedList;
  } else {
    throw Exception(Strings.USER_FAILED_EXCEPTION);
  }
}
