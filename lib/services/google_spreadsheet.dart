import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:blnk_mobile_task/services/google_credentials.dart';

class GoogleSpreadSheet {
  final GoogleCredentials googleCredentials = GoogleCredentials();

  Future<String> insertRow(List<Object> row) async {
    try {
      var client = await googleCredentials.getHttpClient();
      var driveApi = drive.DriveApi(client);
      var sheetsApi = sheets.SheetsApi(client);

      String spreadsheetId = await _getOrCreateSpreadsheet(
          driveApi, sheetsApi, 'BLNK Mobile Task');

      String sheetName = 'Sheet1';
      String range = '$sheetName!A:G';

      var valueRange = sheets.ValueRange(
        values: [row],
      );

      await sheetsApi.spreadsheets.values.append(
        valueRange,
        spreadsheetId,
        range,
        valueInputOption: 'RAW',
      );

      return 'User Registered Successfully';
    } catch (e) {
      return 'Error';
    }
  }

  Future<String> _getOrCreateSpreadsheet(
      drive.DriveApi driveApi, sheets.SheetsApi sheetsApi, String title) async {
    try {
      var fileList = await driveApi.files.list(
        q: "mimeType='application/vnd.google-apps.spreadsheet' and name='$title'",
        spaces: 'drive',
        $fields: 'files(id, name)',
      );

      if (fileList.files != null && fileList.files!.isNotEmpty) {
        return fileList.files!.first.id!;
      } else {
        var newSpreadsheet = sheets.Spreadsheet(
          properties: sheets.SpreadsheetProperties(title: title),
          sheets: [
            sheets.Sheet(properties: sheets.SheetProperties(title: 'Sheet1'))
          ],
        );
        var createdSpreadsheet =
            await sheetsApi.spreadsheets.create(newSpreadsheet);

        List<Object> row = [
          "Full Name",
          "Mobile Number",
          "Landline",
          "Email",
          "Address",
          "National ID Front",
          "National ID Back"
        ];

        await sheetsApi.spreadsheets.values.append(
          sheets.ValueRange(
            values: [row],
          ),
          createdSpreadsheet.spreadsheetId!,
          'Sheet1!A:G',
          valueInputOption: 'RAW',
        );

        return createdSpreadsheet.spreadsheetId!;
      }
    } catch (e) {
      rethrow;
    }
  }
}
