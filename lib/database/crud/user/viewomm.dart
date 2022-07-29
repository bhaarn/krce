import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/profileomm.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<ProfileOmm> ommList = [];

Future<List<ProfileOmm>> viewOmm(String userName) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_OMM),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{
      Strings.DB_USER_NAME: userName,
    }),
  );

  ommList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> omm = [];
    omm = jsonDecode(response.body);
    if (omm.length > 0) {
      for (int i = 0; i < omm.length; i++) {
        if (omm[i] != null) {
          Map<String, dynamic> map = omm[i];
          ommList.add(ProfileOmm.fromJson(map));
        }
      }
    }
    return ommList;
  } else {
    throw Exception(Strings.OMM_FAILED_EXCEPTION);
  }
}
