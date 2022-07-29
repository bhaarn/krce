import 'package:deepaprakasar/resources/texts/strings.dart';

class Padham {
  final String padham;

  Padham({required this.padham});

  factory Padham.fromJson(Map<String, dynamic> json) {
    return Padham(
      padham: json[Strings.DB_PADHAM],
    );
  }
}
