import 'package:deepaprakasar/resources/texts/strings.dart';

class DeepaPrakasarPerformance {
  final String totalUsers;
  final String matriIyengarMale;
  final String matriIyengarFemale;
  final String matriIyerMale;
  final String matriIyerFemale;
  final String matriMadhvaMale;
  final String matriMadhvaFemale;
  final String matriTeluguMale;
  final String matriTeluguFemale;
  final String matriKannadaMale;
  final String matriKannadaFemale;
  final String matriMalayalamMale;
  final String matriMalayalamFemale;
  final String vedhaKaryalayam;
  final String oushadhalayamAppointment;
  final String marriageMaduraMatri;
  final String marriageOtherMatri;

  DeepaPrakasarPerformance(
      {required this.totalUsers,
      required this.matriIyengarMale,
      required this.matriIyengarFemale,
      required this.matriIyerMale,
      required this.matriIyerFemale,
      required this.matriMadhvaMale,
      required this.matriMadhvaFemale,
      required this.matriTeluguMale,
      required this.matriTeluguFemale,
      required this.matriKannadaMale,
      required this.matriKannadaFemale,
      required this.matriMalayalamMale,
      required this.matriMalayalamFemale,
      required this.vedhaKaryalayam,
      required this.oushadhalayamAppointment,
      required this.marriageMaduraMatri,
      required this.marriageOtherMatri});

  factory DeepaPrakasarPerformance.fromJson(Map<String, dynamic> json) {
    return DeepaPrakasarPerformance(
      totalUsers: json[Strings.DB_TOTAL_USERS],
      matriIyengarMale: json[Strings.DB_IYENGAR_MALE],
      matriIyengarFemale: json[Strings.DB_IYENGAR_FEMALE],
      matriIyerMale: json[Strings.DB_IYER_MALE],
      matriIyerFemale: json[Strings.DB_IYER_FEMALE],
      matriMadhvaMale: json[Strings.DB_MADHVA_MALE],
      matriMadhvaFemale: json[Strings.DB_MADHVA_FEMALE],
      matriTeluguMale: json[Strings.DB_TELUGU_MALE],
      matriTeluguFemale: json[Strings.DB_TELUGU_FEMALE],
      matriKannadaMale: json[Strings.DB_KANNADA_MALE],
      matriKannadaFemale: json[Strings.DB_KANNADA_FEMALE],
      matriMalayalamMale: json[Strings.DB_MALAYALAM_MALE],
      matriMalayalamFemale: json[Strings.DB_MALAYALAM_FEMALE],
      vedhaKaryalayam: json[Strings.DB_VEDHAKARYALAYAM],
      oushadhalayamAppointment: json[Strings.DB_OUSHADHALAYAM_APPOINTMENT],
      marriageMaduraMatri: json[Strings.DB_MARRIAGE_VIA_MMM],
      marriageOtherMatri: json[Strings.DB_MARRIAGE_VIA_OMM],
    );
  }
}
