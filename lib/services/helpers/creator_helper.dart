import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:http/http.dart' as https;

import '../../common/constants/app_constants.dart';
import '../../common/models/request/functional/update_profile_model.dart';
import '../../common/models/response/functionals/moderator_get_accounts_report.dart';
import '../../common/models/response/functionals/temp_creator_model.dart';

var client = https.Client();

class GetAllCreatorService {
  Future<AllCreatorsTempModel> getAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var accountId = prefs.getString("accountId");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var Client = https.Client();

    var uri = Uri.parse(
        "https://dev.codeui-api.io.vn/api/account/getAll?Role=FreeCreator&PageSize=30");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return AllCreatorsTempModel.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }
 Future<ModeratorGetAccountsReport> moderatorGetAccountsReport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
   
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var Client = https.Client();

    var uri = Uri.parse(
        "https://dev.codeui-api.io.vn/api/report/getAccountReport?PageSize=50");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
     
      print(json);
      return ModeratorGetAccountsReport.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }
  Future followCreator() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var accountIdToBeViewed = prefs.getString("accountIdToBeViewed");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse(
        "https://dev.codeui-api.io.vn/api/follow/followCreator?username=${accountIdToBeViewed}");
    var response = await client.post(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      jsonDecode(response.body);
      Get.snackbar(
        "Follow successfully",
        "",
        icon: Icon(
          Icons.check,
          color: Colors.greenAccent,
        ),
        backgroundColor: Colors.white,
        barBlur: 20,
        colorText: Color(0xffA855F7),
        isDismissible: true,
        showProgressIndicator: true,
        progressIndicatorBackgroundColor: Colors.red,
        duration: Duration(seconds: 4),
      );
      print("hehe");
      // Get.to(() => const ProfileWidget());

      return true;
    } else {
      Get.snackbar("Error", "",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: Icon(Icons.add_alert));
      return false;
    }
  }
}
