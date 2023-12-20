import 'package:mobile/view/widget/view_owned_draft_elements.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as https;

import '../../common/constants/app_constants.dart';
import '../../common/models/response/functionals/create_request_without_image.dart';
import '../../common/models/response/functionals/edit_request_model.dart';
import '../../common/models/response/functionals/get_all_elements_to_show.dart';
import '../../common/models/response/functionals/get_all_requests_to_show.dart';
import '../../common/models/response/functionals/get_elements_by_user_name_model.dart';
import '../../common/models/response/functionals/get_elements_by_user_name_model_1.dart';
import '../../common/models/response/functionals/get_elements_by_user_name_model_2.dart';
import '../../common/models/response/functionals/get_one_element_by_id_of_user.dart';
import '../../common/models/response/functionals/get_random_elements_landing.dart';
import '../../common/models/response/functionals/get_request_by_id.dart';
import '../../common/models/response/functionals/like_element_response.dart';
import '../../common/models/response/functionals/moderator_elements_filtered_by_category.dart';
import '../../common/models/response/functionals/moderator_get_all_categories.dart';
import '../../common/models/response/functionals/moderator_get_approved_by_filtering.dart';
import '../../common/models/response/functionals/moderator_get_approved_elements.dart';
import '../../common/models/response/functionals/moderator_get_elements_report.dart';
import '../../common/models/response/functionals/moderator_get_one_category.dart';
import '../../common/models/response/functionals/moderator_get_pending.dart';
import '../../common/models/response/functionals/moderator_get_pending_reports.dart';
import '../../common/models/response/functionals/save_favourite_elements_by_current_logged_in_user.dart';
import '../../view/widget/owned_request_widget.dart';
import '../../view/widget/view_owned_pending_elements.dart';
import '../../view/widget/view_owned_rejected_elements.dart';

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
        "https://dev.codeui-api.io.vn/api/element/getAll?IsActive=true&Status=approved&OwnerUsername=$accountIdToBeViewedInElements&PageSize=300");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return GetElementsFromASpecificUser.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<GetElementsFromASpecificUser1> getAll1() async {
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
        "https://dev.codeui-api.io.vn/api/element/getAll?IsActive=true&Status=Draft&OwnerUsername=$accountIdToBeViewedInElements");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return GetElementsFromASpecificUser1.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<GetElementsFromASpecificUser2> getAll2() async {
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
        "https://dev.codeui-api.io.vn/api/element/getAll?Status=pending&OwnerUsername=$accountIdToBeViewedInElements");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return GetElementsFromASpecificUser2.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<GetElementsFromASpecificUser> getAll3() async {
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
        "https://dev.codeui-api.io.vn/api/element/getAll?IsActive=true&Status=rejected&OwnerUsername=$accountIdToBeViewedInElements");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return GetElementsFromASpecificUser.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<GetRandomElements> getRandomElements() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var Client = https.Client();

    var uri =
        Uri.parse("https://dev.codeui-api.io.vn/api/element/getRandomElements");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return GetRandomElements.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<GetAllElementsToShow> getAllElementsToShow() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var Client = https.Client();

    var uri = Uri.parse("https://dev.codeui-api.io.vn/api/element/getAll");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return GetAllElementsToShow.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<GetAllElementsToShow> getAllElementsToShow1() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var Client = https.Client();

    var uri = Uri.parse(
        "https://dev.codeui-api.io.vn/api/element/getAll?PageSize=25");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return GetAllElementsToShow.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<GetRandomElements> getRandomElements1() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var Client = https.Client();

    var uri = Uri.parse(
        "https://dev.codeui-api.io.vn/api/element/getRandomElements?PageSize=250");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return GetRandomElements.fromJson(jsonDecode(json));
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

  Future<RequestToShowToUser> getAllRequests() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var Client = https.Client();

    var uri = Uri.parse(
        "https://dev.codeui-api.io.vn/api/request/getRequestList?PageSize=50&Status=1");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return RequestToShowToUser.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<RequestToShowToUser> getOwnRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var currentLoggedInUsername = prefs.getString("currentLoggedInUsername");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var Client = https.Client();

    var uri = Uri.parse(
        "https://dev.codeui-api.io.vn/api/request/getRequestList?Status=5&CreatorName=$currentLoggedInUsername");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return RequestToShowToUser.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<bool> updateRequest(EditRequestModel model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var accountId = prefs.getString("accountId");
    var idRequestToBeSeen = prefs.getInt("idRequestToBeSeen");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse(
        "https://dev.codeui-api.io.vn/api/request/updateRequest?requestId=$idRequestToBeSeen");
    var response = await client.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );
    if (response.statusCode == 200) {
      jsonDecode(response.body);
      Get.snackbar(
        "Request has been updated successfully",
        "Your request has been updated!",
        icon: Icon(Icons.alarm),
        backgroundColor: Colors.cyanAccent,
        barBlur: 20,
        isDismissible: true,
        duration: Duration(seconds: 4),
      );
      print("hehe");
      Get.off(() => const OwnedRequestWidget());

      return true;
    } else {
      Get.snackbar("Failed", "Error occurred",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: Icon(Icons.add_alert));
      Get.off(() => const OwnedRequestWidget());

      return false;
    }
  }

  Future<bool> deleteRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var accountId = prefs.getString("accountId");
    var idRequestToBeSeen = prefs.getInt("idRequestToBeSeen");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse(
        "https://dev.codeui-api.io.vn/api/request/deleteRequestInDatabase?requestId=$idRequestToBeSeen");
    var response = await client.delete(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      jsonDecode(response.body);
      Get.snackbar(
        "Request has been deleted successfully",
        "Your request has been deleted!",
        icon: Icon(Icons.alarm),
        backgroundColor: Colors.cyanAccent,
        barBlur: 20,
        isDismissible: true,
        duration: Duration(seconds: 4),
      );
      print("hehe");
      Get.off(() => const OwnedRequestWidget());

      return true;
    } else {
      Get.snackbar("Failed", "Error occurred",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: Icon(Icons.add_alert));
      Get.off(() => const OwnedRequestWidget());

      return false;
    }
  }

  Future<GetRequestById> getOneRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var idRequestToBeSeen = prefs.getInt("idRequestToBeSeen");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var Client = https.Client();

    var uri = Uri.parse(
        "https://dev.codeui-api.io.vn/api/request/getRequestById?requestId=$idRequestToBeSeen");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return GetRequestById.fromJson(jsonDecode(json));
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

  Future<ModeratorGetApprovedByFiltering> moderatorGetApprovedByFiltering(
      String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var Client = https.Client();

    var uri = Uri.parse(
        "https://dev.codeui-api.io.vn/api/element/getAll?Status=approved&OwnerUsername=$username&PageSize=100");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return ModeratorGetApprovedByFiltering.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<bool> createRequestWithoutImage(
      CreateRequestWithoutImage model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var accountId = prefs.getString("accountId");
    var idForElements = prefs.getInt("idForElements");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url =
        Uri.parse("https://dev.codeui-api.io.vn/api/request/createRequest");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );
    if (response.statusCode == 200) {
      jsonDecode(response.body);
      Get.snackbar(
        "Successful",
        "Request has been made successfully",
        icon: Icon(Icons.alarm),
        backgroundColor: Colors.cyanAccent,
        barBlur: 20,
        isDismissible: true,
        duration: Duration(seconds: 4),
      );
      print("hehe");
      Get.to(() => const OwnedRequestWidget());

      return true;
    } else {
      Get.snackbar("Failed", "Money must be between 10.000 or 10.000.000đ ",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: Icon(Icons.add_alert));

      // Get.back();
      return false;
    }
  }

  Future<ModeratorGetPendingElementReports>
      moderatorGetPendingElementsReport() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var Client = https.Client();

    var uri = Uri.parse(
        "https://dev.codeui-api.io.vn/api/moderator-report/getPendingReports?PageSize=100");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return ModeratorGetPendingElementReports.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to load ');
    }
  }

  Future<ModeratorElementsFilteredByCategoriesName>
      moderatorGetApprovedByCategoryFiltering(String category) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var Client = https.Client();

    var uri = Uri.parse(
        "https://dev.codeui-api.io.vn/api/element/getAll?Status=Approved&CategoryName=$category&PageSize=100");
    var response = await Client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return ModeratorElementsFilteredByCategoriesName.fromJson(
          jsonDecode(json));
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
  Future<ModeratorGetElementsReport> moderatorGetElementsReport(
      String Id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var Client = https.Client();

    var uri = Uri.parse(
        "https://dev.codeui-api.io.vn/api/report/getElementReport?elementId=$Id&PageSize=100");
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

  Future<bool> unlikeElement(int Id) async {
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
        "Unliked",
        "Elements has been unliked successfully!",
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

  Future<bool> deleteElement(int Id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var accountId = prefs.getString("accountId");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse(
        "https://dev.codeui-api.io.vn/api/element/deleteElement?id=$Id");
    var response = await client.delete(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      jsonDecode(response.body);
      Get.snackbar(
        "Deleted",
        "Your draft elements has been deleted successfully!",
        icon: Icon(Icons.alarm),
        backgroundColor: Colors.cyanAccent,
        barBlur: 20,
        isDismissible: true,
        duration: Duration(seconds: 4),
      );
      print("hehe like siuu");
      Get.off(() => const ViewOwnedDraftElements());
      return true;
    } else {
      Get.snackbar("Failed", "Something is wrong",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: Icon(Icons.add_alert));
      return false;
    }
  }

  Future<bool> deleteElementForRejected(int Id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var accountId = prefs.getString("accountId");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse(
        "https://dev.codeui-api.io.vn/api/element/deleteElement?id=$Id");
    var response = await client.delete(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      jsonDecode(response.body);
      Get.snackbar(
        "Deleted",
        "Your rejected elements has been deleted successfully!",
        icon: Icon(Icons.alarm),
        backgroundColor: Colors.cyanAccent,
        barBlur: 20,
        isDismissible: true,
        duration: Duration(seconds: 4),
      );
      print("hehe like siuu");
      Get.off(() => const ViewOwnedRejectedElements());
      return true;
    } else {
      Get.snackbar("Failed", "Something is wrong",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: Icon(Icons.add_alert));
      return false;
    }
  }

  Future<bool> deleteElementForPending(int Id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var accountId = prefs.getString("accountId");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse(
        "https://dev.codeui-api.io.vn/api/element/deleteElement?id=$Id");
    var response = await client.delete(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      jsonDecode(response.body);
      Get.snackbar(
        "Deleted",
        "Your pending elements has been deleted successfully!",
        icon: Icon(Icons.alarm),
        backgroundColor: Colors.cyanAccent,
        barBlur: 20,
        isDismissible: true,
        duration: Duration(seconds: 4),
      );
      print("hehe like siuu");
      Get.off(() => const ViewOwnedPendingElements());
      return true;
    } else {
      Get.snackbar("Failed", "Something is wrong",
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

  Future<bool> unsaveFavoriteElement(int Id) async {
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

  Future<bool> approveElements(int Id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var accountId = prefs.getString("accountId");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse(
        "https://dev.codeui-api.io.vn/api/moderator-report/approveReport?Id=$Id");
    var response = await client.post(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      jsonDecode(response.body);
      Get.snackbar(
        "Approved",
        "Elements report has been approved successfully!",
        icon: Icon(Icons.approval),
        backgroundColor: Colors.cyanAccent,
        barBlur: 20,
        isDismissible: true,
        duration: Duration(seconds: 4),
      );
      print("hehe like siuu");

      return true;
    } else {
      Get.snackbar("Failed", "Please check your credentials",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: Icon(Icons.add_alert));
      return false;
    }
  }

  Future<bool> rejectElements(int Id, String string) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var accountId = prefs.getString("accountId");
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse(
        "https://dev.codeui-api.io.vn/api/moderator-report/rejectReport?Id=$Id");
    Map<String, dynamic> requestBody = {
      "response": "$string",
      // Add your JSON data here
      // Example: 'key': 'value'
    };
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(requestBody), // Convert the map to a JSON string
    );
    if (response.statusCode == 200) {
      jsonDecode(response.body);
      Get.snackbar(
        "Rejected",
        "Elements report has been rejected successfully!",
        icon: Icon(Icons.approval),
        backgroundColor: Colors.cyanAccent,
        barBlur: 20,
        isDismissible: true,
        duration: Duration(seconds: 4),
      );
      print("hehe like siuu");

      return true;
    } else {
      Get.snackbar("Failed", "Please check your credentials",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: Icon(Icons.add_alert));
      return false;
    }
  }
}
