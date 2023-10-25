class CreateCommentByElementId {
  String? commentContent;

  CreateCommentByElementId({this.commentContent});

  CreateCommentByElementId.fromJson(Map<String, dynamic> json) {
    commentContent = json["commentContent"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["commentContent"] = commentContent;
    return _data;
  }
}
