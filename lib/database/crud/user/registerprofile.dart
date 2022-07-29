import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/status.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

Future<Status> registerProfile(
    String firstName,
    String lastName,
    String userName,
    String password,
    String sect,
    String subSect,
    String gothram,
    String soothram,
    String vedham,
    String acharyan,
    String contactNumber, String role) async {
  final response = await http.post(
    Uri.http(
        Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_REG_PRF),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{
      Strings.DB_FIRST_NAME: firstName,
      Strings.DB_LAST_NAME: lastName,
      Strings.DB_USER_NAME: userName,
      Strings.DB_PASSWORD: password,
      Strings.DB_SECT: sect,
      Strings.DB_SUB_SECT: subSect,
      Strings.DB_GOTHRAM: gothram,
      Strings.DB_SOOTHRAM: soothram,
      Strings.DB_VEDHAM: vedham,
      Strings.DB_ACHARYAN: acharyan,
      Strings.DB_CONTACT_NUMBER: contactNumber,
      Strings.DB_ROLE: role
    }),
  );
  return Status.fromJson(jsonDecode(response.body));
}
