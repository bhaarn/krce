import 'package:deepaprakasar/resources/texts/strings.dart';

class SubKainkaryam {
  late final String subKainkaryam;

  SubKainkaryam({required this.subKainkaryam});

  factory SubKainkaryam.fromJson(Map<String, dynamic> json) {
    return SubKainkaryam(
      subKainkaryam: json[Strings.DB_SUB_KAINKARYAM],
    );
  }
}
