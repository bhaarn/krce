import 'package:deepaprakasar/resources/texts/strings.dart';

class Kainkaryam {
  late final String kainkaryam;

  Kainkaryam({required this.kainkaryam});

  factory Kainkaryam.fromJson(Map<String, dynamic> json) {
    return Kainkaryam(
      kainkaryam: json[Strings.DB_KAINKARYAM],
    );
  }
}
