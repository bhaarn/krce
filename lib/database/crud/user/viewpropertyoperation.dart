import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/propertyoperation.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<PropertyOperation> propertyOperationList = [];

Future<List<PropertyOperation>> viewPropertyOperation(String type) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR,
        Strings.BACKEND + Strings.BE_FILE_USR_VIEW_PROP_OP),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{
      Strings.DB_TYPE: type,
    }),
  );

  propertyOperationList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> propertyOperation = [];
    propertyOperation = jsonDecode(response.body);
    if (propertyOperation.length > 0) {
      for (int i = 0; i < propertyOperation.length; i++) {
        if (propertyOperation[i] != null) {
          Map<String, dynamic> map = propertyOperation[i];
          propertyOperationList.add(PropertyOperation.fromJson(map));
        }
      }
    }
    return propertyOperationList;
  } else {
    throw Exception(Strings.PROPERTY_OPERATION_FAILED_EXCEPTION);
  }
}
