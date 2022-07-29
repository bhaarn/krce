import 'package:deepaprakasar/resources/texts/strings.dart';

class ProfileMmm {
  final String firstName;
  final String lastName;
  final String motherName;
  final String gender;
  final String birthDateTime;
  final String placeOfBirth;
  final String maritalStatus;
  final String sect;
  final String subsect;
  final String gothram;
  final String soothram;
  final String vedham;
  final String acharyan;
  final String star;
  final String padham;
  final String rasi;
  final String nativeCity;
  final String qualification;
  final String presentCity;
  final String occupation;
  final String salary;
  final String heightCm;
  final String heightInch;
  final String weight;
  final String siblings;
  final String contactNumber;
  final String whatsAppNumber;
  final String expectation;
  final String uniqueId;
  final String registeredBy;
  final String preference;
  final String birthDateTimeFormatted;

  ProfileMmm(
      {required this.firstName,
      required this.lastName,
      required this.motherName,
      required this.gender,
      required this.birthDateTime,
      required this.placeOfBirth,
      required this.maritalStatus,
      required this.sect,
      required this.subsect,
      required this.gothram,
      required this.soothram,
      required this.vedham,
      required this.acharyan,
      required this.star,
      required this.padham,
      required this.rasi,
      required this.nativeCity,
      required this.qualification,
      required this.presentCity,
      required this.occupation,
      required this.salary,
      required this.heightCm,
      required this.heightInch,
      required this.weight,
      required this.siblings,
      required this.contactNumber,
      required this.whatsAppNumber,
      required this.expectation,
      required this.uniqueId,
      required this.registeredBy,
      required this.preference,
      required this.birthDateTimeFormatted});

  factory ProfileMmm.fromJson(Map<String, dynamic> json) {
    return ProfileMmm(
      firstName: json[Strings.DB_FIRST_NAME],
      lastName: json[Strings.DB_LAST_NAME],
      motherName: json[Strings.DB_MOTHER_NAME],
      gender: json[Strings.DB_GENDER],
      birthDateTime: json[Strings.DB_BIRTH_DATE_TIME],
      placeOfBirth: json[Strings.DB_PLACE_OF_BIRTH],
      maritalStatus: json[Strings.DB_MARITAL_STATUS],
      sect: json[Strings.DB_SECT],
      subsect: json[Strings.DB_SUB_SECT],
      gothram: json[Strings.DB_GOTHRAM],
      soothram: json[Strings.DB_SOOTHRAM],
      vedham: json[Strings.DB_VEDHAM],
      acharyan: json[Strings.DB_ACHARYAN],
      star: json[Strings.DB_STAR],
      padham: json[Strings.DB_PADHAM],
      rasi: json[Strings.DB_RASI],
      nativeCity: json[Strings.DB_NATIVE_CITY],
      qualification: json[Strings.DB_QUALIFICATION],
      presentCity: json[Strings.DB_PRESENT_CITY],
      occupation: json[Strings.DB_OCCUPATION],
      salary: json[Strings.DB_SALARY],
      heightCm: json[Strings.DB_HEIGHT_CM],
      heightInch: json[Strings.DB_HEIGHT_INCH],
      weight: json[Strings.DB_WEIGHT],
      siblings: json[Strings.DB_SIBLINGS],
      contactNumber: json[Strings.DB_CONTACT_NUMBER],
      whatsAppNumber: json[Strings.DB_WHATS_APP_NUMBER],
      expectation: json[Strings.DB_EXPECTATION],
      uniqueId: json[Strings.DB_UNIQUE_ID],
      registeredBy: json[Strings.DB_REGISTERED_BY],
      preference: json[Strings.DB_PREFERENCE],
      birthDateTimeFormatted: json[Strings.DB_BIRTH_DATE_TIME_FORMATTED],
    );
  }
}
