import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/status.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

Future<Status> registerBojDet(String productName, String productType,
    String quantity, String price, String uniqueID) async {
  final response = await http.post(
    Uri.http(Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_REG_BOJ),
    headers: <String, String>{
      Strings.CONTENT_TYPE: Strings.JSON_HEADER,
    },
    body: jsonEncode(<String, String>{
      Strings.DB_PRODUCT_NAME: productName,
      Strings.DB_PRODUCT_TYPE: productType,
      Strings.DB_QUANTITY: quantity,
      Strings.DB_PRICE: price,
      Strings.DB_UNIQUE_ID: uniqueID,
    }),
  );
  return Status.fromJson(jsonDecode(response.body));
}
