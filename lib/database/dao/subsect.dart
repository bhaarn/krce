import 'package:deepaprakasar/resources/texts/strings.dart';

class SubSect {
  final String subSect;

  SubSect({required this.subSect});

  factory SubSect.fromJson(Map<String, dynamic> json) {
    return SubSect(
      subSect: json[Strings.DB_SUB_SECT],
    );
  }
}
