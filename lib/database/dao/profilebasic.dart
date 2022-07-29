import 'package:deepaprakasar/resources/texts/strings.dart';

class ProfileBasic {
  final String firstName;
  final String lastName;
  final String sect;
  final String subsect;
  final String gothram;
  final String soothram;
  final String vedham;
  final String acharyan;
  final String contactNumber;

  ProfileBasic(
      {required this.firstName,
      required this.lastName,
      required this.sect,
      required this.subsect,
      required this.gothram,
      required this.soothram,
      required this.vedham,
      required this.acharyan,
      required this.contactNumber});

  factory ProfileBasic.fromJson(Map<String, dynamic> json) {
    return ProfileBasic(
      firstName: json[Strings.DB_FIRST_NAME],
      lastName: json[Strings.DB_LAST_NAME],
      sect: json[Strings.DB_SECT],
      subsect: json[Strings.DB_SUB_SECT],
      gothram: json[Strings.DB_GOTHRAM],
      soothram: json[Strings.DB_SOOTHRAM],
      vedham: json[Strings.DB_VEDHAM],
      acharyan: json[Strings.DB_ACHARYAN],
      contactNumber: json[Strings.DB_CONTACT_NUMBER],
    );
  }
}
