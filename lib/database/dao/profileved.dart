import 'package:deepaprakasar/resources/texts/strings.dart';

class ProfileVed {
  final String firstName;
  final String lastName;
  final String gender;
  final String sect;
  final String subsect;
  final String gothram;
  final String soothram;
  final String vedham;
  final String acharyan;
  final String qualification;
  final String presentCity;
  final String address;
  final String occupation;
  final String jobStatus;
  final String contactNumber;
  final String whatsAppNumber;
  final String photoPath;
  final String uniqueID;

  ProfileVed(
      {required this.firstName,
      required this.lastName,
      required this.gender,
      required this.sect,
      required this.subsect,
      required this.gothram,
      required this.soothram,
      required this.vedham,
      required this.acharyan,
      required this.qualification,
      required this.presentCity,
      required this.address,
      required this.occupation,
      required this.jobStatus,
      required this.contactNumber,
      required this.whatsAppNumber,
      required this.photoPath,
      required this.uniqueID});

  factory ProfileVed.fromJson(Map<String, dynamic> json) {
    return ProfileVed(
      firstName: json[Strings.DB_FIRST_NAME],
      lastName: json[Strings.DB_LAST_NAME],
      gender: json[Strings.DB_GENDER],
      sect: json[Strings.DB_SECT],
      subsect: json[Strings.DB_SUB_SECT],
      gothram: json[Strings.DB_GOTHRAM],
      soothram: json[Strings.DB_SOOTHRAM],
      vedham: json[Strings.DB_VEDHAM],
      acharyan: json[Strings.DB_ACHARYAN],
      qualification: json[Strings.DB_QUALIFICATION],
      presentCity: json[Strings.DB_PRESENT_CITY],
      address: json[Strings.DB_ADDRESS],
      occupation: json[Strings.DB_OCCUPATION],
      jobStatus: json[Strings.DB_JOB_STATUS],
      contactNumber: json[Strings.DB_CONTACT_NUMBER],
      whatsAppNumber: json[Strings.DB_WHATS_APP_NUMBER],
      photoPath: json[Strings.DB_PHOTO_PATH],
      uniqueID: json[Strings.DB_UNIQUE_ID],
    );
  }
}
