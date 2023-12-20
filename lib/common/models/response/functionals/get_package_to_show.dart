class PackageToShowToUser {
  Metadata? metadata;
  List<Data>? data;
  bool? isError;
  String? message;

  PackageToShowToUser({this.metadata, this.data, this.isError, this.message});

  PackageToShowToUser.fromJson(Map<String, dynamic> json) {
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
  String? name;
  double? price;
  int? duration;
  String? endDate;
  bool? isBought;
  int? totalFeature;
  List<Features>? features;

  Data(
      {this.id,
      this.name,
      this.price,
      this.duration,
      this.endDate,
      this.isBought,
      this.totalFeature,
      this.features});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    price = json["price"];
    duration = json["duration"];
    endDate = json["endDate"];
    isBought = json["isBought"];
    totalFeature = json["totalFeature"];
    features = json["features"] == null
        ? null
        : (json["features"] as List).map((e) => Features.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["price"] = price;
    _data["duration"] = duration;
    _data["endDate"] = endDate;
    _data["isBought"] = isBought;
    _data["totalFeature"] = totalFeature;
    if (features != null) {
      _data["features"] = features?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Features {
  int? id;
  String? name;
  String? description;
  bool? isActive;
  Config? config;

  Features({this.id, this.name, this.description, this.isActive, this.config});

  Features.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    isActive = json["isActive"];
    config = json["config"] == null ? null : Config.fromJson(json["config"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["description"] = description;
    _data["isActive"] = isActive;
    if (config != null) {
      _data["config"] = config?.toJson();
    }
    return _data;
  }
}

class Config {
  String? configName;
  String? number;
  String? unit;

  Config({this.configName, this.number, this.unit});

  Config.fromJson(Map<String, dynamic> json) {
    configName = json["configName"];
    number = json["number"];
    unit = json["unit"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["configName"] = configName;
    _data["number"] = number;
    _data["unit"] = unit;
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
