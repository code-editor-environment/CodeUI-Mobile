import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/elements_detail_guest.dart';
import 'package:mobile/view/widget/save_favourite.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:mobile/view/widget/search_page_guest.dart';
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
import 'home_page_guest.dart';
import 'home_page_user_logged_in.dart';
import 'modeator_search_page.dart';

class UserApprovedElementsListViewByCategoryFilteringGuest
    extends StatefulWidget {
  const UserApprovedElementsListViewByCategoryFilteringGuest({super.key});

  @override
  State<UserApprovedElementsListViewByCategoryFilteringGuest> createState() =>
      _UserApprovedElementsListViewByCategoryFilteringGuestState();
}

class _UserApprovedElementsListViewByCategoryFilteringGuestState
    extends State<UserApprovedElementsListViewByCategoryFilteringGuest> {
  late Future<ModeratorElementsFilteredByCategoriesName> _profileFuture;
  late var category = "";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("accessToken");

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
        appBar: CustomGuestAppBar(),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(indicatorColor: Colors.black),
          child: NavigationBar(
            height: 50,
            backgroundColor: Color(0xff181818),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,

            selectedIndex: 1,
            // onDestinationSelected: (index) => setState(() => this.index = index),
            destinations: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: NavigationDestination(
                    icon: IconButton(
                      icon: Icon(Icons.home_outlined),
                      color: Color(0xffEC4899).withOpacity(0.4),
                      onPressed: () {
                        Get.to(CodeUIHomeScreenForGuest());
                      },
                    ),
                    label: ""),
              ),
              NavigationDestination(
                  icon: IconButton(
                    icon: Icon(Icons.search),
                    color: Color(0xffEC4899),
                    onPressed: () {
                      Get.to(SearchWidgetGuest());
                    },
                  ),
                  label: ""),
            ],
          ),
        ),
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
                      Get.to(() => const SearchWidgetGuest());
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
                                                    boxShadow: [],
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
                                                                          105,
                                                                      height:
                                                                          111,
                                                                      child:
                                                                          Card(
                                                                        color: Colors
                                                                            .black,
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

                                                                                  var hexColor = document['background'];
                                                                                  var typeCss = document['typeCSS'];
                                                                                  var fullHtmlCode;
                                                                                  if (typeCss == 'tailwind') {
                                                                                    fullHtmlCode = '$htmlCode<style>body { width: 40%;background:$hexColor; height:45%; display: flex; align-items: center; justify-content: center; font-family: Montserrat, sans-serif;   }$cssCode</style><script src="https://cdn.tailwindcss.com"></script>';
                                                                                  } else {
                                                                                    fullHtmlCode = '$htmlCode<style>body { width: 40%;background:$hexColor; height: 45%; display: flex; align-items: center; justify-content: center; font-family: Montserrat, sans-serif;   }$cssCode</style>';
                                                                                  }
                                                                                  ;
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
                                                      Container(
                                                        width: width * 0.5,
                                                        child: ReusableText(
                                                            text:
                                                                "Owner: ${snapshot.data!.data![index].profileResponse!.username} ",
                                                            style: appstyle(
                                                                15,
                                                                Color(
                                                                    0xffEC4899),
                                                                FontWeight
                                                                    .w600)),
                                                      ),
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
                                                              const GuestDetailedWidget());
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
