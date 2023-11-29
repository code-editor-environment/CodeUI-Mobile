
class SendReportForElementsWithoutImages {
    String? reportContent;

    SendReportForElementsWithoutImages({this.reportContent});

    SendReportForElementsWithoutImages.fromJson(Map<String, dynamic> json) {
        reportContent = json["reportContent"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["reportContent"] = reportContent;
        return _data;
    }
}