import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/sect.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<Sect> sectList = [];

Future<List<Sect>> viewSect() async {
  final response = await http.get(
      Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_SECT));

  sectList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> sect = [];
    sect = jsonDecode(response.body);
    if (sect.length > 0) {
      for (int i = 0; i < sect.length; i++) {
        if (sect[i] != null) {
          Map<String, dynamic> map = sect[i];
          sectList.add(Sect.fromJson(map));
        }
      }
    }
    return sectList;
  } else {
    throw Exception(Strings.SECT_FAILED_EXCEPTION);
  }
}
