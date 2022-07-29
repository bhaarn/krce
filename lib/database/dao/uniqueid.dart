import 'package:deepaprakasar/resources/texts/strings.dart';

class UniqueID {
  final String uniqueID;

  UniqueID({required this.uniqueID});

  factory UniqueID.fromJson(Map<String, dynamic> json) {
    return UniqueID(
      uniqueID: json[Strings.DB_UNIQUE_ID],
    );
  }
}
