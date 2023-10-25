import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/common/models/response/functionals/profile_res_model.dart';
import 'package:mobile/view/widget/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:http/http.dart' as https;

import '../../common/constants/app_constants.dart';
import '../../common/models/request/functional/update_profile_model.dart';
import '../../common/models/response/functionals/view_profile_res_model.dart';

var client = https.Client();

class GetProfileService {
  Future<ViewProfileResponse> getAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var accountId = prefs.getString("accountId");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': '$token'
    };
    var Client = https.Client();

    var uri =
        Uri.parse("https://dev.codeui-api.io.vn/api/account/getByAccessToken");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return ViewProfileResponse.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<ViewSpecificProfileResponse> getOne() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var accountIdToBeViewed = prefs.getString("accountIdToBeViewed");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var Client = https.Client();

    var uri = Uri.parse(
        "https://dev.codeui-api.io.vn/api/profile/getByUsername?username=$accountIdToBeViewed");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);

      return ViewSpecificProfileResponse.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }
}

class UpdateProfileService {
  Future<bool> updateProfile(UpdateProfileModel model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var accountId = prefs.getString("accountId");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse("https://dev.codeui-api.io.vn/api/profile/updatebyId");
    var response = await client.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );
    if (response.statusCode == 200) {
      jsonDecode(response.body);
      Get.snackbar(
        "Profile has been updated successfully",
        "Your profile has been updated!",
        icon: Icon(Icons.alarm),
        backgroundColor: Colors.cyanAccent,
        barBlur: 20,
        isDismissible: true,
        duration: Duration(seconds: 4),
      );
      print("hehe");
      Get.to(() => const ProfileWidget());

      return true;
    } else {
      Get.snackbar("Sign failed", "Please check your credentials",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: Icon(Icons.add_alert));
      return false;
    }
  }
}
