import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/status.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

Future<Status> editVatProfile(
    String propertyType,
    String city,
    String district,
    String state,
    String address,
    String details,
    String photoPath,
    String propertyOperation,
    String propertyStatus,
    String contactNumber,
    String whatsAppNumber,
    String uniqueID,
    String pinCode) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_EDT_VAT),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{
      Strings.DB_PROPERTY_TYPE: propertyType,
      Strings.DB_PIN_CODE: pinCode,
      Strings.DB_CITY: city,
      Strings.DB_DISTRICT: district,
      Strings.DB_STATE: state,
      Strings.DB_ADDRESS: address,
      Strings.DB_DETAILS: details,
      Strings.DB_PHOTO_PATH: photoPath,
      Strings.DB_PROPERTY_OPERATION: propertyOperation,
      Strings.DB_PROPERTY_STATUS: propertyStatus,
      Strings.DB_CONTACT_NUMBER: contactNumber,
      Strings.DB_WHATS_APP_NUMBER: whatsAppNumber,
      Strings.DB_UNIQUE_ID: uniqueID
    }),
  );
  return Status.fromJson(jsonDecode(response.body));
}
