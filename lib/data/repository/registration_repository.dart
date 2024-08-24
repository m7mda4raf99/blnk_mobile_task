import 'package:blnk_mobile_task/data/api/registration_api.dart';

class RegistrationRepository {
  final RegistrationApi registrationApi;

  RegistrationRepository(this.registrationApi);

  Future<Map<String, dynamic>> uploadToDrive(
      String nationalIDFront, String nationalIDBack) async {
    return await registrationApi.uploadToDrive(nationalIDFront, nationalIDBack);
  }

  Future<String> uploadToSpreadSheet(List<String> row) async {
    return await registrationApi.uploadToSpreadSheet(row);
  }
}
