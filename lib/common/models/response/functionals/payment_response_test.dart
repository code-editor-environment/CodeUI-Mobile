
class CreateSandBoxPaymentTestResponse {
    Status? status;
    Data? data;

    CreateSandBoxPaymentTestResponse({this.status, this.data});

    CreateSandBoxPaymentTestResponse.fromJson(Map<String, dynamic> json) {
        status = json["status"] == null ? null : Status.fromJson(json["status"]);
        data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(status != null) {
            _data["status"] = status?.toJson();
        }
        if(data != null) {
            _data["data"] = data?.toJson();
        }
        return _data;
    }
}

class Data {
    String? status;
    String? message;
    String? paymentUrl;
    String? paymentMethod;

    Data({this.status, this.message, this.paymentUrl, this.paymentMethod});

    Data.fromJson(Map<String, dynamic> json) {
        status = json["status"];
        message = json["message"];
        paymentUrl = json["paymentUrl"];
        paymentMethod = json["paymentMethod"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["status"] = status;
        _data["message"] = message;
        _data["paymentUrl"] = paymentUrl;
        _data["paymentMethod"] = paymentMethod;
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