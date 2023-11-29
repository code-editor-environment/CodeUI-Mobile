import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/common/models/response/functionals/profile_res_model.dart';
import 'package:mobile/view/widget/home_page_user_logged_in.dart';
import 'package:mobile/view/widget/profile_page.dart';
import 'package:mobile/view/widget/view_specific_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as https;
import 'dart:convert';

import '../../common/constants/app_constants.dart';
import '../../common/models/request/functional/send_reports_for_accounts_without_images.dart';
import '../../common/models/request/functional/send_reports_for_elements.dart';
import '../../common/models/request/functional/send_reports_for_elements_without_images.dart';
import '../../view/widget/elements_detail.dart';

var client = https.Client();

class ReportService {
  Future<bool> sendElementReportsWithImage(
      SendReportForElements model, int reasonId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var accountId = prefs.getString("accountId");
    var idForElements = prefs.getInt("idForElements");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse(
        "https://dev.codeui-api.io.vn/api/report/createElementReport?elementId=$idForElements&reason=$reasonId");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );
    if (response.statusCode == 200) {
      jsonDecode(response.body);
      Get.snackbar(
        "Successful",
        "Reports has been sent successfully",
        icon: Icon(Icons.alarm),
        backgroundColor: Colors.cyanAccent,
        barBlur: 20,
        isDismissible: true,
        duration: Duration(seconds: 4),
      );
      print("hehe");
      Get.off(() => const DetailedWidget());

      return true;
    } else {
      Get.snackbar("Failed", "Error occurred",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: Icon(Icons.add_alert));

      // Get.back();
      return false;
    }
  }

  Future<bool> sendElementReportsWithoutImage(
      SendReportForElementsWithoutImages model, int reasonId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var accountId = prefs.getString("accountId");
    var idForElements = prefs.getInt("idForElements");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse(
        "https://dev.codeui-api.io.vn/api/report/createElementReport?elementId=$idForElements&reason=$reasonId");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );
    if (response.statusCode == 200) {
      jsonDecode(response.body);
      Get.snackbar(
        "Successful",
        "Reports has been sent successfully",
        icon: Icon(Icons.alarm),
        backgroundColor: Colors.cyanAccent,
        barBlur: 20,
        isDismissible: true,
        duration: Duration(seconds: 4),
      );
      print("hehe");
      Get.off(() => const DetailedWidget());

      return true;
    } else {
      Get.snackbar("Failed", "Error occurred",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: Icon(Icons.add_alert));

      // Get.back();
      return false;
    }
  }

  Future<bool> sendAccountReportsWithoutImage(
      SendReportForAccountsWithoutImages model, int reasonId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var accountId = prefs.getString("accountId");
    var accountIdToBeViewedInElements = prefs.getString("accountIdToBeViewed");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse(
        "https://dev.codeui-api.io.vn/api/report/createAccountReport?username=$accountIdToBeViewedInElements&reason=$reasonId");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );
    if (response.statusCode == 200) {
      jsonDecode(response.body);
      Get.snackbar(
        "Successful",
        "Reports has been sent successfully",
        icon: Icon(Icons.alarm),
        backgroundColor: Colors.cyanAccent,
        barBlur: 20,
        isDismissible: true,
        duration: Duration(seconds: 4),
      );
      print("hehe");
      Get.off(() => const ViewSpecificProfileWidget());

      return true;
    } else {
      Get.snackbar("Failed", "Error occurred",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: Icon(Icons.add_alert));

      // Get.back();
      return false;
    }
  }
}
