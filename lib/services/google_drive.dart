import 'package:blnk_mobile_task/services/google_http_client.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class GoogleDrive {
  DriveApi? driveApi;

  static const folderName = "Blnk Mobile Task";
  static const folderMime = "application/vnd.google-apps.folder";

  Future<void> setDrive() async {
    HTTPClient httpClient = HTTPClient();
    final client = await httpClient.getClient();
    driveApi = DriveApi(client);
  }

  Future<String> upload(io.File localFile, String direction) async {
    try {
      await setDrive();

      final File gDriveFile = File();
      gDriveFile.name = '$direction-${basename(localFile.absolute.path)}';

      final existingFile = await _isFileExist(gDriveFile.name!);

      if (existingFile != null) {
        await driveApi!.files.update(gDriveFile, existingFile.id!,
            uploadMedia: Media(localFile.openRead(), localFile.lengthSync()));

        return gDriveFile.name!;
      }

      final folderId = await _folderId();
      gDriveFile.parents = [folderId!];

      await driveApi!.files.create(
        gDriveFile,
        uploadMedia: Media(localFile.openRead(), localFile.lengthSync()),
      );

      return gDriveFile.name!;
    } catch (e) {
      return 'Error $e';
    }
  }

  Future<File> _createNewFolder() async {
    final File folder = File();
    folder.name = folderName;
    folder.mimeType = folderMime;
    return await driveApi!.files.create(folder);
  }

  Future<String?> _folderId() async {
    final found = await driveApi!.files.list(
      q: "mimeType = '$folderMime' and name = '$folderName'",
      $fields: "files(id, name)",
    );
    final files = found.files;

    if (files == null) {
      return null;
    }
    if (files.isEmpty) {
      final newFolder = await _createNewFolder();
      return newFolder.id;
    }

    return files.first.id;
  }

  Future<File?> _isFileExist(String fileName) async {
    final folderId = await _folderId();
    if (folderId == null) {
      return null;
    }

    final query =
        "name = '$fileName' and '$folderId' in parents and trashed = false";
    final driveFileList = await driveApi!.files.list(
      q: query,
      spaces: 'drive',
      $fields: 'files(id, name, mimeType, parents)',
    );

    if (driveFileList.files == null || driveFileList.files!.isEmpty) {
      return null;
    }

    return driveFileList.files!.first;
  }
}
