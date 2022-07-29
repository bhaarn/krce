import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/status.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

Future<Status> forgotPassword(String userName, String contactNumber) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_FORGOT_PWD),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{
      Strings.DB_USER_NAME: userName,
      Strings.DB_CONTACT_NUMBER: contactNumber
    }),
  );
  return Status.fromJson(jsonDecode(response.body));
}
