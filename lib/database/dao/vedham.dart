import 'package:deepaprakasar/resources/texts/strings.dart';

class Vedham {
  final String vedham;

  Vedham({required this.vedham});

  factory Vedham.fromJson(Map<String, dynamic> json) {
    return Vedham(
      vedham: json[Strings.DB_VEDHAM],
    );
  }
}
