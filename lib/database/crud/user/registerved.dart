import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/status.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

Future<Status> registerVed(
    String firstName,
    String lastName,
    String gender,
    String sect,
    String subSect,
    String gothram,
    String soothram,
    String vedham,
    String acharyan,
    String qualification,
    String presentCity,
    String address,
    String jobStatus,
    String occupation,
    String contactNumber,
    String whatsAppNumber,
    String registeredBy,
    String photoPath) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_REG_VED),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{
      Strings.DB_FIRST_NAME: firstName,
      Strings.DB_LAST_NAME: lastName,
      Strings.DB_GENDER: gender,
      Strings.DB_SECT: sect,
      Strings.DB_SUB_SECT: subSect,
      Strings.DB_GOTHRAM: gothram,
      Strings.DB_SOOTHRAM: soothram,
      Strings.DB_VEDHAM: vedham,
      Strings.DB_ACHARYAN: acharyan,
      Strings.DB_QUALIFICATION: qualification,
      Strings.DB_PRESENT_CITY: presentCity,
      Strings.DB_ADDRESS: address,
      Strings.DB_JOB_STATUS: jobStatus,
      Strings.DB_OCCUPATION: occupation,
      Strings.DB_CONTACT_NUMBER: contactNumber,
      Strings.DB_WHATS_APP_NUMBER: whatsAppNumber,
      Strings.DB_PHOTO_PATH: photoPath,
      Strings.DB_REGISTERED_BY: registeredBy
    }),
  );
  return Status.fromJson(jsonDecode(response.body));
}
