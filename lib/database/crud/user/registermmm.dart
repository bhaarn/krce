import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/status.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

Future<Status> registerMmm(
    String firstName,
    String lastName,
    String motherName,
    String gender,
    String birthDateTime,
    String placeOfBirth,
    String maritalStatus,
    String sect,
    String subSect,
    String gothram,
    String soothram,
    String vedham,
    String acharyan,
    String star,
    String padham,
    String rasi,
    String nativeCity,
    String qualification,
    String presentCity,
    String occupation,
    String salary,
    String heightCm,
    String heightInch,
    String weight,
    String siblings,
    String contactNumber,
    String whatsAppNumber,
    String expectation,
    String registeredBy,
    String preference) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_REG_MMM),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{
      Strings.DB_FIRST_NAME: firstName,
      Strings.DB_LAST_NAME: lastName,
      Strings.DB_MOTHER_NAME: motherName,
      Strings.DB_GENDER: gender,
      Strings.DB_BIRTH_DATE_TIME: birthDateTime,
      Strings.DB_PLACE_OF_BIRTH: placeOfBirth,
      Strings.DB_MARITAL_STATUS: maritalStatus,
      Strings.DB_SECT: sect,
      Strings.DB_SUB_SECT: subSect,
      Strings.DB_GOTHRAM: gothram,
      Strings.DB_SOOTHRAM: soothram,
      Strings.DB_VEDHAM: vedham,
      Strings.DB_ACHARYAN: acharyan,
      Strings.DB_STAR: star,
      Strings.DB_PADHAM: padham,
      Strings.DB_RASI: rasi,
      Strings.DB_NATIVE_CITY: nativeCity,
      Strings.DB_QUALIFICATION: qualification,
      Strings.DB_PRESENT_CITY: presentCity,
      Strings.DB_OCCUPATION: occupation,
      Strings.DB_SALARY: salary,
      Strings.DB_HEIGHT_CM: heightCm,
      Strings.DB_HEIGHT_INCH: heightInch,
      Strings.DB_WEIGHT: weight,
      Strings.DB_SIBLINGS: siblings,
      Strings.DB_CONTACT_NUMBER: contactNumber,
      Strings.DB_WHATS_APP_NUMBER: whatsAppNumber,
      Strings.DB_EXPECTATION: expectation,
      Strings.DB_PREFERENCE: preference,
      Strings.DB_REGISTERED_BY: registeredBy
    }),
  );
  return Status.fromJson(jsonDecode(response.body));
}
