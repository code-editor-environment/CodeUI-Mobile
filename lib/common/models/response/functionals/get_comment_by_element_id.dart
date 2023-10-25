class GetCommentAndReplyByElementsId {
  Metadata? metadata;
  List<Data>? data;
  bool? isError;
  String? message;

  GetCommentAndReplyByElementsId(
      {this.metadata, this.data, this.isError, this.message});

  GetCommentAndReplyByElementsId.fromJson(Map<String, dynamic> json) {
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
  String? commentContent;
  String? timestamp;
  List<InverseRootComment>? inverseRootComment;
  Account1? account;

  Data(
      {this.id,
      this.commentContent,
      this.timestamp,
      this.inverseRootComment,
      this.account});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    commentContent = json["commentContent"];
    timestamp = json["timestamp"];
    inverseRootComment = json["inverseRootComment"] == null
        ? null
        : (json["inverseRootComment"] as List)
            .map((e) => InverseRootComment.fromJson(e))
            .toList();
    account =
        json["account"] == null ? null : Account1.fromJson(json["account"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["commentContent"] = commentContent;
    _data["timestamp"] = timestamp;
    if (inverseRootComment != null) {
      _data["inverseRootComment"] =
          inverseRootComment?.map((e) => e.toJson()).toList();
    }
    if (account != null) {
      _data["account"] = account?.toJson();
    }
    return _data;
  }
}

class Account1 {
  String? username;
  Profile1? profile;

  Account1({this.username, this.profile});

  Account1.fromJson(Map<String, dynamic> json) {
    username = json["username"];
    profile =
        json["profile"] == null ? null : Profile1.fromJson(json["profile"]);
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

class Profile1 {
  String? imageUrl;

  Profile1({this.imageUrl});

  Profile1.fromJson(Map<String, dynamic> json) {
    imageUrl = json["imageUrl"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["imageUrl"] = imageUrl;
    return _data;
  }
}

class InverseRootComment {
  int? id;
  String? commentContent;
  String? timestamp;
  String? inverseRootComment;
  Account? account;

  InverseRootComment(
      {this.id,
      this.commentContent,
      this.timestamp,
      this.inverseRootComment,
      this.account});

  InverseRootComment.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    commentContent = json["commentContent"];
    timestamp = json["timestamp"];
    inverseRootComment = json["inverseRootComment"];
    account =
        json["account"] == null ? null : Account.fromJson(json["account"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["commentContent"] = commentContent;
    _data["timestamp"] = timestamp;
    _data["inverseRootComment"] = inverseRootComment;
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
