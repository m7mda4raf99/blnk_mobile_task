import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:blnk_mobile_task/services/google_http_client.dart';

class GoogleSpreadsheet {
  sheets.SheetsApi? sheetsApi;
  drive.DriveApi? driveApi;

  static const spreadsheetTitle = "Blnk Mobile Task Spreadsheet";

  Future<void> initializeApis() async {
    HTTPClient httpClient = HTTPClient();
    final client = await httpClient.getClient();

    sheetsApi = sheets.SheetsApi(client);
    driveApi = drive.DriveApi(client);
  }

  Future<String> insertRow(List<Object> row) async {
    try {
      await initializeApis();

      final spreadsheetId = await _getOrCreateSpreadsheet(spreadsheetTitle);

      String sheetName = 'Sheet1';

      String range = '$sheetName!A:${String.fromCharCode(65 + row.length - 1)}';

      var valueRange = sheets.ValueRange(
        values: [row],
      );

      await sheetsApi!.spreadsheets.values.append(
        valueRange,
        spreadsheetId,
        range,
        valueInputOption: 'RAW',
      );

      return 'User Registered Successfully';
    } catch (e) {
      return 'Error $e';
    }
  }

  Future<String> _getOrCreateSpreadsheet(String title) async {
    try {
      var fileList = await driveApi!.files.list(
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
            await sheetsApi!.spreadsheets.create(newSpreadsheet);

        List<Object> headerRow = [
          "Full Name",
          "Mobile Number",
          "Landline",
          "Email",
          "Address",
          "National ID Front",
          "National ID Back"
        ];

        await sheetsApi!.spreadsheets.values.append(
          sheets.ValueRange(values: [headerRow]),
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
