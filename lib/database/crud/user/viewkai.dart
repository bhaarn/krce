import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/profilekai.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<ProfileKai> kaiList = [];

Future<List<ProfileKai>> viewKai(String userName) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_KAI),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{
      Strings.DB_USER_NAME: userName,
    }),
  );

  kaiList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> kai = [];
    kai = jsonDecode(response.body);
    if (kai.length > 0) {
      for (int i = 0; i < kai.length; i++) {
        if (kai[i] != null) {
          Map<String, dynamic> map = kai[i];
          kaiList.add(ProfileKai.fromJson(map));
        }
      }
    }
    return kaiList;
  } else {
    throw Exception(Strings.KAI_FAILED_EXCEPTION);
  }
}
