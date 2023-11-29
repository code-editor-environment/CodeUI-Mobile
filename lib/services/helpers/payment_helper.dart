import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:http/http.dart' as https;

import '../../common/constants/app_constants.dart';
import '../../common/models/request/functional/update_profile_model.dart';
import '../../common/models/response/functionals/create_sandbox_payment_test.dart';
import '../../common/models/response/functionals/moderator_get_accounts_report.dart';
import '../../common/models/response/functionals/payment_response_test.dart';
import '../../common/models/response/functionals/temp_creator_model.dart';
import '../../common/models/response/functionals/get_top_creator.dart';

var client = https.Client();

class PaymentService {
  Future<bool> createSandboxPayment(CreateSandBoxPaymentTest model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var accountId = prefs.getString("accountId");
    var accountIdToBeViewedInElements = prefs.getString("accountIdToBeViewed");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url =
        Uri.parse("https://dev.codeui-api.io.vn/api/payment/createPayment");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var paymentResponse =
          CreateSandBoxPaymentTestResponse.fromJson(jsonResponse);
      var url1234 = paymentResponse.data!.paymentUrl!;
         Uri httpUri = Uri.parse(url1234);
         Uri httpsUri = httpUri.replace(scheme: 'https');

  String httpsUrl = httpsUri.toString();
      await prefs.setString("urltoPay", httpsUrl);
      print("hehe");
      print(paymentResponse.data!.paymentUrl!);
      // Get.to(() => const ViewSpecificProfileWidget());

      return true;
    } else {
      Get.snackbar("Failed", "Internet error occurred",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: Icon(Icons.add_alert));

      // Get.back();
      return false;
    }
  }
}
