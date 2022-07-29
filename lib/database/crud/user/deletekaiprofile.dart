import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/status.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

Future<Status> deleteKAIProfile(
    String userName, String uniqueId, String reason) async {
  final response = await http.post(
    Uri.http(
        Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_DEL_KAI),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{
      Strings.DB_USER_NAME: userName,
      Strings.DB_UNIQUE_ID: uniqueId,
      Strings.DB_REASON: reason
    }),
  );
  return Status.fromJson(jsonDecode(response.body));
}
