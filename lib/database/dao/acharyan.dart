import 'package:deepaprakasar/resources/texts/strings.dart';

class Acharyan {
  final String acharyan;

  Acharyan({required this.acharyan});

  factory Acharyan.fromJson(Map<String, dynamic> json) {
    return Acharyan(
      acharyan: json[Strings.DB_ACHARYAN],
    );
  }
}
