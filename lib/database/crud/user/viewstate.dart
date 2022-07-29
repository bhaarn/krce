import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/states.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<States> stateList = [];

Future<List<States>> viewState() async {
  final response = await http.get(
      Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_STATE));

  stateList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> state = [];
    state = jsonDecode(response.body);
    if (state.length > 0) {
      for (int i = 0; i < state.length; i++) {
        if (state[i] != null) {
          Map<String, dynamic> map = state[i];
          stateList.add(States.fromJson(map));
        }
      }
    }
    return stateList;
  } else {
    throw Exception(Strings.STATE_FAILED_EXCEPTION);
  }
}
