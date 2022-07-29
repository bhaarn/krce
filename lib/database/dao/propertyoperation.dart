import 'package:deepaprakasar/resources/texts/strings.dart';

class PropertyOperation {
  late final String operation;

  PropertyOperation({required this.operation});

  factory PropertyOperation.fromJson(Map<String, dynamic> json) {
    return PropertyOperation(
      operation: json[Strings.DB_OPERATION],
    );
  }
}
