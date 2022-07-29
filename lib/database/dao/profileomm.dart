import 'package:deepaprakasar/resources/texts/strings.dart';

class ProfileOmm {
  final String profile;
  final String uniqueId;

  ProfileOmm({required this.profile, required this.uniqueId});

  factory ProfileOmm.fromJson(Map<String, dynamic> json) {
    return ProfileOmm(
      profile: json[Strings.DB_PROFILE],
      uniqueId: json[Strings.DB_UNIQUE_ID],
    );
  }
}
