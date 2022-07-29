import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/performance.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<DeepaPrakasarPerformance> perfList = [];

Future<List<DeepaPrakasarPerformance>> viewMmm() async {
  final response = await http.get(Uri.http(Strings.WEB_CONNECTOR,
      Strings.BACKEND + Strings.BE_FILE_USR_DPSR_PERF));

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> perf = [];
    perf = jsonDecode(response.body);
    if (perf.length > 0) {
      for (int i = 0; i < perf.length; i++) {
        if (perf[i] != null) {
          Map<String, dynamic> map = perf[i];
          perfList.add(DeepaPrakasarPerformance.fromJson(map));
        }
      }
    }
    return perfList;
  } else {
    throw Exception(Strings.USER_FAILED_EXCEPTION);
  }
}
