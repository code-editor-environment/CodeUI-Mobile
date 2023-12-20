
class EditRequestModel {
    String? requestDescription;
    String? name;

    EditRequestModel({this.requestDescription, this.name});

    EditRequestModel.fromJson(Map<String, dynamic> json) {
        requestDescription = json["requestDescription"];
        name = json["name"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["requestDescription"] = requestDescription;
        _data["name"] = name;
        return _data;
    }
}