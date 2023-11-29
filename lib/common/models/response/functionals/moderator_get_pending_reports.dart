
class ModeratorGetPendingElementReports {
    Metadata? metadata;
    List<Data>? data;
    bool? isError;
    String? message;

    ModeratorGetPendingElementReports({this.metadata, this.data, this.isError, this.message});

    ModeratorGetPendingElementReports.fromJson(Map<String, dynamic> json) {
        metadata = json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]);
        data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
        isError = json["isError"];
        message = json["message"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        if(metadata != null) {
            _data["metadata"] = metadata?.toJson();
        }
        if(data != null) {
            _data["data"] = data?.map((e) => e.toJson()).toList();
        }
        _data["isError"] = isError;
        _data["message"] = message;
        return _data;
    }
}

class Data {
    String? categoryName;
    String? userName;
    int? elementId;
    int? totalReport;

    Data({this.categoryName, this.userName, this.elementId, this.totalReport});

    Data.fromJson(Map<String, dynamic> json) {
        categoryName = json["categoryName"];
        userName = json["userName"];
        elementId = json["elementId"];
        totalReport = json["totalReport"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["categoryName"] = categoryName;
        _data["userName"] = userName;
        _data["elementId"] = elementId;
        _data["totalReport"] = totalReport;
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