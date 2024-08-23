class User {
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? landline;
  String? email;
  String? address;
  String? nationalIDFront;
  String? nationalIDBack;

  User();

  User.fromJson(Map<String, dynamic> json) {
    firstName = json["first_name"];
    lastName = json["last_name"];
    mobileNumber = json["mobile_number"];
    landline = json["landline"];
    email = json["email"];
    address = json["address"];
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
    data["address"] = address;
    data["national_id_front"] = nationalIDFront;
    data["national_id_back"] = nationalIDBack;

    return data;
  }
}
