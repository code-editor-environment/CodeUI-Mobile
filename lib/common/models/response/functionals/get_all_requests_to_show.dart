class RequestToShowToUser {
  Metadata? metadata;
  List<Data>? data;
  bool? isError;
  String? message;

  RequestToShowToUser({this.metadata, this.data, this.isError, this.message});

  RequestToShowToUser.fromJson(Map<String, dynamic> json) {
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
  String? requestDescription;
  String? status;
  String? avatar;
  String? name;
  String? categoryName;
  double? reward;
  int? deadline;
  String? startDate;
  String? requesterId;

  Data(
      {this.id,
      this.requestDescription,
      this.status,
      this.avatar,
      this.name,
      this.categoryName,
      this.reward,
      this.deadline,
      this.startDate,
      this.requesterId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    requestDescription = json["requestDescription"];
    status = json["status"];
    avatar = json["avatar"];
    name = json["name"];
    categoryName = json["categoryName"];
    reward = json["reward"];
    deadline = json["deadline"];
    startDate = json["startDate"];
    requesterId = json["requesterId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["requestDescription"] = requestDescription;
    _data["status"] = status;
    _data["avatar"] = avatar;
    _data["name"] = name;
    _data["categoryName"] = categoryName;
    _data["reward"] = reward;
    _data["deadline"] = deadline;
    _data["startDate"] = startDate;
    _data["requesterId"] = requesterId;
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
