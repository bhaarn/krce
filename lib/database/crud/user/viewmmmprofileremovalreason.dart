import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/reason.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<Reason> reasonList = [];

Future<List<Reason>> viewMMMProfileRemovalReason() async {
  final response = await http.get(Uri.http(Strings.WEB_CONNECTOR,
      Strings.BACKEND + Strings.BE_FILE_USR_VIEW_MMM_REMOVAL_REASON));

  reasonList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> reason = [];
    reason = jsonDecode(response.body);
    if (reason.length > 0) {
      for (int i = 0; i < reason.length; i++) {
        if (reason[i] != null) {
          Map<String, dynamic> map = reason[i];
          reasonList.add(Reason.fromJson(map));
        }
      }
    }
    return reasonList;
  } else {
    throw Exception(Strings.REMOVAL_REASON_FAILED_EXCEPTION);
  }
}
