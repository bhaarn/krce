import 'package:deepaprakasar/resources/texts/strings.dart';

class Country {
  final String countryName;
  final String countryCode;

  Country({required this.countryName, required this.countryCode});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      countryName: json[Strings.DB_COUNTRY_NAME],
      countryCode: json[Strings.DB_COUNTRY_CODE],
    );
  }
}
