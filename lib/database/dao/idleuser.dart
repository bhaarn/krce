import 'package:deepaprakasar/resources/texts/strings.dart';

class IdleUser {
  final String firstName;
  final String lastName;
  final String userName;
  final String contactNumber;

  IdleUser(
      {required this.firstName,
      required this.lastName,
      required this.userName,
      required this.contactNumber});

  factory IdleUser.fromJson(Map<String, dynamic> json) {
    return IdleUser(
      firstName: json[Strings.DB_FIRST_NAME],
      lastName: json[Strings.DB_LAST_NAME],
      userName: json[Strings.DB_USER_NAME],
      contactNumber: json[Strings.DB_CONTACT_NUMBER],
    );
  }
}
