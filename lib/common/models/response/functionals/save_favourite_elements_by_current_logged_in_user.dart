class SaveFavouriteElements {
  Metadata? metadata;
  List<Data>? data;
  bool? isError;
  String? message;

  SaveFavouriteElements({this.metadata, this.data, this.isError, this.message});

  SaveFavouriteElements.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? title;
  String? description;
  String? createDate;
  String? updateDate;
  bool? isActive;
  String? status;
  String? categoryName;
  String? ownerUsername;
  List<dynamic>? collaborations;
  int? commentCount;
  int? likeCount;
  int? favorites;
  bool? isLiked;
  bool? isFavorite;
  List<Comments>? comments;
  ProfileResponse? profileResponse;

  Data(
      {this.id,
      this.title,
      this.description,
      this.createDate,
      this.updateDate,
      this.isActive,
      this.status,
      this.categoryName,
      this.ownerUsername,
      this.collaborations,
      this.commentCount,
      this.likeCount,
      this.favorites,
      this.isLiked,
      this.isFavorite,
      this.comments,
      this.profileResponse});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    createDate = json["createDate"];
    updateDate = json["updateDate"];
    isActive = json["isActive"];
    status = json["status"];
    categoryName = json["categoryName"];
    ownerUsername = json["ownerUsername"];
    collaborations = json["collaborations"] ?? [];
    commentCount = json["commentCount"];
    likeCount = json["likeCount"];
    favorites = json["favorites"];
    isLiked = json["isLiked"];
    isFavorite = json["isFavorite"];
    comments = json["comments"] == null
        ? null
        : (json["comments"] as List).map((e) => Comments.fromJson(e)).toList();
    profileResponse = json["profileResponse"] == null
        ? null
        : ProfileResponse.fromJson(json["profileResponse"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["title"] = title;
    _data["description"] = description;
    _data["createDate"] = createDate;
    _data["updateDate"] = updateDate;
    _data["isActive"] = isActive;
    _data["status"] = status;
    _data["categoryName"] = categoryName;
    _data["ownerUsername"] = ownerUsername;
    if (collaborations != null) {
      _data["collaborations"] = collaborations;
    }
    _data["commentCount"] = commentCount;
    _data["likeCount"] = likeCount;
    _data["favorites"] = favorites;
    _data["isLiked"] = isLiked;
    _data["isFavorite"] = isFavorite;
    if (comments != null) {
      _data["comments"] = comments?.map((e) => e.toJson()).toList();
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

class Comments {
  int? id;
  String? commentContent;
  String? timestamp;
  List<dynamic>? inverseRootComment;
  Account? account;

  Comments(
      {this.id,
      this.commentContent,
      this.timestamp,
      this.inverseRootComment,
      this.account});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    commentContent = json["commentContent"];
    timestamp = json["timestamp"];
    inverseRootComment = json["inverseRootComment"] ?? [];
    account =
        json["account"] == null ? null : Account.fromJson(json["account"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["commentContent"] = commentContent;
    _data["timestamp"] = timestamp;
    if (inverseRootComment != null) {
      _data["inverseRootComment"] = inverseRootComment;
    }
    if (account != null) {
      _data["account"] = account?.toJson();
    }
    return _data;
  }
}

class Account {
  String? username;
  Profile? profile;

  Account({this.username, this.profile});

  Account.fromJson(Map<String, dynamic> json) {
    username = json["username"];
    profile =
        json["profile"] == null ? null : Profile.fromJson(json["profile"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["username"] = username;
    if (profile != null) {
      _data["profile"] = profile?.toJson();
    }
    return _data;
  }
}

class Profile {
  String? imageUrl;

  Profile({this.imageUrl});

  Profile.fromJson(Map<String, dynamic> json) {
    imageUrl = json["imageUrl"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
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
