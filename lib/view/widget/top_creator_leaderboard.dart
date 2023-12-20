import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/save_favourite.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/models/response/functionals/get_top_creator.dart';
import '../../common/models/response/functionals/save_favourite_elements_by_current_logged_in_user.dart';
import '../../components/app_bar_logged_in_user.dart';

import '../../components/liked_item.dart';
import '../../components/reusable_text.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/constants/custom_textfield.dart';
import '../../services/helpers/creator_helper.dart';
import '../../services/helpers/element_helper.dart';
import 'Request_widget.dart';
import 'chat_front_page.dart';
import 'elements_detail.dart';
import 'home_page_user_logged_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mobile/view/widget/login_page.dart';
import 'package:mobile/view/widget/profile_page.dart';
import 'package:mobile/view/widget/view_specific_profile.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../common/models/response/functionals/get_random_elements_landing.dart';
import '../../components/reusable_text_long.dart';
import '../../common/models/response/functionals/temp_creator_model.dart';
import 'home_page_guest.dart';
import 'package:mobile/view/widget/top_creator_leaderboard.dart';

class TopCreatorLeaderboardWidget extends StatefulWidget {
  const TopCreatorLeaderboardWidget({super.key});

  @override
  State<TopCreatorLeaderboardWidget> createState() =>
      _TopCreatorLeaderboardWidgetState();
}

class _TopCreatorLeaderboardWidgetState
    extends State<TopCreatorLeaderboardWidget> {
  late Future<SaveFavouriteElements> _profileFuture;
  late String _currentLoggedInUsername = "";
  Future<SaveFavouriteElements> _getData() async {
    try {
      final items = await GetElementService().getSaveFavourite();
      return items;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetTopCreator> getData1() async {
    try {
      final GetTopCreator response = (await (GetAllCreatorService().getAll1()));

      return response;
    } catch (e) {
      throw e;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("accessToken");
      var _currentLoggedInUsername =
          prefs.getString("currentLoggedInUsername")!;
      var accountIdToBeViewedInElements =
          prefs.getString("accountIdToBeViewed");

      print(_currentLoggedInUsername);
      print(accountIdToBeViewedInElements);
    });
    _profileFuture = _getData();

    super.initState();
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
            height: 50,
            backgroundColor: Color(0xff181818),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            indicatorColor: Color(0xff292929),
            indicatorShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            selectedIndex: 0,
            // onDestinationSelected: (index) => setState(() => this.index = index),
            destinations: [
              NavigationDestination(
                  icon: IconButton(
                    icon: Icon(Icons.home_outlined),
                    color: Color(0xffEC4899).withOpacity(0.4),
                    onPressed: () {
                      Get.to(CodeUIHomeScreenForLoggedInUser());
                    },
                  ),
                  label: ""),
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
                    icon: Icon(Icons.message),
                    color: Color(0xffEC4899).withOpacity(0.4),
                    onPressed: () {
                      Get.to(ChatFrontPage());
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
              NavigationDestination(
                  icon: IconButton(
                    icon: Icon(MdiIcons.codeJson),
                    color: Color(0xffEC4899).withOpacity(0.4),
                    onPressed: () {
                      Get.to(RequestWidget());
                    },
                  ),
                  label: ""),
            ],
          ),
        ),
        body: Container(
          color: Colors.black,
          height: height,
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    // Get.off(() =>
                    //     const CodeUIHomeScreenForLoggedInUser());
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back),
                  color: Color(0xffEC4899),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    MdiIcons.chartBox,
                    color: Color(0xffEC4899),
                  ),
                  ReusableText(
                    text: " Top leaderboard",
                    style: appstyle(18, Color(0xffEC4899), FontWeight.w400),
                  ),
                ],
              ),
            ),
            // wrap this
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: height / 1.65,
                child: FutureBuilder(
                  future: getData1(),
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
                      return ListView.builder(
                        itemCount: snapshot.data!.metadata!.total,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(children: [
                              //item1
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 105,
                                      width: 104,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFFAB55F7),
                                            offset: Offset(0, 1),
                                            blurRadius: 12,
                                            spreadRadius: 1.0,
                                          ),
                                        ],
                                      ),
                                      child: Card(
                                        color: Color(0xff292929),
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                        child: Stack(
                                          children: [
                                            Ink.image(
                                              image: NetworkImage(
                                                  "${snapshot.data!.data![index].imageUrl}"),
                                              height: 105,
                                              width: 104,
                                              fit: BoxFit.cover,
                                            ),
                                            // Positioned(
                                            //   bottom: 12,
                                            //   // child: ReusableText(
                                            //   //   text:
                                            //   //       "  ${index + 1}. ${items?.data?[index].username} ",
                                            //   //   style: appstyle(
                                            //   //       15,
                                            //   //       Color(kLight.value),
                                            //   //       FontWeight.w600),
                                            //   // ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // trên là cái hình elements
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          12, 0, 0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors
                                                  .transparent, // Set the button background color to transparent
                                              elevation:
                                                  0, // Remove the button shadow
                                              padding: EdgeInsets
                                                  .zero, // Remove default button padding
                                              // Reduce the button's tap target size
                                            ),
                                            onPressed: () async {
                                              var items = snapshot.data!;
                                              print(
                                                  items.data?[index].username);
                                              final accountIdToBeViewed =
                                                  items.data?[index].username;
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              await prefs.setString(
                                                  "accountIdToBeViewed",
                                                  accountIdToBeViewed!);
                                              if (accountIdToBeViewed ==
                                                  _currentLoggedInUsername) {
                                                Get.to(() =>
                                                    const ProfileWidget());
                                              } else {
                                                Get.to(() =>
                                                    const ViewSpecificProfileWidget());
                                              }
                                              // Get.to(DetailedWidget());
                                            },
                                            child: ReusableText(
                                                text:
                                                    "${index + 1}.${snapshot.data!.data![index].username} ",
                                                style: appstyle(
                                                    15,
                                                    Color(0xffF6F0F0),
                                                    FontWeight.bold)),
                                          ),

                                          //bookmarked times
                                          Row(children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ReusableText(
                                                      text:
                                                          "Elements approved: ",
                                                      style: appstyle(
                                                          16,
                                                          Color(0xffF6F0F0),
                                                          FontWeight.w400)),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(2, 0, 0, 0),
                                                    child: ReusableText(
                                                        text:
                                                            "${snapshot.data!.data![index].elementCount} ",
                                                        style: appstyle(
                                                            16,
                                                            Color(0xffAB55F7),
                                                            FontWeight.w400)),
                                                  ),
                                                ]),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            //save times idk
                                          ]),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              //item1 ending

                              //item1 ending
                            ]),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            )
          ]),
        ));
  }
}
