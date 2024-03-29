import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../common/models/response/functionals/moderator_elements_filtered_by_category.dart';
import '../../common/models/response/functionals/moderator_get_approved_by_filtering.dart';
import '../../common/models/response/functionals/moderator_get_approved_elements.dart';
import '../../common/models/response/functionals/moderator_get_pending.dart';
import '../../common/models/response/functionals/save_favourite_elements_by_current_logged_in_user.dart';
import '../../components/app_bar_logged_in_user.dart';

import '../../components/app_bar_moderator_admin.dart';
import '../../components/liked_item.dart';
import '../../components/reusable_text.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/constants/custom_textfield.dart';
import '../../services/helpers/element_helper.dart';
import 'Moderator_element_details_approved_block.dart';
import 'Moderator_element_details_approved_pending.dart';
import 'elements_detail.dart';
import 'home_page_user_logged_in.dart';
import 'modeator_search_page.dart';

class ApprovedElementsListViewByCategoryFiltering extends StatefulWidget {
  const ApprovedElementsListViewByCategoryFiltering({super.key});

  @override
  State<ApprovedElementsListViewByCategoryFiltering> createState() =>
      _ApprovedElementsListViewByCategoryFilteringState();
}

class _ApprovedElementsListViewByCategoryFilteringState
    extends State<ApprovedElementsListViewByCategoryFiltering> {
  late Future<ModeratorElementsFilteredByCategoriesName> _profileFuture;
  late var category = "";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("accessToken");
      var _currentLoggedInUsername =
          prefs.getString("currentLoggedInUsername")!;
      var accountIdToBeViewedInElements =
          prefs.getString("accountIdToBeViewed");
      var categoryFromPrefs = prefs.getString("categoriesNameToFilter");
      print(categoryFromPrefs);
      setState(() {
        category = categoryFromPrefs!;
        _profileFuture = _getData(category);
      });
      print(accountIdToBeViewedInElements);
    });

    super.initState();
  }

  Future<ModeratorElementsFilteredByCategoriesName> _getData(
      String category) async {
    try {
      final items = await GetElementService()
          .moderatorGetApprovedByCategoryFiltering(category);
      return items;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        //  extendBodyBehindAppBar: true,
        appBar: ModeratorAppBarWidget(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: height,
            color: Colors.black,
            child: Column(children: [
              // wrap this
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.to(() => const ModeratorSearchWidget());
                    },
                    icon: Icon(
                      MdiIcons.arrowLeft,
                      color: Color(0xffEC4899),
                    ),
                  )
                ],
              ),
              Container(
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
                        child:
                            Text('No data available'), // Handle no data case.
                      );
                    } else {
                      if (snapshot.data == []) {
                        return Center(
                          child: Text(
                              'The username is not existed'), // Handle no data case.
                        );
                      } else {
                        return Container(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      MdiIcons.searchWeb,
                                      color: Color(0xffEC4899),
                                    ),
                                    ReusableText(
                                      text:
                                          "  ${snapshot.data!.metadata!.total} results found",
                                      style: appstyle(18, Color(0xffEC4899),
                                          FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: height * 0.6,
                                  child: ListView.builder(
                                    itemCount: snapshot.data!.metadata!.total,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Column(children: [
                                            //item1
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 125,
                                                  width: 114,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color:
                                                            Color(0xFFAB55F7),
                                                        offset: Offset(0, 1),
                                                        blurRadius: 12,
                                                        spreadRadius: 1.0,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Card(
                                                    color: Color(0xff292929),
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          child: Column(
                                                            children: [
                                                              Row(children: [
                                                                //item1
                                                                Column(
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          104,
                                                                      height:
                                                                          101,
                                                                      child:
                                                                          ElevatedButton(
                                                                        onPressed:
                                                                            () async {
                                                                          print(
                                                                              index);
                                                                          var idForElements = snapshot
                                                                              .data!
                                                                              .data![index]
                                                                              .id;
                                                                          print(
                                                                              idForElements);
                                                                          print(snapshot
                                                                              .data!
                                                                              .data![index]
                                                                              .toJson());
                                                                          SharedPreferences
                                                                              prefs =
                                                                              await SharedPreferences.getInstance();
                                                                          await prefs.setInt(
                                                                              "idForElements",
                                                                              idForElements!);
                                                                          Get.to(
                                                                            () =>
                                                                                DetailedWidget(),
                                                                          );
                                                                        },
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              Colors.transparent, // Set the button background color to transparent
                                                                          elevation:
                                                                              1, // Remove the button shadow
                                                                          padding: EdgeInsets.fromLTRB(
                                                                              8,
                                                                              24,
                                                                              0,
                                                                              12), // Remove default button padding
                                                                          // Reduce the button's tap target size
                                                                        ),
                                                                        child:
                                                                            Card(
                                                                          child: Padding(
                                                                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                                                              child: FutureBuilder(
                                                                                future: FirebaseFirestore.instance.collection('elements').doc("${snapshot.data!.data![index].id}").get(),
                                                                                builder: (context, snapshot) {
                                                                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                                                                    return Center(child: CircularProgressIndicator());
                                                                                  } else if (snapshot.hasError) {
                                                                                    return Center(child: Text('Error loading data'));
                                                                                  } else if (!snapshot.hasData) {
                                                                                    return Center(child: Text('No data available'));
                                                                                  } else {
                                                                                    var document = snapshot.data!;

                                                                                    var htmlCode = document['html'];
                                                                                    var cssCode = document['css'];
                                                                                    var fullHtmlCode = '<style>body {             zoom: 1.75;      } $cssCode</style>$htmlCode';
                                                                                    var hexColor = document['background'];
                                                                                    int backgroundColor = int.parse(hexColor.substring(1), radix: 16);
                                                                                    return WebViewWidget(
                                                                                      controller: WebViewController()
                                                                                        ..setJavaScriptMode(JavaScriptMode.unrestricted)
                                                                                        ..loadHtmlString(fullHtmlCode)
                                                                                        ..clearLocalStorage(),
                                                                                    );
                                                                                  }
                                                                                },
                                                                              )),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                //item1 ending

                                                                //item1 ending
                                                              ]),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // trên là cái hình elements
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ReusableText(
                                                          text:
                                                              "Owner: ${snapshot.data!.data![index].profileResponse!.username} ",
                                                          style: appstyle(
                                                              15,
                                                              Color(0xffEC4899),
                                                              FontWeight.w600)),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor: Colors
                                                              .transparent, // Set the button background color to transparent
                                                          elevation:
                                                              0, // Remove the button shadow
                                                          padding: EdgeInsets
                                                              .zero, // Remove default button padding
                                                          // Reduce the button's tap target size
                                                        ),
                                                        onPressed: () async {
                                                          print(index);
                                                          var idForElements2 =
                                                              snapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .id;
                                                          print(idForElements2);
                                                          print(snapshot.data!
                                                              .data![index]
                                                              .toJson());
                                                          SharedPreferences
                                                              prefs =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          await prefs.setInt(
                                                              "idForElements",
                                                              idForElements2!);
                                                          Get.to(() =>
                                                              const ModeratorApprovedElementsDetail());
                                                        },
                                                        child: ReusableText(
                                                            text:
                                                                "Elements name: ${snapshot.data!.data![index].title} ",
                                                            style: appstyle(
                                                                15,
                                                                Color(
                                                                    0xffF6F0F0),
                                                                FontWeight
                                                                    .w600)),
                                                      ),
                                                      //bookmarked times
                                                      Row(children: [
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Icon(
                                                                MdiIcons
                                                                    .heartOutline,
                                                                color: Color(
                                                                    0xffAB55F7),
                                                                size: 20,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        2,
                                                                        0,
                                                                        0,
                                                                        0),
                                                                child: ReusableText(
                                                                    text:
                                                                        "${snapshot.data!.data![index].likeCount} ",
                                                                    style: appstyle(
                                                                        13,
                                                                        Color(
                                                                            0xffAB55F7),
                                                                        FontWeight
                                                                            .w400)),
                                                              ),
                                                            ]),
                                                        SizedBox(
                                                          width: 12,
                                                        ),
                                                        //save times idk
                                                        Row(children: [
                                                          Row(children: [
                                                            Icon(
                                                              MdiIcons
                                                                  .bookmarkOutline,
                                                              color: Color(
                                                                  0xffAB55F7),
                                                              size: 20,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      2,
                                                                      0,
                                                                      0,
                                                                      0),
                                                              child: ReusableText(
                                                                  text:
                                                                      " ${snapshot.data!.data![index].favorites} ",
                                                                  style: appstyle(
                                                                      13,
                                                                      Color(
                                                                          0xffAB55F7),
                                                                      FontWeight
                                                                          .w400)),
                                                            ),
                                                          ]),
                                                        ]),
                                                      ]),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            //item1 ending

                                            //item1 ending
                                          ]),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
              )
            ]),
          ),
        ));
  }
}
