import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  String get username => _sharedPrefs!.getString(keyUsername) ?? Strings.EMPTY_STRING;

  bool get fingerprint => _sharedPrefs!.getBool(keyFingerPrint) ?? false;

  String get role => _sharedPrefs!.getString(keyRole) ?? Strings.ROLE_USR;

  set username(String value) {
    _sharedPrefs!.setString(keyUsername, value);
  }

  set fingerprint(bool value) {
    _sharedPrefs!.setBool(keyFingerPrint, value);
  }

  set role(String value) {
    _sharedPrefs!.setString(keyRole, value);
  }
}

final sharedPrefs = SharedPrefs();
const String keyUsername = Strings.SHARED_PREF_USER_NAME;
const String keyFingerPrint = Strings.SHARED_PREF_FINGER_PRINT;
const String keyRole = Strings.SHARED_PREF_ROLE;
