import 'package:deepaprakasar/resources/texts/strings.dart';

class Star {
  final String star;

  Star({required this.star});

  factory Star.fromJson(Map<String, dynamic> json) {
    return Star(
      star: json[Strings.DB_STAR],
    );
  }
}
