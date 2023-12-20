
class ResultPackageBuying {
    Status? status;
    Data? data;

    ResultPackageBuying({this.status, this.data});

    ResultPackageBuying.fromJson(Map<String, dynamic> json) {
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
    String? startDate;
    String? endDate;
    Package? package;
    Customer? customer;

    Data({this.startDate, this.endDate, this.package, this.customer});

    Data.fromJson(Map<String, dynamic> json) {
        startDate = json["startDate"];
        endDate = json["endDate"];
        package = json["package"] == null ? null : Package.fromJson(json["package"]);
        customer = json["customer"] == null ? null : Customer.fromJson(json["customer"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["startDate"] = startDate;
        _data["endDate"] = endDate;
        if(package != null) {
            _data["package"] = package?.toJson();
        }
        if(customer != null) {
            _data["customer"] = customer?.toJson();
        }
        return _data;
    }
}

class Customer {
    String? username;
    String? role;

    Customer({this.username, this.role});

    Customer.fromJson(Map<String, dynamic> json) {
        username = json["username"];
        role = json["role"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["username"] = username;
        _data["role"] = role;
        return _data;
    }
}

class Package {
    String? name;
    double? price;
    int? duration;

    Package({this.name, this.price, this.duration});

    Package.fromJson(Map<String, dynamic> json) {
        name = json["name"];
        price = json["price"];
        duration = json["duration"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["name"] = name;
        _data["price"] = price;
        _data["duration"] = duration;
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