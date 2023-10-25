class LoginResponseModel {
  Status? status;
  Data? data;

  LoginResponseModel({this.status, this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? accessToken;
  Account? account;

  Data({this.accessToken, this.account});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json["access_token"];
    account =
        json["account"] == null ? null : Account.fromJson(json["account"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["access_token"] = accessToken;
    if (account != null) {
      _data["account"] = account?.toJson();
    }
    return _data;
  }
}

class Account {
  String? id;
  int? roleId;
  String? username;
  String? email;
  bool? isActive;
  int? profileId;
  List<dynamic>? followFollowers;
  String? followFollowings;
  Profile? profile;

  Account(
      {this.id,
      this.roleId,
      this.username,
      this.email,
      this.isActive,
      this.profileId,
      this.followFollowers,
      this.followFollowings,
      this.profile});

  Account.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    roleId = json["roleId"];
    username = json["username"];
    email = json["email"];
    isActive = json["isActive"];
    profileId = json["profileId"];
    followFollowers = json["followFollowers"] ?? [];
    followFollowings = json["followFollowings"];
    profile =
        json["profile"] == null ? null : Profile.fromJson(json["profile"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["roleId"] = roleId;
    _data["username"] = username;
    _data["email"] = email;
    _data["isActive"] = isActive;
    _data["profileId"] = profileId;
    if (followFollowers != null) {
      _data["followFollowers"] = followFollowers;
    }
    _data["followFollowings"] = followFollowings;
    if (profile != null) {
      _data["profile"] = profile?.toJson();
    }
    return _data;
  }
}

class Profile {
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? phone;
  String? gender;
  String? location;
  String? description;
  double? wallet;
  String? imageUrl;

  Profile(
      {this.firstName,
      this.lastName,
      this.dateOfBirth,
      this.phone,
      this.gender,
      this.location,
      this.description,
      this.wallet,
      this.imageUrl});

  Profile.fromJson(Map<String, dynamic> json) {
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
