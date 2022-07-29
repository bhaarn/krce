import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/pincode.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<PinCode> pinCodeList = [];

Future<List<PinCode>> viewPinCode(String state, String district) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_PIN_CODE),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{
      Strings.DB_STATE: state,
      Strings.DB_DISTRICT: district
    }),
  );

  pinCodeList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> pinCode = [];
    pinCode = jsonDecode(response.body);
    if (pinCode.length > 0) {
      for (int i = 0; i < pinCode.length; i++) {
        if (pinCode[i] != null) {
          Map<String, dynamic> map = pinCode[i];
          pinCodeList.add(PinCode.fromJson(map));
        }
      }
    }
    return pinCodeList;
  } else {
    throw Exception(Strings.PIN_CODE_FAILED_EXCEPTION);
  }
}
