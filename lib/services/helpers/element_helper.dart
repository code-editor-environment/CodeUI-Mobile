import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;

import '../../common/constants/app_constants.dart';
import '../../common/models/response/functionals/get_elements_by_user_name_model.dart';
import '../../common/models/response/functionals/get_one_element_by_id_of_user.dart';
import '../../common/models/response/functionals/like_element_response.dart';
import '../../common/models/response/functionals/moderator_get_all_categories.dart';
import '../../common/models/response/functionals/moderator_get_approved_elements.dart';
import '../../common/models/response/functionals/moderator_get_elements_report.dart';
import '../../common/models/response/functionals/moderator_get_one_category.dart';
import '../../common/models/response/functionals/moderator_get_pending.dart';
import '../../common/models/response/functionals/save_favourite_elements_by_current_logged_in_user.dart';

var client = https.Client();

class GetElementService {
  Future<GetElementsFromASpecificUser> getAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var accountId = prefs.getString("accountId");
    var accountIdToBeViewedInElements = prefs.getString("accountIdToBeViewed");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var Client = https.Client();

    var uri = Uri.parse(
        "https://dev.codeui-api.io.vn/api/element/getAll?Status=Approved&OwnerUsername=$accountIdToBeViewedInElements");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return GetElementsFromASpecificUser.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<ModeratorGetPending> moderatorGetPending() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var Client = https.Client();

    var uri = Uri.parse(
        "https://dev.codeui-api.io.vn/api/moderator-element/getPendingElements?PageSize=50");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return ModeratorGetPending.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<ModeratorGetApprovedElements> moderatorGetApproved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var Client = https.Client();

    var uri = Uri.parse(
        "https://dev.codeui-api.io.vn/api/element/getAll?Status=Approved&PageSize=100");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return ModeratorGetApprovedElements.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<ModeratorGetAllCategories> moderatorGetAllCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var Client = https.Client();

    var uri = Uri.parse(
        "https://dev.codeui-api.io.vn/api/category/getAll?PageSize=50");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return ModeratorGetAllCategories.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<ModeratorGetOneCategory> moderatorGetOneCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var categoryName = prefs.getString("categoryName");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var Client = https.Client();

    var uri = Uri.parse(
        "https://dev.codeui-api.io.vn/api/category/getCategory?name=taiducvngtest");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return ModeratorGetOneCategory.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<GetOneElement> getOne() async {
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
        "https://dev.codeui-api.io.vn/api/element/getByID?id=$idForElements");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;

      print(json);
      return GetOneElement.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }
  // Future<ViewSpecificProfileResponse> getOne() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var token = prefs.getString("accessToken");
  //   var accountIdToBeViewed = prefs.getString("accountIdToBeViewed");
  //   Map<String, String> requestHeaders = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token'
  //   };
  //   var Client = https.Client();

  //   var uri = Uri.parse(
  //       "http://13.212.54.225:44360/api/profile/getByUsername?username=$accountIdToBeViewed");
  //   var response = await Client.get(uri, headers: requestHeaders);
  //   if (response.statusCode == 200) {
  //     var json = response.body;
  //     print(json);

  //     return ViewSpecificProfileResponse.fromJson(jsonDecode(json));
  //   } else {
  //     throw Exception('Failed to load ');
  //   }
  // }
  Future<ModeratorGetElementsReport> moderatorGetElementsReport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var Client = https.Client();

    var uri = Uri.parse(
        "https://dev.codeui-api.io.vn/api/report/getElementReport?PageSize=50");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;

      print(json);
      return ModeratorGetElementsReport.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<bool> likeElement(int Id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var accountId = prefs.getString("accountId");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse(
        "https://dev.codeui-api.io.vn/api/react-element/likeElement?ElementId=$Id");
    var response = await client.post(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      jsonDecode(response.body);
      Get.snackbar(
        "Liked",
        "Elements has been liked successfully!",
        icon: Icon(Icons.alarm),
        backgroundColor: Colors.cyanAccent,
        barBlur: 20,
        isDismissible: true,
        duration: Duration(seconds: 4),
      );
      print("hehe like siuu");

      return true;
    } else {
      Get.snackbar("Sign failed", "Please check your credentials",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: Icon(Icons.add_alert));
      return false;
    }
  }

  Future<SaveFavouriteElements> getSaveFavourite() async {
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
        "https://dev.codeui-api.io.vn/api/element/getFavoriteElements");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return SaveFavouriteElements.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<bool> saveFavoriteElement(int Id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var accountId = prefs.getString("accountId");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse(
        "https://dev.codeui-api.io.vn/api/react-element/saveFavorite?ElementId=$Id");
    var response = await client.post(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      jsonDecode(response.body);
      Get.snackbar(
        "Saved",
        "Elements has been saved successfully!",
        icon: Icon(Icons.save),
        backgroundColor: Colors.cyanAccent,
        barBlur: 20,
        isDismissible: true,
        duration: Duration(seconds: 4),
      );
      print("hehe like siuu");

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
