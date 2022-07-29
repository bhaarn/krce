import 'package:deepaprakasar/resources/texts/strings.dart';

class Soothram {
  final String soothram;

  Soothram({required this.soothram});

  factory Soothram.fromJson(Map<String, dynamic> json) {
    return Soothram(
      soothram: json[Strings.DB_SOOTHRAM],
    );
  }
}
