import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/profileved.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<ProfileVed> profileVedList = [];

Future<List<ProfileVed>> viewProfileVed(String registeredBy) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_PRF_VED),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body:
        jsonEncode(<String, String>{Strings.DB_REGISTERED_BY: registeredBy}),
  );

  profileVedList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> profileVed = [];
    profileVed = jsonDecode(response.body);
    if (profileVed.length > 0) {
      for (int i = 0; i < profileVed.length; i++) {
        if (profileVed[i] != null) {
          Map<String, dynamic> map = profileVed[i];
          profileVedList.add(ProfileVed.fromJson(map));
        }
      }
    }
    return profileVedList;
  } else {
    throw Exception(Strings.VED_PROFILE_FAILED_EXCEPTION);
  }
}
