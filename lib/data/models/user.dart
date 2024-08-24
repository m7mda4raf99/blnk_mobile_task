import 'package:image_picker/image_picker.dart';

class User {
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? landline;
  String? email;
  String? apartment;
  String? floor;
  String? building;
  String? streetName;
  String? area;
  String? city;
  String? landMark;
  XFile? nationalIDFront;
  XFile? nationalIDBack;

  User();

  User.fromJson(Map<String, dynamic> json) {
    firstName = json["first_name"];
    lastName = json["last_name"];
    mobileNumber = json["mobile_number"];
    landline = json["landline"];
    email = json["email"];
    apartment = json["apartment"];
    floor = json["floor"];
    building = json["building"];
    streetName = json["street_name"];
    area = json["area"];
    city = json["city"];
    landMark = json["land_mark"];
    nationalIDFront = json["national_id_front"];
    nationalIDBack = json["national_id_back"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["first_name"] = firstName;
    data["last_name"] = lastName;
    data["mobile_number"] = mobileNumber;
    data["landline"] = landline;
    data["email"] = email;
    data["apartment"] = apartment;
    data["floor"] = floor;
    data["building"] = building;
    data["street_name"] = streetName;
    data["area"] = area;
    data["city"] = city;
    data["land_mark"] = landMark;
    data["national_id_front"] = nationalIDFront;
    data["national_id_back"] = nationalIDBack;

    return data;
  }
}
