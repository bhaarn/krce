import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/status.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

Future<Status> editKaiProfile(
    String kainkaryam,
    String subKainkaryam,
    String type,
    String details,
    String requiredDate,
    String contactNumber,
    String whatsAppNumber,
    String registeredBy) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_EDT_KAI),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{
      Strings.DB_KAINKARYAM: kainkaryam,
      Strings.DB_SUB_KAINKARYAM: subKainkaryam,
      Strings.DB_KAI_TYPE: type,
      Strings.DB_DETAILS: details,
      Strings.DB_CONTACT_NUMBER: contactNumber,
      Strings.DB_WHATS_APP_NUMBER: whatsAppNumber,
      Strings.DB_REGISTERED_BY: registeredBy,
      Strings.DB_REQUIRED_DATE: requiredDate
    }),
  );
  return Status.fromJson(jsonDecode(response.body));
}
