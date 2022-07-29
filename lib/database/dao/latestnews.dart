import 'package:deepaprakasar/resources/texts/strings.dart';

class LatestNews {
  final String maleName;
  final String femaleName;
  final String marriageDate;
  final String marriageDetails;
  final String marriagePhoto;

  LatestNews(
      {required this.maleName,
      required this.femaleName,
      required this.marriageDate,
      required this.marriageDetails,
      required this.marriagePhoto});

  factory LatestNews.fromJson(Map<String, dynamic> json) {
    return LatestNews(
      maleName: json[Strings.DB_MALE_NAME],
      femaleName: json[Strings.DB_FEMALE_NAME],
      marriageDate: json[Strings.DB_MARRIAGE_DATE],
      marriageDetails: json[Strings.DB_MARRIAGE_DETAILS],
      marriagePhoto: json[Strings.DB_MARRIAGE_PHOTO],
    );
  }
}
