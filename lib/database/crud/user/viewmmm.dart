import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/profilemmm.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<ProfileMmm> mmmList = [];

Future<List<ProfileMmm>> viewMmm(String userName) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_MMM),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{
      Strings.DB_USER_NAME: userName,
    }),
  );

  mmmList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> mmm = [];
    mmm = jsonDecode(response.body);
    if (mmm.length > 0) {
      for (int i = 0; i < mmm.length; i++) {
        if (mmm[i] != null) {
          Map<String, dynamic> map = mmm[i];
          mmmList.add(ProfileMmm.fromJson(map));
        }
      }
    }
    return mmmList;
  } else {
    throw Exception(Strings.MMM_FAILED_EXCEPTION);
  }
}
