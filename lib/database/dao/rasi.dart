import 'package:deepaprakasar/resources/texts/strings.dart';

class Rasi {
  final String rasi;

  Rasi({required this.rasi});

  factory Rasi.fromJson(Map<String, dynamic> json) {
    return Rasi(
      rasi: json[Strings.DB_RASI],
    );
  }
}
