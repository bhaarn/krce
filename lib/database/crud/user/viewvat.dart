import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/profilevat.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<ProfileVat> vatikalayamList = [];

Future<List<ProfileVat>> viewVat(String district, String state, String propertyOperation) async {
  final response = await http.post(
      Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_VAT),
    headers: <String, String>{
    Strings.CONTENT_TYPE: Strings.JSON_HEADER,
  },
    body: jsonEncode(<String, String>{
      Strings.DB_DISTRICT: district,
      Strings.DB_STATE: state,
      Strings.DB_PROPERTY_OPERATION: propertyOperation
    }),
  );

  vatikalayamList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> vatikalayam = [];
    vatikalayam = jsonDecode(response.body);
    if (vatikalayam.length > 0) {
      for (int i = 0; i < vatikalayam.length; i++) {
        if (vatikalayam[i] != null) {
          Map<String, dynamic> map = vatikalayam[i];
          vatikalayamList.add(ProfileVat.fromJson(map));
        }
      }
    }
    return vatikalayamList;
  } else {
    throw Exception(Strings.VAT_FAILED_EXCEPTION);
  }
}
