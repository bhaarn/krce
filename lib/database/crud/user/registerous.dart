import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/status.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

Future<Status> registerOus(
    String firstName,
    String lastName,
    String gender,
    String ailmentShortDesc,
    String contactNumber,
    String whatsAppNumber,
    String registeredBy,
    String dateOfBirth) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_REG_OUS),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{
      Strings.DB_FIRST_NAME: firstName,
      Strings.DB_LAST_NAME: lastName,
      Strings.DB_GENDER: gender,
      Strings.DB_AILMENT_SHORT_DESC: ailmentShortDesc,
      Strings.DB_CONTACT_NUMBER: contactNumber,
      Strings.DB_WHATS_APP_NUMBER: whatsAppNumber,
      Strings.DB_REGISTERED_BY: registeredBy,
      Strings.DB_DATE_OF_BIRTH: dateOfBirth
    }),
  );
  return Status.fromJson(jsonDecode(response.body));
}
