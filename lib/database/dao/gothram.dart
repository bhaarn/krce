import 'package:deepaprakasar/resources/texts/strings.dart';

class Gothram {
  late final String gothram;

  Gothram({required this.gothram});

  factory Gothram.fromJson(Map<String, dynamic> json) {
    return Gothram(
      gothram: json[Strings.DB_GOTHRAM],
    );
  }
}
