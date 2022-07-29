import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/acharyan.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<Acharyan> acharyanList = [];

Future<List<Acharyan>> viewAcharyan(String sect) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_ACHARYAN),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{Strings.DB_SECT: sect}),
  );
  acharyanList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> acharyan = [];
    acharyan = jsonDecode(response.body);
    if (acharyan.length > 0) {
      for (int i = 0; i < acharyan.length; i++) {
        if (acharyan[i] != null) {
          Map<String, dynamic> map = acharyan[i];
          acharyanList.add(Acharyan.fromJson(map));
        }
      }
    }
    return acharyanList;
  } else {
    throw Exception(Strings.USER_FAILED_EXCEPTION);
  }
}
