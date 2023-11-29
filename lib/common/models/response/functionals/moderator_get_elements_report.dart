
class ModeratorGetElementsReport {
    Metadata? metadata;
    List<Data>? data;
    bool? isError;
    String? message;

    ModeratorGetElementsReport({this.metadata, this.data, this.isError, this.message});

    ModeratorGetElementsReport.fromJson(Map<String, dynamic> json) {
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
    int? id;
    String? reportContent;
    String? reason;
    String? type;
    String? status;
    String? response;
    String? timestamp;
    List<ReportImages>? reportImages;

    Data({this.id, this.reportContent, this.reason, this.type, this.status, this.response, this.timestamp, this.reportImages});

    Data.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        reportContent = json["reportContent"];
        reason = json["reason"];
        type = json["type"];
        status = json["status"];
        response = json["response"];
        timestamp = json["timestamp"];
        reportImages = json["reportImages"] == null ? null : (json["reportImages"] as List).map((e) => ReportImages.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["reportContent"] = reportContent;
        _data["reason"] = reason;
        _data["type"] = type;
        _data["status"] = status;
        _data["response"] = response;
        _data["timestamp"] = timestamp;
        if(reportImages != null) {
            _data["reportImages"] = reportImages?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class ReportImages {
    String? imageUrl;

    ReportImages({this.imageUrl});

    ReportImages.fromJson(Map<String, dynamic> json) {
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