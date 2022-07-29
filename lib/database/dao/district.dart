import 'package:deepaprakasar/resources/texts/strings.dart';

class District {
  final String district;

  District({required this.district});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      district: json[Strings.DB_DISTRICT],
    );
  }
}
