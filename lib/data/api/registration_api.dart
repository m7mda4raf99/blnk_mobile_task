import 'dart:io';
import 'package:blnk_mobile_task/services/google_drive.dart';
import 'package:blnk_mobile_task/services/google_spreadsheet.dart';

class RegistrationApi {
  Future<Map<String, dynamic>> uploadToDrive(
      String nationalIDFrontPath, String nationalIDBackPath) async {
    File nationalIDFront = File(nationalIDFrontPath);
    File nationalIDBack = File(nationalIDBackPath);

    final GoogleDrive uploadDrive = GoogleDrive();

    String nationalIDFrontName =
        await uploadDrive.upload(nationalIDFront, 'national-id-front');
    String nationalIDBackName =
        await uploadDrive.upload(nationalIDBack, 'national-id-back');

    return {
      "nationalIDFront": nationalIDFrontName,
      "nationalIDBack": nationalIDBackName
    };
  }

  Future<dynamic> uploadToSpreadSheet(List<String> row) async {
    final GoogleSpreadsheet googleSpreadSheet = GoogleSpreadsheet();

    return await googleSpreadSheet.insertRow(row);
  }
}
