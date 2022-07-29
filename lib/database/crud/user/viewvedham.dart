import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/vedham.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<Vedham> vedhamList = [];

Future<List<Vedham>> viewVedham() async {
  final response = await http.get(
      Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_VEDHAM));

  vedhamList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> vedham = [];
    vedham = jsonDecode(response.body);
    if (vedham.length > 0) {
      for (int i = 0; i < vedham.length; i++) {
        if (vedham[i] != null) {
          Map<String, dynamic> map = vedham[i];
          vedhamList.add(Vedham.fromJson(map));
        }
      }
    }
    return vedhamList;
  } else {
    throw Exception(Strings.VEDHAM_FAILED_EXCEPTION);
  }
}
