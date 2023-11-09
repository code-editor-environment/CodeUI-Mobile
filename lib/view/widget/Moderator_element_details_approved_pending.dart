import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:mobile/common/models/response/functionals/get_one_element_by_id_of_user.dart';
import 'package:mobile/common/models/response/functionals/like_element_response.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/components/reusable_text_long.dart';
import 'package:mobile/services/helpers/element_helper.dart';
import 'package:mobile/view/widget/profile_page.dart';
import 'package:mobile/view/widget/save_favourite.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:mobile/view/widget/view_specific_profile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/models/response/functionals/create_comment_by_element_id.dart';
import '../../common/models/response/functionals/get_comment_by_element_id.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/app_bar_moderator_admin.dart';
import '../../components/reusable_text.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/constants/custom_textfield.dart';
import '../../common/constants/custom_textfield_with_hint_text.dart';
import '../../services/helpers/comment_helper.dart';
import 'home_page_user_logged_in.dart';
import 'moderator_pending_elements.dart';

void Rejected(int? idtoVerify) async {
  final String apiUrl =
      "https://dev.codeui-api.io.vn/api/moderator-element/updateElementStatus";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString("accessToken");
  // Your JSON data
  Map<String, dynamic> postData = {
    "elementStatuses": {
      "$idtoVerify": "Rejected",
    }
  };
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };
  // Encode the JSON data
  String jsonBody = json.encode(postData);

  // Set up the POST request
  var response = await http.put(
    Uri.parse(apiUrl),
    headers: requestHeaders,
    body: jsonBody, // Pass the encoded JSON data here
  );

  // Handle the response
  if (response.statusCode == 200) {
    // Successful request, you can handle the response here
    print("POST request successful!");
    print("Response: ${response.body}");
    Get.snackbar(
      "Approved",
      "Elements has been approved successfully!",
      icon: Icon(Icons.alarm),
      backgroundColor: Colors.cyanAccent,
      barBlur: 20,
      isDismissible: true,
      duration: Duration(seconds: 4),
    );
    Get.to(() => const PendingElementsListView());
  } else {
    Get.snackbar("Failed", "Please check your informations",
        colorText: Color(kLight.value),
        backgroundColor: Colors.red,
        icon: Icon(Icons.add_alert));
    // Request failed, handle the error
    print("Error: ${response.statusCode}");
    print("Response: ${response.body}");
  }
}

void Approved(int? idtoVerify) async {
  final String apiUrl =
      "https://dev.codeui-api.io.vn/api/moderator-element/updateElementStatus";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString("accessToken");
  // Your JSON data
  Map<String, dynamic> postData = {
    "elementStatuses": {
      "$idtoVerify": "Approved",
    }
  };
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };
  // Encode the JSON data
  String jsonBody = json.encode(postData);

  // Set up the POST request
  var response = await http.put(
    Uri.parse(apiUrl),
    headers: requestHeaders,
    body: jsonBody, // Pass the encoded JSON data here
  );

  // Handle the response
  if (response.statusCode == 200) {
    // Successful request, you can handle the response here
    print("POST request successful!");
    print("Response: ${response.body}");
    Get.snackbar(
      "Approved",
      "Elements has been approved successfully!",
      icon: Icon(Icons.alarm),
      backgroundColor: Colors.cyanAccent,
      barBlur: 20,
      isDismissible: true,
      duration: Duration(seconds: 4),
    );
    Get.to(() => const PendingElementsListView());
  } else {
    // Request failed, handle the error
    Get.snackbar("Failed", "Please check your informations",
        colorText: Color(kLight.value),
        backgroundColor: Colors.red,
        icon: Icon(Icons.add_alert));
    print("Error: ${response.statusCode}");
    print("Response: ${response.body}");
  }
}

class ModeratorElementsDetail extends StatefulWidget {
  const ModeratorElementsDetail({super.key});

  @override
  State<ModeratorElementsDetail> createState() =>
      _ModeratorElementsDetailState();
}

class _ModeratorElementsDetailState extends State<ModeratorElementsDetail> {
  String? selectedValue = "Choose your reason";
  late String elementsNameToReport = '';
  late String _currentLoggedInUsername = "";
  late String creatorName;
  late Future<GetOneElement> _profileFuture;

  // @override
  // void dispose() {
  //   _commentsStreamController
  //       .close(); // Don't forget to close the stream controller
  //   super.dispose();
  // }
  Future<GetOneElement> _getData() async {
    try {
      final items = await GetElementService().getOne();
      creatorName = items.data!.profileResponse!.username!;
      elementsNameToReport = items.data!.title!;
      return items;
    } catch (e) {
      rethrow;
    }
  }

  final TextEditingController comment = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("accessToken");
      var _currentLoggedInUsername =
          prefs.getString("currentLoggedInUsername")!;

      var idForElements = prefs.getInt("idForElements");
      prefs.setString("elementsNameToReport", elementsNameToReport);
      print(_currentLoggedInUsername);

      print(idForElements);
    });
    _getData();
    _profileFuture = _getData();

    super.initState();
  }

  GetElementService getElementService = GetElementService();
  GetCommentService getCommentService = GetCommentService();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        //  extendBodyBehindAppBar: true,
        appBar: ModeratorAppBarWidget(),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(indicatorColor: Colors.black),
          child: NavigationBar(
            height: 50,
            backgroundColor: Color(0xff181818),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            indicatorColor: Color(0xff292929),
            selectedIndex: 0,
            indicatorShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            // onDestinationSelected: (index) => setState(() => this.index = index),
            destinations: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: NavigationDestination(
                    icon: Icon(
                      Icons.home_outlined,
                      color: Color(0xffEC4899).withOpacity(0.4),
                    ),
                    label: ""),
              ),
              NavigationDestination(
                  icon: IconButton(
                    icon: Icon(Icons.person_pin),
                    color: Color(0xffEC4899).withOpacity(0.4),
                    onPressed: () {
                      // Get.to(ProfileWidget());
                    },
                  ),
                  label: ""),
            ],
          ),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              color: Colors.black,
              child: FutureBuilder(
                future: _profileFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child:
                            CircularProgressIndicator()); // Show a loading indicator while waiting for data.
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    ); // Handle the error.
                  } else if (!snapshot.hasData) {
                    return Center(
                      child: Text('No data available'), // Handle no data case.
                    );
                  } else {
                    var items = snapshot.data!;
                    final tempName = items.data!.title;

                    return Container(
                      width: width,
                      color: Colors.black,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Color(0xffAB55F7),
                                      size: 22,
                                    ),
                                  ),
                                  PopupMenuButton<String>(
                                    onSelected: (value) async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      var idToApproved =
                                          prefs.getInt("idForElements");
                                      print("idToApproved:${idToApproved}");
                                      // Handle the selected value here
                                      if (value == 'settings1') {
                                        Approved(idToApproved);
                                        // Perform the action for the settings option
                                      } else if (value == 'settings2') {
                                        // Perform the action for the settings option
                                        Rejected(idToApproved);
                                      }
                                    },
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        value: 'settings1',
                                        child: Row(
                                          children: [
                                            Icon(Icons.check,
                                                color: Color(0xffAB55F7)),
                                            Text('Accept this element'),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'settings2',
                                        child: Row(
                                          children: [
                                            Icon(Icons.close,
                                                color: Color(0xffAB55F7)),
                                            Text('Reject this element'),
                                          ],
                                        ),
                                      ),
                                      // Add more PopupMenuItem widgets for additional choices if needed
                                    ],
                                    child: Icon(
                                      Icons.settings,
                                      color: Color(0xffAB55F7),
                                      size: 22,
                                    ),
                                  ),
                                ],
                              ),
                              // elements after built ,cái này về sau gắn html css qua package để  webview
                              Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.asset(
                                    "assets/images/Mask_group.png",
                                    width: width * 0.8,
                                    height: height * 0.33,
                                  ),
                                ),
                              ),
                              //content whatever
                              SizedBox(
                                height: 8,
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 0, 0, 0),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      backgroundColor: Colors.grey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      "View this element's code ",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(kLight.value),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              ElevatedButton(
                                onPressed: () async {
                                  final accountIdToBeViewed =
                                      items.data?.ownerUsername;

                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString("accountIdToBeViewed",
                                      accountIdToBeViewed!);
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Color(0xff252525),
                                    builder: (context) => Container(
                                      height: 150,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 48,
                                            backgroundColor: Color(0xff292929),
                                            child: Card(
                                              color: Color(0xff292929),
                                              clipBehavior: Clip.antiAlias,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(48),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Ink.image(
                                                    image: NetworkImage(
                                                        "${items.data!.profileResponse?.imageUrl}"),
                                                    height: 36,
                                                    width: 36,
                                                    fit: BoxFit.cover,
                                                    onImageError: (exception,
                                                        stackTrace) {
                                                      Icon(Icons.image);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                2, 0, 0, 0),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ReusableText(
                                                      text:
                                                          "${items.data?.profileResponse?.firstName} ${items.data?.profileResponse?.lastName}",
                                                      style: appstyle(
                                                          18,
                                                          Color(0xffF6F0F0),
                                                          FontWeight.w600)),
                                                  Container(
                                                    width: 200,
                                                    child: ReusableText(
                                                        text:
                                                            "@${items.data?.ownerUsername} ",
                                                        style: appstyle(
                                                            14,
                                                            Color(0xffF6F0F0),
                                                            FontWeight.w400)),
                                                  ),
                                                  ReusableText(
                                                      text:
                                                          "Followings:${items.data!.profileResponse?.totalFollowing} ",
                                                      style: appstyle(
                                                          12,
                                                          Color(0xffF6F0F0),
                                                          FontWeight.w400)),
                                                ]),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 28, 0, 0),
                                            child: Column(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    if (accountIdToBeViewed ==
                                                        _currentLoggedInUsername) {
                                                      Get.to(() =>
                                                          const ProfileWidget());
                                                    } else {
                                                      Get.to(() =>
                                                          const ViewSpecificProfileWidget());
                                                    }
                                                  },
                                                  icon: Icon(Icons
                                                      .account_circle_outlined),
                                                  color: Color(0xff8026D9),
                                                  iconSize: 36,
                                                ),
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(MdiIcons
                                                      .messageProcessing),
                                                  color: Color(0xff8026D9),
                                                  iconSize: 36,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors
                                      .transparent, // Set the button background color to transparent
                                  shadowColor: Color(
                                      0xff292929), // Set the shadow color to grey
                                  elevation:
                                      2, // Set the elevation to create a shadow effect
                                  padding: EdgeInsets.all(4),
                                ),
                                child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 16, 0, 0),
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: Color(0xffA855F7),
                                        child: CircleAvatar(
                                          radius: 16,
                                          backgroundImage: NetworkImage(
                                              "${items.data!.profileResponse!.imageUrl}"),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 16, 0, 0),
                                      child: ReusableText(
                                          text: "$creatorName",
                                          style: appstyle(15, Color(0xffF6F0F0),
                                              FontWeight.w600)),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(16, 16, 0, 0),
                                    child: ReusableText(
                                        text: "${items.data!.title} ",
                                        style: appstyle(15, Color(0xffF6F0F0),
                                            FontWeight.w600)),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 12,
                              ),
                            ]),
                      ),
                    );
                  }
                },
              ),
            )));
  }
}
