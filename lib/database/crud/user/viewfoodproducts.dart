import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/foodproducts.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:http/http.dart' as http;

List<FoodProducts> foodProductsList = [];

Future<List<FoodProducts>> viewFoodProducts() async {
  final response = await http.get(Uri.http(
      Strings.WEB_CONNECTOR, Strings.BACKEND + Strings.BE_FILE_USR_VIEW_FOOD_PRODUCTS));

  foodProductsList.clear();

  if (response.statusCode == Strings.STATUS_CODE_OK) {
    List<dynamic> foodProducts = [];
    foodProducts = jsonDecode(response.body);
    if (foodProducts.length > 0) {
      for (int i = 0; i < foodProducts.length; i++) {
        if (foodProducts[i] != null) {
          Map<String, dynamic> map = foodProducts[i];
          foodProductsList.add(FoodProducts.fromJson(map));
        }
      }
    }
    return foodProductsList;
  } else {
    throw Exception(Strings.PRODUCT_FAILED_EXCEPTION);
  }
}
