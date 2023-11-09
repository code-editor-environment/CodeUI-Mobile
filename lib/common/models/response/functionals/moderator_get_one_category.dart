
class ModeratorGetOneCategory {
    int? id;
    String? name;
    String? description;
    bool? isActive;
    String? imageUrl;

    ModeratorGetOneCategory({this.id, this.name, this.description, this.isActive, this.imageUrl});

    ModeratorGetOneCategory.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        name = json["name"];
        description = json["description"];
        isActive = json["isActive"];
        imageUrl = json["imageURL"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["name"] = name;
        _data["description"] = description;
        _data["isActive"] = isActive;
        _data["imageURL"] = imageUrl;
        return _data;
    }
}