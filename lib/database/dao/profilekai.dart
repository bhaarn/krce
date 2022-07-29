import 'package:deepaprakasar/resources/texts/strings.dart';

class ProfileKai {
  final String kainkaryam;
  final String subKainkaryam;
  final String type;
  final String details;
  final String contactNumber;
  final String whatsAppNumber;
  final String uniqueID;
  final String requiredDate;
  final String requiredDateFormatted;

  ProfileKai({required this.kainkaryam,
      required this.subKainkaryam,
      required this.type,
      required this.details,
      required this.contactNumber,
      required this.whatsAppNumber,
      required this.uniqueID,
      required this.requiredDate,
      required this.requiredDateFormatted});

  factory ProfileKai.fromJson(Map<String, dynamic> json) {
    return ProfileKai(
      kainkaryam: json[Strings.DB_KAINKARYAM],
      subKainkaryam: json[Strings.DB_SUB_KAINKARYAM],
      type: json[Strings.DB_KAI_TYPE],
      details: json[Strings.DB_DETAILS],
      contactNumber: json[Strings.DB_CONTACT_NUMBER],
      whatsAppNumber: json[Strings.DB_WHATS_APP_NUMBER],
      uniqueID: json[Strings.DB_UNIQUE_ID],
      requiredDate: json[Strings.DB_REQUIRED_DATE],
      requiredDateFormatted: json[Strings.DB_REQUIRED_DATE_FORMATTED]
    );
  }
}
