import 'package:deepaprakasar/resources/texts/strings.dart';

class Sect {
  late final String sect;

  Sect({required this.sect});

  factory Sect.fromJson(Map<String, dynamic> json) {
    return Sect(
      sect: json[Strings.DB_SECT],
    );
  }
}
