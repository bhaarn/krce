import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/profilevat.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<ProfileVat> profileVatList = [];

Future<List<ProfileVat>> viewProfileVat(String registeredBy) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_PRF_VAT),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body:
        jsonEncode(<String, String>{Strings.DB_REGISTERED_BY: registeredBy}),
  );

  profileVatList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> profileVat = [];
    profileVat = jsonDecode(response.body);
    if (profileVat.length > 0) {
      for (int i = 0; i < profileVat.length; i++) {
        if (profileVat[i] != null) {
          Map<String, dynamic> map = profileVat[i];
          profileVatList.add(ProfileVat.fromJson(map));
        }
      }
    }
    return profileVatList;
  } else {
    throw Exception(Strings.VAT_PROFILE_FAILED_EXCEPTION);
  }
}
