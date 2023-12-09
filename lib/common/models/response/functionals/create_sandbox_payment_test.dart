
class CreateSandBoxPaymentTest {
    int? money;
    String? orderType;
    String? orderDescription;
    String? returnUrl;

    CreateSandBoxPaymentTest({this.money, this.orderType, this.orderDescription, this.returnUrl});

    CreateSandBoxPaymentTest.fromJson(Map<String, dynamic> json) {
        money = json["money"];
        orderType = json["orderType"];
        orderDescription = json["orderDescription"];
        returnUrl = json["returnUrl"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["money"] = money;
        _data["orderType"] = orderType;
        _data["orderDescription"] = orderDescription;
        _data["returnUrl"] = returnUrl;
        return _data;
    }
}