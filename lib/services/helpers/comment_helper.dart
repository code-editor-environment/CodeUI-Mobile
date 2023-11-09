import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as https;

import '../../common/constants/app_constants.dart';
import '../../common/models/response/functionals/create_comment_by_element_id.dart';
import '../../common/models/response/functionals/get_comment_by_element_id.dart';
import '../../common/models/response/functionals/get_one_element_by_id_of_user.dart';

var client = https.Client();

class GetCommentService {
  Future<GetCommentAndReplyByElementsId> getOne() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var accountId = prefs.getString("accountId");
    var idForElements = prefs.getInt("idForElements");
    var accountIdToBeViewedInElements = prefs.getString("accountIdToBeViewed");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var Client = https.Client();

    var uri = Uri.parse(
        "https://dev.codeui-api.io.vn/api/react-element/getCommentsByElementId?ElementId=$idForElements&PageSize=12");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return GetCommentAndReplyByElementsId.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<bool> createComment(CreateCommentByElementId model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var accountId = prefs.getString("accountId");
    var idForElements = prefs.getInt("idForElements");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse(
        "https://dev.codeui-api.io.vn/api/react-element/createComment?ElementId=$idForElements");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );
    if (response.statusCode == 200) {
      jsonDecode(response.body);

      print("hehe like siuu");

      return true;
    } else {
      Get.snackbar("Failed", "Please check your internet connection",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: Icon(Icons.add_alert));
      return false;
    }
  }
}
