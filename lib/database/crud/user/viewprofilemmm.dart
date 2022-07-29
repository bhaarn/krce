import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/profilemmm.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<ProfileMmm> profileMmmList = [];

Future<List<ProfileMmm>> viewProfileMMM(String registeredBy) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_PRF_MMM),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body:
        jsonEncode(<String, String>{Strings.DB_REGISTERED_BY: registeredBy}),
  );

  profileMmmList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> profileMmm = [];
    profileMmm = jsonDecode(response.body);
    if (profileMmm.length > 0) {
      for (int i = 0; i < profileMmm.length; i++) {
        if (profileMmm[i] != null) {
          Map<String, dynamic> map = profileMmm[i];
          profileMmmList.add(ProfileMmm.fromJson(map));
        }
      }
    }
    return profileMmmList;
  } else {
    throw Exception(Strings.MMM_PROFILE_FAILED_EXCEPTION);
  }
}
