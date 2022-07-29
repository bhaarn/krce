import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/profileous.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<OusUser> ousUserList = [];

Future<List<OusUser>> adminViewOus() async {
  final response = await http.get(Uri.http(
      Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_ADM_VIEW_OUS));

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> ousUsers = [];
    ousUsers = jsonDecode(response.body);
    if (ousUsers.length > 0) {
      for (int i = 0; i < ousUsers.length; i++) {
        if (ousUsers[i] != null) {
          Map<String, dynamic> map = ousUsers[i];
          ousUserList.add(OusUser.fromJson(map));
        }
      }
    }
    return ousUserList;
  } else {
    throw Exception(Strings.USER_FAILED_EXCEPTION);
  }
}
