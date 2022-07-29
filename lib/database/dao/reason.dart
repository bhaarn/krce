import 'package:deepaprakasar/resources/texts/strings.dart';

class Reason {
  final String reason;

  Reason({required this.reason});

  factory Reason.fromJson(Map<String, dynamic> json) {
    return Reason(
      reason: json[Strings.DB_REASON],
    );
  }
}
