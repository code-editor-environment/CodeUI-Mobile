class GetRequestById {
  Status? status;
  Data? data;

  GetRequestById({this.status, this.data});

  GetRequestById.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? requestDescription;
  String? status;
  double? reward;
  String? createBy;
  String? requesterName;
  String? receiveBy;
  String? receiverName;
  String? name;
  double? deposit;
  String? startDate;
  int? deadline;
  String? imageUrl1;
  String? imageUrl2;
  String? imageUrl3;
  String? categoryName;
  String? avatar;
  String? typeCss;
  bool? isAccepted;

  Data(
      {this.id,
      this.requestDescription,
      this.status,
      this.reward,
      this.createBy,
      this.requesterName,
      this.receiveBy,
      this.receiverName,
      this.name,
      this.deposit,
      this.startDate,
      this.deadline,
      this.imageUrl1,
      this.imageUrl2,
      this.imageUrl3,
      this.categoryName,
      this.avatar,
      this.typeCss,
      this.isAccepted});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    requestDescription = json["requestDescription"];
    status = json["status"];
    reward = json["reward"];
    createBy = json["createBy"];
    requesterName = json["requesterName"];
    receiveBy = json["receiveBy"];
    receiverName = json["receiverName"];
    name = json["name"];
    deposit = json["deposit"];
    startDate = json["startDate"];
    deadline = json["deadline"];
    imageUrl1 = json["imageUrl1"];
    imageUrl2 = json["imageUrl2"];
    imageUrl3 = json["imageUrl3"];
    categoryName = json["categoryName"];
    avatar = json["avatar"];
    typeCss = json["typeCss"];
    isAccepted = json["isAccepted"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["requestDescription"] = requestDescription;
    _data["status"] = status;
    _data["reward"] = reward;
    _data["createBy"] = createBy;
    _data["requesterName"] = requesterName;
    _data["receiveBy"] = receiveBy;
    _data["receiverName"] = receiverName;
    _data["name"] = name;
    _data["deposit"] = deposit;
    _data["startDate"] = startDate;
    _data["deadline"] = deadline;
    _data["imageUrl1"] = imageUrl1;
    _data["imageUrl2"] = imageUrl2;
    _data["imageUrl3"] = imageUrl3;
    _data["categoryName"] = categoryName;
    _data["avatar"] = avatar;
    _data["typeCss"] = typeCss;
    _data["isAccepted"] = isAccepted;
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
