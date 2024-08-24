import 'package:blnk_mobile_task/services/secure_storage.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

const _clientId =
    '925630651091-8orn094rgthp7268t51rrkqhonebvnqa.apps.googleusercontent.com';
const _clientSecret = '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';
const _scopes = [
  ga.DriveApi.driveFileScope,
  sheets.SheetsApi.spreadsheetsScope
];

class GoogleCredentials {
  final storage = SecureStorage();

  Future<http.Client> getHttpClient() async {
    var credentials = await storage.getCredentials();
    if (credentials.isEmpty) {
      var authClient = await clientViaUserConsent(
        ClientId(_clientId, _clientSecret),
        _scopes,
        (url) {
          launchUrl(Uri.parse('$url&prompt=consent&access_type=offline'));
        },
      );
      await storage.saveCredentials(authClient.credentials.accessToken,
          authClient.credentials.refreshToken!);
      return authClient;
    } else {
      return authenticatedClient(
        http.Client(),
        AccessCredentials(
            AccessToken(
              credentials["type"],
              credentials["data"],
              DateTime.tryParse(credentials["expiry"])!,
            ),
            credentials["refreshToken"],
            _scopes),
      );
    }
  }
}
