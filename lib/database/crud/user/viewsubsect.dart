import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/subsect.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<SubSect> subSectList = [];

Future<List<SubSect>> viewSubSect(String sect) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_SUB_SECT),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{Strings.DB_SECT: sect}),
  );
  subSectList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> subSect = [];
    subSect = jsonDecode(response.body);
    if (subSect.length > 0) {
      for (int i = 0; i < subSect.length; i++) {
        if (subSect[i] != null) {
          Map<String, dynamic> map = subSect[i];
          subSectList.add(SubSect.fromJson(map));
        }
      }
    }
    return subSectList;
  } else {
    throw Exception(Strings.SUB_SECT_FAILED_EXCEPTION);
  }
}
