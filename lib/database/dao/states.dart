import 'package:deepaprakasar/resources/texts/strings.dart';

class States {
  final String states;

  States({required this.states});

  factory States.fromJson(Map<String, dynamic> json) {
    return States(
      states: json[Strings.DB_STATE],
    );
  }
}
