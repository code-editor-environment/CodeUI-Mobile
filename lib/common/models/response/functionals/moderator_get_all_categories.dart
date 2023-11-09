
class ModeratorGetAllCategories {
    Metadata? metadata;
    List<Data>? data;
    bool? isError;
    String? message;

    ModeratorGetAllCategories({this.metadata, this.data, this.isError, this.message});

    ModeratorGetAllCategories.fromJson(Map<String, dynamic> json) {
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
    String? name;
    String? description;
    bool? isActive;
    String? imageUrl;

    Data({this.name, this.description, this.isActive, this.imageUrl});

    Data.fromJson(Map<String, dynamic> json) {
        name = json["name"];
        description = json["description"];
        isActive = json["isActive"];
        imageUrl = json["imageURL"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["name"] = name;
        _data["description"] = description;
        _data["isActive"] = isActive;
        _data["imageURL"] = imageUrl;
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