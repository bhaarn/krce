import 'package:deepaprakasar/resources/texts/strings.dart';

class City {
  final String city;

  City({required this.city});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      city: json[Strings.DB_CITY],
    );
  }
}
