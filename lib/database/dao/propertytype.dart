import 'package:deepaprakasar/resources/texts/strings.dart';

class PropertyType {
  late final String type;

  PropertyType({required this.type});

  factory PropertyType.fromJson(Map<String, dynamic> json) {
    return PropertyType(
      type: json[Strings.DB_TYPE],
    );
  }
}
