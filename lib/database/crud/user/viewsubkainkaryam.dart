import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/subkainkaryam.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<SubKainkaryam> subKainkaryamList = [];

Future<List<SubKainkaryam>> viewSubKainkaryam(String kainkaryam) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_SUB_KAINKARYAM),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{Strings.DB_KAINKARYAM: kainkaryam}),
  );
  subKainkaryamList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> subKainkaryam = [];
    subKainkaryam = jsonDecode(response.body);
    if (subKainkaryam.length > 0) {
      for (int i = 0; i < subKainkaryam.length; i++) {
        if (subKainkaryam[i] != null) {
          Map<String, dynamic> map = subKainkaryam[i];
          subKainkaryamList.add(SubKainkaryam.fromJson(map));
        }
      }
    }
    return subKainkaryamList;
  } else {
    throw Exception(Strings.SUB_KAINKARYAM_FAILED_EXCEPTION);
  }
}
