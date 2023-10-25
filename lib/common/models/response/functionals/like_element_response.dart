class LikeElement {
  Status? status;
  Data? data;

  LikeElement({this.status, this.data});

  LikeElement.fromJson(Map<String, dynamic> json) {
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
  String? timestamp;
  String? action;
  int? elementId;
  String? accountId;

  Data({this.timestamp, this.action, this.elementId, this.accountId});

  Data.fromJson(Map<String, dynamic> json) {
    timestamp = json["timestamp"];
    action = json["action"];
    elementId = json["elementId"];
    accountId = json["accountId"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["timestamp"] = timestamp;
    _data["action"] = action;
    _data["elementId"] = elementId;
    _data["accountId"] = accountId;
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
