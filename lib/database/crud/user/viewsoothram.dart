import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/soothram.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<Soothram> soothramList = [];

Future<List<Soothram>> viewSoothram(String vedham) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_SOOTHRAM),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{Strings.DB_VEDHAM: vedham}),
  );
  soothramList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> soothram = [];
    soothram = jsonDecode(response.body);
    if (soothram.length > 0) {
      for (int i = 0; i < soothram.length; i++) {
        if (soothram[i] != null) {
          Map<String, dynamic> map = soothram[i];
          soothramList.add(Soothram.fromJson(map));
        }
      }
    }
    return soothramList;
  } else {
    throw Exception(Strings.SOOTHRAM_FAILED_EXCEPTION);
  }
}
