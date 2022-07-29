import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/kainkaryam.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<Kainkaryam> kainkaryamList = [];

Future<List<Kainkaryam>> viewKainkaryam(String type) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_KAINKARYAM),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{Strings.DB_KAI_TYPE: type}),
  );
  kainkaryamList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> kainkaryam = [];
    kainkaryam = jsonDecode(response.body);
    if (kainkaryam.length > 0) {
      for (int i = 0; i < kainkaryam.length; i++) {
        if (kainkaryam[i] != null) {
          Map<String, dynamic> map = kainkaryam[i];
          kainkaryamList.add(Kainkaryam.fromJson(map));
        }
      }
    }
    return kainkaryamList;
  } else {
    throw Exception(Strings.KAINKARYAM_FAILED_EXCEPTION);
  }
}
