import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/idleuser.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<IdleUser> idleUserList = [];

Future<List<IdleUser>> adminViewIdleUsers() async {
  final response = await http.get(Uri.http(
      Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_ADM_IDLE_USERS));

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> idleUsers = [];
    idleUsers = jsonDecode(response.body);
    if (idleUsers.length > 0) {
      for (int i = 0; i < idleUsers.length; i++) {
        if (idleUsers[i] != null) {
          Map<String, dynamic> map = idleUsers[i];
          idleUserList.add(IdleUser.fromJson(map));
        }
      }
    }
    return idleUserList;
  } else {
    throw Exception(Strings.USER_FAILED_EXCEPTION);
  }
}
