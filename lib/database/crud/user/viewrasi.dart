import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/rasi.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

Future<Rasi> viewRasi(String star, String padham) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_RASI),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(
        <String, String>{Strings.DB_STAR: star, Strings.DB_PADHAM: padham}),
  );
  return Rasi.fromJson(jsonDecode(response.body));
}
