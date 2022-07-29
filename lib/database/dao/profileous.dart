import 'package:deepaprakasar/resources/texts/strings.dart';

class OusUser {
  final String firstName;
  final String lastName;
  final String gender;
  final String dateOfBirth;
  final String ailmentShortDesc;
  final String contactNumber;
  final String whatsAppNumber;
  final String uniqueId;

  OusUser(
      {required this.firstName,
      required this.lastName,
      required this.gender,
      required this.dateOfBirth,
      required this.ailmentShortDesc,
      required this.contactNumber,
      required this.whatsAppNumber,
      required this.uniqueId});

  factory OusUser.fromJson(Map<String, dynamic> json) {
    return OusUser(
      firstName: json[Strings.DB_FIRST_NAME],
      lastName: json[Strings.DB_LAST_NAME],
      gender: json[Strings.DB_GENDER],
      ailmentShortDesc: json[Strings.DB_AILMENT_SHORT_DESC],
      contactNumber: json[Strings.DB_CONTACT_NUMBER],
      whatsAppNumber: json[Strings.DB_WHATS_APP_NUMBER],
      uniqueId: json[Strings.DB_UNIQUE_ID],
      dateOfBirth: json[Strings.DB_DATE_OF_BIRTH],
    );
  }
}
