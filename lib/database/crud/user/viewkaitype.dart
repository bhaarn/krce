import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/kaitype.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<KaiType> kaiTypeList = [];

Future<List<KaiType>> viewKaiType() async {
  final response = await http.get(
      Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_KAI_TYPE));

  kaiTypeList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> kaiType = [];
    kaiType = jsonDecode(response.body);
    if (kaiType.length > 0) {
      for (int i = 0; i < kaiType.length; i++) {
        if (kaiType[i] != null) {
          Map<String, dynamic> map = kaiType[i];
          kaiTypeList.add(KaiType.fromJson(map));
        }
      }
    }
    return kaiTypeList;
  } else {
    throw Exception(Strings.STAR_FAILED_EXCEPTION);
  }
}
