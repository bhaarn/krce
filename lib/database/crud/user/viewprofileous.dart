import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/status.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

Future<Status> viewProfileOus(String userName) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_PRF_OUS),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{Strings.DB_USER_NAME: userName}),
  );
  return Status.fromJson(jsonDecode(response.body));
}
