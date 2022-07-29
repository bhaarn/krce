import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/status.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

Future<Status> adminRegisterKar(String job, String expiryDate) async {
  final response = await http.post(
    Uri.http(
        Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_ADM_REG_KAR),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{
      Strings.DB_JOB: job,
      Strings.DB_EXPIRY_DATE: expiryDate
    }),
  );
  return Status.fromJson(jsonDecode(response.body));
}
