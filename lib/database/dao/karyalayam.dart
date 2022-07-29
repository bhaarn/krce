import 'package:deepaprakasar/resources/texts/strings.dart';

class Karyalayam {
  final String job;
  final String expiryDate;
  final String jobId;

  Karyalayam(
      {required this.job, required this.expiryDate, required this.jobId});

  factory Karyalayam.fromJson(Map<String, dynamic> json) {
    return Karyalayam(
        job: json[Strings.DB_JOB],
        expiryDate: json[Strings.DB_LAST_DATE],
        jobId: json[Strings.DB_JOB_ID]);
  }
}
