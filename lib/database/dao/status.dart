import 'package:deepaprakasar/resources/texts/strings.dart';

class Status {
  final String status;

  Status({required this.status});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      status: json[Strings.DB_STATUS],
    );
  }
}
