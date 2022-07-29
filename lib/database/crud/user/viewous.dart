import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/profileous.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<OusUser> ousList = [];

Future<List<OusUser>> viewOus(String registeredBy) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_OUS),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{
      Strings.DB_REGISTERED_BY: registeredBy,
    }),
  );

  ousList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> ous = [];
    ous = jsonDecode(response.body);
    if (ous.length > 0) {
      for (int i = 0; i < ous.length; i++) {
        if (ous[i] != null) {
          Map<String, dynamic> map = ous[i];
          ousList.add(OusUser.fromJson(map));
        }
      }
    }
    return ousList;
  } else {
    throw Exception(Strings.OUS_FAILED_EXCEPTION);
  }
}
