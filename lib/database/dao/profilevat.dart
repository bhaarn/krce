import 'package:deepaprakasar/resources/texts/strings.dart';

class ProfileVat {
  final String propertyType;
  final String pinCode;
  final String city;
  final String district;
  final String state;
  final String address;
  final String details;
  final String photoPath;
  final String propertyOperation;
  final String propertyStatus;
  final String contactNumber;
  final String whatsAppNumber;
  final String uniqueId;
  final String registeredBy;

  ProfileVat(
      {required this.propertyType,
      required this.pinCode,
      required this.city,
      required this.district,
      required this.state,
      required this.address,
      required this.details,
      required this.photoPath,
      required this.propertyOperation,
      required this.propertyStatus,
      required this.contactNumber,
      required this.whatsAppNumber,
      required this.uniqueId,
      required this.registeredBy});

  factory ProfileVat.fromJson(Map<String, dynamic> json) {
    return ProfileVat(
        propertyType: json[Strings.DB_PROPERTY_TYPE],
        pinCode: json[Strings.DB_PIN_CODE],
        city: json[Strings.DB_CITY],
        district: json[Strings.DB_DISTRICT],
        state: json[Strings.DB_STATE],
        address: json[Strings.DB_ADDRESS],
        details: json[Strings.DB_DETAILS],
        photoPath: json[Strings.DB_PHOTO_PATH],
        propertyOperation: json[Strings.DB_PROPERTY_OPERATION],
        propertyStatus: json[Strings.DB_PROPERTY_STATUS],
        contactNumber: json[Strings.DB_CONTACT_NUMBER],
        whatsAppNumber: json[Strings.DB_WHATS_APP_NUMBER],
        uniqueId: json[Strings.DB_UNIQUE_ID],
        registeredBy: json[Strings.DB_REGISTERED_BY]);
  }
}
