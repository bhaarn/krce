import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/profilekai.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<ProfileKai> profileKaiList = [];

Future<List<ProfileKai>> viewProfileKai(String registeredBy) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_PRF_KAI),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body:
        jsonEncode(<String, String>{Strings.DB_REGISTERED_BY: registeredBy}),
  );

  profileKaiList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> profileKai = [];
    profileKai = jsonDecode(response.body);
    if (profileKai.length > 0) {
      for (int i = 0; i < profileKai.length; i++) {
        if (profileKai[i] != null) {
          Map<String, dynamic> map = profileKai[i];
          profileKaiList.add(ProfileKai.fromJson(map));
        }
      }
    }
    return profileKaiList;
  } else {
    throw Exception(Strings.KAI_PRF_FAILED_EXCEPTION);
  }
}
