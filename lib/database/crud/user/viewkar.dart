import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/karyalayam.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<Karyalayam> karyalayamList = [];

Future<List<Karyalayam>> viewKar() async {
  final response = await http.get(
      Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_KAR));

  karyalayamList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> karyalayam = [];
    karyalayam = jsonDecode(response.body);
    if (karyalayam.length > 0) {
      for (int i = 0; i < karyalayam.length; i++) {
        if (karyalayam[i] != null) {
          Map<String, dynamic> map = karyalayam[i];
          karyalayamList.add(Karyalayam.fromJson(map));
        }
      }
    }
    return karyalayamList;
  } else {
    throw Exception(Strings.KAR_FAILED_EXCEPTION);
  }
}
