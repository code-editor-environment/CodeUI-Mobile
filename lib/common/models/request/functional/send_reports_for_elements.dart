
class SendReportForElements {
    String? reportContent;
    List<ReportImages>? reportImages;

    SendReportForElements({this.reportContent, this.reportImages});

    SendReportForElements.fromJson(Map<String, dynamic> json) {
        reportContent = json["reportContent"];
        reportImages = json["reportImages"] == null ? null : (json["reportImages"] as List).map((e) => ReportImages.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["reportContent"] = reportContent;
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