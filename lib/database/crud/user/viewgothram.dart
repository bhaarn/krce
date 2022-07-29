import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/gothram.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<Gothram> gothramList = [];

Future<List<Gothram>> viewGothram() async {
  final response = await http.get(
      Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_GOTHRAM));

  gothramList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> gothram = [];
    gothram = jsonDecode(response.body);
    if (gothram.length > 0) {
      for (int i = 0; i < gothram.length; i++) {
        if (gothram[i] != null) {
          Map<String, dynamic> map = gothram[i];
          gothramList.add(Gothram.fromJson(map));
        }
      }
    }
    return gothramList;
  } else {
    throw Exception(Strings.GOTHRAM_FAILED_EXCEPTION);
  }
}
