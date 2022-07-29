import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/star.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<Star> starList = [];

Future<List<Star>> viewStar() async {
  final response = await http.get(
      Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_STAR));

  starList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> star = [];
    star = jsonDecode(response.body);
    if (star.length > 0) {
      for (int i = 0; i < star.length; i++) {
        if (star[i] != null) {
          Map<String, dynamic> map = star[i];
          starList.add(Star.fromJson(map));
        }
      }
    }
    return starList;
  } else {
    throw Exception(Strings.STAR_FAILED_EXCEPTION);
  }
}
