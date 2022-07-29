import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/propertytype.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<PropertyType> propertyTypeList = [];

Future<List<PropertyType>> viewPropertyType() async {
  final response = await http.get(Uri.http(
      Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_PROP_TYPE));

  propertyTypeList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> propertyType = [];
    propertyType = jsonDecode(response.body);
    if (propertyType.length > 0) {
      for (int i = 0; i < propertyType.length; i++) {
        if (propertyType[i] != null) {
          Map<String, dynamic> map = propertyType[i];
          propertyTypeList.add(PropertyType.fromJson(map));
        }
      }
    }
    return propertyTypeList;
  } else {
    throw Exception(Strings.PROPERTY_TYPE_FAILED_EXCEPTION);
  }
}
