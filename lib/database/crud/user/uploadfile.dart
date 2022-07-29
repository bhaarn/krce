import 'dart:async';
import 'dart:convert';

import 'package:deepaprakasar/database/dao/status.dart';
import 'package:deepaprakasar/resources/texts/strings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

Future<Status> uploadFile(
    PlatformFile file, String userName, String departmentName) async {
  final request = http.MultipartRequest(Strings.POST,
    Uri.parse(Strings.TRANSPORT_PROTOCOL + Strings.WEB_CONNECTOR + Strings.BACK_SLASH +
        Strings.BACKEND + Strings.BE_FILE_USR_FILE_UPLOAD),
  );
  request.fields[Strings.DEPARTMENT] = departmentName;
  request.fields[Strings.DB_REGISTERED_BY] = userName;
  request.files.add(new http.MultipartFile(
      Strings.DET_VAT_UPLOAD_FILE, file.readStream!, file.size!,
      filename: file.name));
  var resp = await request.send();
  String result = await resp.stream.bytesToString();
  return Status.fromJson(jsonDecode(result));
}
