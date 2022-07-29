import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/status.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

Future<Status> hideViewedProfiles(String registeredBy, String uniqueID) async {
  final response = await http.post(
    Uri.http(
        Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_HIDE_VIEWED_PRFS),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{
      Strings.DB_REGISTERED_BY: registeredBy,
      Strings.DB_UNIQUE_ID: uniqueID,
    }),
  );
  return Status.fromJson(jsonDecode(response.body));
}
