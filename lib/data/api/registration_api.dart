import 'dart:io';
import 'package:blnk_mobile_task/services/google_drive.dart';
import 'package:blnk_mobile_task/services/google_spreadsheet.dart';

class RegistrationApi {
  Future<Map<String, dynamic>> uploadToDrive(
      String nationalIDFrontPath, String nationalIDBackPath) async {
    final GoogleDrive googleDrive = GoogleDrive();

    File nationalIDFront = File(nationalIDFrontPath);
    File nationalIDBack = File(nationalIDBackPath);

    String nationalIDFrontName =
        await googleDrive.upload('national-id-front', nationalIDFront);
    String nationalIDBackName =
        await googleDrive.upload('national-id-back', nationalIDBack);

    return {
      "nationalIDFront": nationalIDFrontName,
      "nationalIDBack": nationalIDBackName
    };
  }

  Future<dynamic> uploadToSpreadSheet(List<String> row) async {
    final GoogleSpreadSheet googleSpreadSheet = GoogleSpreadSheet();

    return await googleSpreadSheet.insertRow(row);
  }
}
