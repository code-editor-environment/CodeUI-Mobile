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
import '../../common/models/response/functionals/moderator_get_one_category.dart';
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

class ModeratorApprovedCategoriesDetail extends StatefulWidget {
  const ModeratorApprovedCategoriesDetail({super.key});

  @override
  State<ModeratorApprovedCategoriesDetail> createState() =>
      _ModeratorApprovedCategoriesDetailState();
}

class _ModeratorApprovedCategoriesDetailState
    extends State<ModeratorApprovedCategoriesDetail> {
  String? selectedValue = "Choose your reason";
  late String elementsNameToReport = '';
  late String _currentLoggedInUsername = "";
  late String creatorName;
  late Future<ModeratorGetOneCategory> _profileFuture;

  // @override
  // void dispose() {
  //   _commentsStreamController
  //       .close(); // Don't forget to close the stream controller
  //   super.dispose();
  // }
  Future<ModeratorGetOneCategory> _getData() async {
    try {
      final items = await GetElementService().moderatorGetOneCategory();

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
                                    onSelected: (value) {
                                      // Handle the selected value here
                                      if (value == 'settings1') {
                                        // Perform the action for the settings option
                                      }
                                    },
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        value: 'settings1',
                                        child: Row(
                                          children: [
                                            Icon(Icons.delete_forever_rounded,
                                                color: Color(0xffAB55F7)),
                                            Text('Delete this category'),
                                          ],
                                        ),
                                      ),

                                      // Add more PopupMenuItem widgets for additional choices if needed
                                    ],
                                    child: Icon(
                                      Icons.delete,
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

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(16, 16, 0, 0),
                                    child: ReusableText(
                                        text: "${items.name} ",
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
