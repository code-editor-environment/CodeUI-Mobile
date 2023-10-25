class ViewProfileResponse {
  Status? status;
  Data? data;

  ViewProfileResponse({this.status, this.data});

  ViewProfileResponse.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? role;
  String? username;
  String? email;
  bool? isActive;
  int? profileId;
  List<Followers>? followers;
  List<dynamic>? followings;
  ProfileResponse? profileResponse;

  Data(
      {this.id,
      this.role,
      this.username,
      this.email,
      this.isActive,
      this.profileId,
      this.followers,
      this.followings,
      this.profileResponse});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    role = json["role"];
    username = json["username"];
    email = json["email"];
    isActive = json["isActive"];
    profileId = json["profileId"];
    followers = json["followers"] == null
        ? null
        : (json["followers"] as List)
            .map((e) => Followers.fromJson(e))
            .toList();
    followings = json["followings"] ?? [];
    profileResponse = json["profileResponse"] == null
        ? null
        : ProfileResponse.fromJson(json["profileResponse"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["role"] = role;
    _data["username"] = username;
    _data["email"] = email;
    _data["isActive"] = isActive;
    _data["profileId"] = profileId;
    if (followers != null) {
      _data["followers"] = followers?.map((e) => e.toJson()).toList();
    }
    if (followings != null) {
      _data["followings"] = followings;
    }
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
  bool? isFollow;
  int? totalFollower;
  int? totalFollowing;
  int? totalApprovedElement;

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
      this.imageUrl,
      this.isFollow,
      this.totalFollower,
      this.totalFollowing,
      this.totalApprovedElement});

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
    isFollow = json["isFollow"];
    totalFollower = json["totalFollower"];
    totalFollowing = json["totalFollowing"];
    totalApprovedElement = json["totalApprovedElement"];
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
    _data["isFollow"] = isFollow;
    _data["totalFollower"] = totalFollower;
    _data["totalFollowing"] = totalFollowing;
    _data["totalApprovedElement"] = totalApprovedElement;
    return _data;
  }
}

class Followers {
  String? followerId;
  String? followId;

  Followers({this.followerId, this.followId});

  Followers.fromJson(Map<String, dynamic> json) {
    followerId = json["followerId"];
    followId = json["followId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["followerId"] = followerId;
    _data["followId"] = followId;
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
