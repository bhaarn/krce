import 'package:deepaprakasar/resources/texts/strings.dart';

class PinCode {
  final String pinCode;

  PinCode({required this.pinCode});

  factory PinCode.fromJson(Map<String, dynamic> json) {
    return PinCode(
      pinCode: json[Strings.DB_PIN_CODE],
    );
  }
}
