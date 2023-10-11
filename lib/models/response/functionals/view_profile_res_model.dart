class ViewSpecificProfileResponse {
  Status? status;
  Data? data;

  ViewSpecificProfileResponse({this.status, this.data});

  ViewSpecificProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json["status"] == null ? null : Status.fromJson(json["status"]);
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (status != null) {
      _data["status"] = status?.toJson();
    }
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  String? accountId;
  String? username;
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? phone;
  String? gender;
  String? location;
  String? description;
  double? wallet;
  String? imageUrl;

  Data(
      {this.accountId,
      this.username,
      this.firstName,
      this.lastName,
      this.dateOfBirth,
      this.phone,
      this.gender,
      this.location,
      this.description,
      this.wallet,
      this.imageUrl});

  Data.fromJson(Map<String, dynamic> json) {
    accountId = json["accountID"];
    username = json["username"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    dateOfBirth = json["dateOfBirth"];
    phone = json["phone"];
    gender = json["gender"];
    location = json["location"];
    description = json["description"];
    wallet = json["wallet"];
    imageUrl = json["imageUrl"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["accountID"] = accountId;
    _data["username"] = username;
    _data["firstName"] = firstName;
    _data["lastName"] = lastName;
    _data["dateOfBirth"] = dateOfBirth;
    _data["phone"] = phone;
    _data["gender"] = gender;
    _data["location"] = location;
    _data["description"] = description;
    _data["wallet"] = wallet;
    _data["imageUrl"] = imageUrl;
    return _data;
  }
}

class Status {
  bool? success;
  String? message;
  int? errorCode;

  Status({this.success, this.message, this.errorCode});

  Status.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    message = json["message"];
    errorCode = json["errorCode"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    _data["message"] = message;
    _data["errorCode"] = errorCode;
    return _data;
  }
}
