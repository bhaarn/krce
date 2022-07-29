import 'package:deepaprakasar/resources/texts/strings.dart';

class PropertyRemovalReason {
  late final String reason;

  PropertyRemovalReason({required this.reason});

  factory PropertyRemovalReason.fromJson(Map<String, dynamic> json) {
    return PropertyRemovalReason(
      reason: json[Strings.DB_REASON],
    );
  }
}
