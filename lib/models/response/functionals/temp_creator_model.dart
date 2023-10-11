class AllCreatorsTempModel {
  Metadata? metadata;
  List<Data>? data;
  bool? isError;
  String? message;

  AllCreatorsTempModel({this.metadata, this.data, this.isError, this.message});

  AllCreatorsTempModel.fromJson(Map<String, dynamic> json) {
    metadata =
        json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]);
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    isError = json["isError"];
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (metadata != null) {
      _data["metadata"] = metadata?.toJson();
    }
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    _data["isError"] = isError;
    _data["message"] = message;
    return _data;
  }
}

class Data {
  String? id;
  int? roleId;
  String? username;
  String? email;
  bool? isActive;
  int? profileId;
  List<dynamic>? followFollowers;
  String? followFollowings;
  ProfileResponse? profileResponse;

  Data(
      {this.id,
      this.roleId,
      this.username,
      this.email,
      this.isActive,
      this.profileId,
      this.followFollowers,
      this.followFollowings,
      this.profileResponse});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    roleId = json["roleId"];
    username = json["username"];
    email = json["email"];
    isActive = json["isActive"];
    profileId = json["profileId"];
    followFollowers = json["followFollowers"] ?? [];
    followFollowings = json["followFollowings"];
    profileResponse = json["profileResponse"] == null
        ? null
        : ProfileResponse.fromJson(json["profileResponse"]);
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
    if (profileResponse != null) {
      _data["profileResponse"] = profileResponse?.toJson();
    }
    return _data;
  }
}

class ProfileResponse {
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

  ProfileResponse(
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

  ProfileResponse.fromJson(Map<String, dynamic> json) {
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

class Metadata {
  int? page;
  int? size;
  int? total;

  Metadata({this.page, this.size, this.total});

  Metadata.fromJson(Map<String, dynamic> json) {
    page = json["page"];
    size = json["size"];
    total = json["total"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["page"] = page;
    _data["size"] = size;
    _data["total"] = total;
    return _data;
  }
}
