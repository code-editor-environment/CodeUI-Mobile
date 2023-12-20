import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/common/models/request/functional/send_reports_for_elements_without_images.dart';
import 'package:mobile/common/models/response/functionals/get_one_element_by_id_of_user.dart';
import 'package:mobile/common/models/response/functionals/like_element_response.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/components/reusable_text_long.dart';
import 'package:mobile/services/helpers/element_helper.dart';
import 'package:mobile/services/helpers/report_helper.dart';
import 'package:mobile/view/widget/image_utils.dart';
import 'package:mobile/view/widget/profile_page.dart';
import 'package:mobile/view/widget/save_favourite.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:mobile/view/widget/view_specific_profile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../common/models/request/functional/send_reports_for_elements.dart';
import '../../common/models/response/functionals/create_comment_by_element_id.dart';
import '../../common/models/response/functionals/get_comment_by_element_id.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/reusable_text.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/constants/custom_textfield.dart';
import '../../common/constants/custom_textfield_with_hint_text.dart';
import '../../services/helpers/comment_helper.dart';
import 'add_image_data.dart';
import 'home_page_user_logged_in.dart';

class PendingDetailedWidget extends StatefulWidget {
  const PendingDetailedWidget({super.key});

  @override
  State<PendingDetailedWidget> createState() => _PendingDetailedWidgetState();
}

class _PendingDetailedWidgetState extends State<PendingDetailedWidget> {
  String? selectedValue = "Choose your reason";
  bool isCodeVisible = false;
  RxBool isLiked = false.obs;
  RxBool isLikedTrue = false.obs;
  RxBool isFavorite = false.obs;
  RxBool isFavoriteTrue = false.obs;

  late String elementsNameToReport = '';
  late String _currentLoggedInUsername = "";
  late String creatorName;
  late Future<GetOneElement> _profileFuture;
  late Future<GetCommentAndReplyByElementsId> _profileFuture1;
  late int idForElements = 0;
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
      var accountIdToBeViewedInElements =
          prefs.getString("accountIdToBeViewed");
      var idForElements1 = prefs.getInt("idForElements");
      setState(() {
        idForElements = idForElements1!;
        _profileFuture = _getData();
        _profileFuture1 = _getCommentAndReply();
      });
      prefs.setString("elementsNameToReport", elementsNameToReport);
      print(_currentLoggedInUsername);
      print(accountIdToBeViewedInElements);
      print(idForElements1);
    });

    super.initState();
  }

  GetElementService getElementService = GetElementService();
  GetCommentService getCommentService = GetCommentService();
  Future<GetCommentAndReplyByElementsId> _getCommentAndReply() async {
    try {
      final items1 = await GetCommentService().getOne();
      return items1;
    } catch (e) {
      rethrow;
    }
  }

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
        appBar: CustomLoggedInUserAppBar(),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(indicatorColor: Colors.black),
          child: NavigationBar(
            shadowColor: Colors.black,
            height: 50,
            backgroundColor: Color(0xff181818),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            indicatorColor: Color(0xff292929),
            indicatorShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            selectedIndex: 0,
            // onDestinationSelected: (index) => setState(() => this.index = index),
            destinations: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: NavigationDestination(
                    icon: IconButton(
                      icon: Icon(Icons.home_outlined),
                      color: Color(0xffEC4899).withOpacity(0.4),
                      onPressed: () {
                        Get.to(CodeUIHomeScreenForLoggedInUser());
                      },
                    ),
                    label: ""),
              ),
              NavigationDestination(
                  icon: IconButton(
                    icon: Icon(Icons.search),
                    color: Color(0xffEC4899).withOpacity(0.4),
                    onPressed: () {
                      Get.to(SearchWidget());
                    },
                  ),
                  label: ""),
              NavigationDestination(
                  icon: IconButton(
                    icon: Icon(Icons.bookmarks_outlined),
                    color: Color(0xffEC4899).withOpacity(0.4),
                    onPressed: () {
                      Get.to(BookmarkedOwnedWidget());
                    },
                  ),
                  label: ""),
            ],
          ),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                    height: height * 2,
                    color: Colors.black,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 12, 0),
                                  child: PopupMenuButton<String>(
                                    onSelected: (value) {
                                      int idToDelete = items.data!.id!;
                                      print("Action: $idToDelete");
                                      // Handle the selected value here
                                      if (value == 'settings1') {
                                        Get.defaultDialog(
                                          middleTextStyle: appstyle(
                                              16,
                                              Color(0xffA855F7),
                                              FontWeight.w600),
                                          title: "Delete?",
                                          titleStyle: appstyle(
                                              18,
                                              Color(0xffEC4899),
                                              FontWeight.w600),
                                          middleText:
                                              "You want to delete this element?",
                                          backgroundColor: Colors.white,
                                          radius: 10.0,
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                // Perform actions when the button in the dialog is pressed
                                                //   Get.back(); // Close the dialog
                                                getElementService
                                                    .deleteElementForPending(
                                                        idToDelete);
                                                FirebaseFirestore.instance
                                                    .collection('elements')
                                                    .doc("$idToDelete")
                                                    .delete();
                                              },
                                              child: Text("OK"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                // Perform actions when the button in the dialog is pressed
                                                Get.back(); // Close the dialog
                                              },
                                              child: Text("Cancel"),
                                            ),
                                          ],
                                        );
                                        // Perform the action for the settings option
                                      }
                                    },
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        value: 'settings1',
                                        child: Row(
                                          children: [
                                            Icon(Icons.close,
                                                color: Color(0xffAB55F7)),
                                            Text('Delete this element'),
                                          ],
                                        ),
                                      ),
                                    ],
                                    child: Icon(
                                      Icons.settings,
                                      color: Color(0xffAB55F7),
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // elements after built ,cái này về sau gắn html css qua package để  webview

                            Card(
                              clipBehavior: Clip.antiAlias,
                              child: Container(
                                height: height / 4.5,
                                width: width * 0.902,
                                child: ListView.builder(
                                  itemCount: 1,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var idForElements1 = items.data!.id;
                                    print(idForElements1);

                                    return Container(
                                      child: Column(
                                        children: [
                                          Row(children: [
                                            //item1
                                            Container(
                                              color: Colors.black,
                                              width: width * 0.902,
                                              height: height / 4.5,
                                              child: Card(
                                                child: ElevatedButton(
                                                  onPressed: () async {},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors
                                                        .transparent, // Set the button background color to transparent
                                                    elevation:
                                                        0, // Remove the button shadow
                                                    padding: EdgeInsets
                                                        .zero, // Remove default button padding
                                                    // Reduce the button's tap target size
                                                  ),
                                                  child: FutureBuilder(
                                                    future: FirebaseFirestore
                                                        .instance
                                                        .collection('elements')
                                                        .doc("$idForElements1")
                                                        .get(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      } else if (snapshot
                                                          .hasError) {
                                                        return Center(
                                                            child: Text(
                                                                'Error loading data'));
                                                      } else if (!snapshot
                                                          .hasData) {
                                                        return Center(
                                                            child: Text(
                                                                'No data available'));
                                                      } else {
                                                        var document =
                                                            snapshot.data!;

                                                        var htmlCode =
                                                            document['html'];
                                                        var cssCode =
                                                            document['css'];

                                                        var hexColor = document[
                                                            'background'];
                                                        var typeCss =
                                                            document['typeCSS'];
                                                        var fullHtmlCode;
                                                        if (typeCss ==
                                                            'tailwind') {
                                                          fullHtmlCode =
                                                              '$htmlCode<style>body { width: 95%;background:$hexColor; height: 95%; display: flex; align-items: center; justify-content: center; font-family: Montserrat, sans-serif;   }$cssCode</style><script src="https://cdn.tailwindcss.com"></script>';
                                                        } else {
                                                          fullHtmlCode =
                                                              '$htmlCode<style>body { width: 95%;background:$hexColor; height: 95%; display: flex; align-items: center; justify-content: center; font-family: Montserrat, sans-serif;   }$cssCode</style>';
                                                        }
                                                        ;

                                                        return WebViewWidget(
                                                          controller:
                                                              WebViewController()
                                                                ..setJavaScriptMode(
                                                                    JavaScriptMode
                                                                        .unrestricted)
                                                                ..loadHtmlString(
                                                                    fullHtmlCode)
                                                                ..clearLocalStorage(),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            //item1 ending

                                            //item1 ending
                                          ]),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            //content whatever
                            SizedBox(
                              height: 8,
                            ),
                            FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection('elements')
                                  .doc("$idForElements")
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error loading data'));
                                } else if (!snapshot.hasData) {
                                  return Center(
                                      child: Text('No data available'));
                                } else {
                                  var document = snapshot.data!;

                                  var htmlCode = document['html'];
                                  var cssCode = document['css'];

                                  var fullHtmlCode =
                                      '<style>body {             zoom:1.5;      }$cssCode</style>$htmlCode';
                                  var hexColor = document['background'];
                                  int backgroundColor = int.parse(
                                      hexColor.substring(1),
                                      radix: 16);

                                  return Column(
                                    children: [
                                      Container(
                                        width: width * 0.85,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              12, 0, 0, 0),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 8),
                                              backgroundColor:
                                                  Color(0xff292929),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: Text(
                                              "HTML code:\n ${htmlCode} ",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(kLight.value),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.85,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              12, 12, 0, 0),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 8),
                                              backgroundColor:
                                                  Color(0xff292929),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: Text(
                                              "CSS code:\n ${cssCode} ",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(kLight.value),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                            ElevatedButton(
                              onPressed: () async {},
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
                                    padding:
                                        const EdgeInsets.fromLTRB(16, 16, 0, 0),
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 16, 0, 0),
                                    child: ReusableText(
                                        text: "$creatorName",
                                        style: appstyle(15, Color(0xffF6F0F0),
                                            FontWeight.w600)),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: ReusableText(
                                  text:
                                      "Description: ${items.data!.description} ",
                                  style: appstyle(
                                      15, Color(0xffF6F0F0), FontWeight.w600)),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: ReusableText(
                                  text:
                                      "Category: ${items.data!.categoryName} ",
                                  style: appstyle(
                                      15, Color(0xffF6F0F0), FontWeight.w600)),
                            ),
                            //bookmarked times
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: items.data!.status == 'REJECTED'
                                  ? ReusableText(
                                      text:
                                          "Your element has been rejected. Please head to the web to know why this is happen",
                                      style: appstyle(
                                          15,
                                          Color.fromRGBO(218, 57, 29, 29),
                                          FontWeight.w600))
                                  : SizedBox(), // Placeholder when status is not 'rejected'
                            ),

                            //bookmarked times
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: ReusableText(
                                  text:
                                      "Current status: ${items.data!.status} ",
                                  style: appstyle(
                                      15, Color(0xffab55f7), FontWeight.w600)),
                            ),
                            //bookmarked times

                            SizedBox(
                              height: 12,
                            ),

                            SizedBox(
                              height: 12,
                            ),
                            // get all comment by listview
                          ]),
                    ),
                  );
                }
              },
            )));
  }
}
