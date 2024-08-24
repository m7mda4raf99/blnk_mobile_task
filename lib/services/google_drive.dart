import 'dart:io';
import 'package:blnk_mobile_task/services/google_credentials.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:path/path.dart' as p;

class GoogleDrive {
  Future<String> upload(File file) async {
    try {
      GoogleCredentials googleCredentials = GoogleCredentials();
      var client = await googleCredentials.getHttpClient();
      var drive = ga.DriveApi(client);

      var response = await drive.files.create(
          ga.File()..name = p.basename(file.absolute.path),
          uploadMedia: ga.Media(file.openRead(), file.lengthSync()));

      return response.toJson()['name'];
    } catch (e) {
      return 'Error $e';
    }
  }
}
