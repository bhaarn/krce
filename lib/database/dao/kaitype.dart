import 'package:deepaprakasar/resources/texts/strings.dart';

class KaiType {
  late final String type;

  KaiType({required this.type});

  factory KaiType.fromJson(Map<String, dynamic> json) {
    return KaiType(
      type: json[Strings.DB_KAI_TYPE],
    );
  }
}
