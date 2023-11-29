class CreateSandBoxPaymentTest {
  int? money;
  String? orderType;
  String? orderDescription;

  CreateSandBoxPaymentTest({this.money, this.orderType, this.orderDescription});

  CreateSandBoxPaymentTest.fromJson(Map<String, dynamic> json) {
    money = json["money"];
    orderType = json["orderType"];
    orderDescription = json["orderDescription"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["money"] = money;
    _data["orderType"] = orderType;
    _data["orderDescription"] = orderDescription;
    return _data;
  }
}
