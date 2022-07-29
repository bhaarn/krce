import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/profilebasic.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

Future<ProfileBasic> viewProfileBasic(String userName) async {
  final response = await http.post(
    Uri.http(
        Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_PRF_BASIC),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{Strings.DB_USER_NAME: userName}),
  );
  return ProfileBasic.fromJson(jsonDecode(response.body));
}
