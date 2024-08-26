import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleHttpClient extends http.BaseClient {
  final Map<String, String> headers;

  final http.Client _inner = http.Client();

  GoogleHttpClient(this.headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _inner.send(request..headers.addAll(headers));
  }

  @override
  void close() {
    _inner.close();
  }
}

class HTTPClient {
  GoogleHttpClient? client;

  Future<dynamic> getClient() async {
    if (client != null) {
      return client!;
    }

    final googleAuthData = await GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/drive',
        'https://www.googleapis.com/auth/spreadsheets',
      ],
    ).signIn();

    if (googleAuthData == null) {
      return null;
    }

    client = GoogleHttpClient(await googleAuthData.authHeaders);
    return client;
  }
}
