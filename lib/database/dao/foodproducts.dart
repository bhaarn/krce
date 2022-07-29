import 'package:deepaprakasar/resources/texts/strings.dart';

class FoodProducts {
  final String productName;
  final String productType;
  final String price;

  FoodProducts(
      {required this.productName,
      required this.productType,
      required this.price});

  factory FoodProducts.fromJson(Map<String, dynamic> json) {
    return FoodProducts(
        productName: json[Strings.DB_PRODUCT_NAME],
        productType: json[Strings.DB_PRODUCT_TYPE],
        price: json[Strings.DB_PRICE]);
  }
}
