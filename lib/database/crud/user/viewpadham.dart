import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/padham.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<Padham> padhamList = [];

Future<List<Padham>> viewPadham(String star) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_PADHAM),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{Strings.DB_STAR: star}),
  );

  padhamList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> padham = [];
    padham = jsonDecode(response.body);
    if (padham.length > 0) {
      for (int i = 0; i < padham.length; i++) {
        if (padham[i] != null) {
          Map<String, dynamic> map = padham[i];
          padhamList.add(Padham.fromJson(map));
        }
      }
    }
    return padhamList;
  } else {
    throw Exception(Strings.STAR_FAILED_EXCEPTION);
  }
}
