
class CreateRequestWithoutImage {
    String? requestDescription;
    double? reward;
    String? name;
    int? deadline;
    String? avatar;
    String? categoryName;
    String? typeCss;

    CreateRequestWithoutImage({this.requestDescription, this.reward, this.name, this.deadline, this.avatar, this.categoryName, this.typeCss});

    CreateRequestWithoutImage.fromJson(Map<String, dynamic> json) {
        requestDescription = json["requestDescription"];
        reward = json["reward"];
        name = json["name"];
        deadline = json["deadline"];
        avatar = json["avatar"];
        categoryName = json["categoryName"];
        typeCss = json["typeCss"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["requestDescription"] = requestDescription;
        _data["reward"] = reward;
        _data["name"] = name;
        _data["deadline"] = deadline;
        _data["avatar"] = avatar;
        _data["categoryName"] = categoryName;
        _data["typeCss"] = typeCss;
        return _data;
    }
}