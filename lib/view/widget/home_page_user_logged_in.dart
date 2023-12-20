import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:mobile/view/widget/elements_detail.dart';
import 'package:mobile/view/widget/login_page.dart';
import 'package:mobile/view/widget/profile_page.dart';
import 'package:mobile/view/widget/public_elements_widget.dart';
import 'package:mobile/view/widget/save_favourite.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:mobile/view/widget/view_specific_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../common/models/response/functionals/get_all_elements_to_show.dart';
import '../../common/models/response/functionals/get_random_elements_landing.dart';
import '../../common/models/response/functionals/get_top_creator.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/reusable_text.dart';
import '../../components/reusable_text_long.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/models/response/functionals/temp_creator_model.dart';
import '../../services/helpers/creator_helper.dart';
import '../../services/helpers/element_helper.dart';
import 'Request_widget.dart';
import 'chat_front_page.dart';
import 'home_page_guest.dart';
import 'package:mobile/view/widget/top_creator_leaderboard.dart';

class CodeUIHomeScreenForLoggedInUser extends StatefulWidget {
  const CodeUIHomeScreenForLoggedInUser({super.key});

  @override
  State<CodeUIHomeScreenForLoggedInUser> createState() =>
      _CodeUIHomeScreenForLoggedInUserState();
}

class _CodeUIHomeScreenForLoggedInUserState
    extends State<CodeUIHomeScreenForLoggedInUser> {
  late Future<AllCreatorsTempModel> _creatorFuture;
  late Future<List<AllCreatorsTempModel>> items;
  late String _currentLoggedInUsername = "";
  Future<AllCreatorsTempModel> getData() async {
    // try {
    //   final AllCreatorsTempModel response =
    //       (await (GetAllCreatorService().getAll()));

    //   return response;
    // } catch (e) {
    //   throw e;
    // }
    final AllCreatorsTempModel response =
        (await (GetAllCreatorService().getAll()));

    return response;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("accessToken");
      if (token == null) {
        Get.to(() => const CodeUIHomeScreenForGuest());
      }
      _currentLoggedInUsername = prefs.getString("currentLoggedInUsername")!;
    });
    _creatorFuture = getData();

    super.initState();
  }

  Future<GetTopCreator> getData1() async {
    try {
      final GetTopCreator response = (await (GetAllCreatorService().getAll1()));

      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<GetAllElementsToShow> getData2() async {
    try {
      final GetAllElementsToShow response =
          (await (GetElementService().getAllElementsToShow()));

      return response;
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    print(_currentLoggedInUsername);
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
          selectedIndex: 0,
          indicatorShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          // onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: [
            NavigationDestination(
                icon: Icon(
                  Icons.home_outlined,
                  color: Color(0xffEC4899),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            children: [
              //categories
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              //       child: ReusableText(
              //         text: "ALL CREATORS",
              //         style: appstyle(16, Color(0xFFF6F0F0), FontWeight.w600),
              //       ),
              //     ),
              //   ],
              // ),
              // // starting categories
              // // starting categories
              // SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: SizedBox(
              //       height: 170,
              //       width: width,
              //       child: Container(
              //           child: FutureBuilder<AllCreatorsTempModel>(
              //         future: _creatorFuture,
              //         builder: (context, snapshot) {
              //           if (snapshot.connectionState ==
              //               ConnectionState.waiting) {
              //             return Center(
              //                 child:
              //                     CircularProgressIndicator()); // Show a loading indicator while waiting for data.
              //           } else if (snapshot.hasError) {
              //             return Center(
              //               child: Text('Error: ${snapshot.error}'),
              //             ); // Handle the error.
              //           } else if (!snapshot.hasData) {
              //             return Center(
              //               child: Text(
              //                   'No data available'), // Handle no data case.
              //             );
              //           } else {
              //             // Access metadata property after the Future completes
              //             var items = snapshot.data!;
              //             var total = items.metadata?.total ??
              //                 0; // Access total property
              //             return ListView.builder(
              //               itemCount: items?.metadata?.total,
              //               scrollDirection: Axis.horizontal,
              //               itemBuilder: (context, index) {
              //                 return Row(
              //                   children: [
              //                     Padding(
              //                       padding:
              //                           const EdgeInsets.fromLTRB(8, 0, 8, 8),
              //                       child: Column(
              //                         children: [
              //                           Container(
              //                             height: 105,
              //                             width: 104,
              //                             decoration: BoxDecoration(
              //                               borderRadius:
              //                                   BorderRadius.circular(24),
              //                               boxShadow: [
              //                                 BoxShadow(
              //                                   color: Color(0xFFAB55F7),
              //                                   offset: Offset(0, 1),
              //                                   blurRadius: 12,
              //                                   spreadRadius: 1.0,
              //                                 ),
              //                               ],
              //                             ),
              //                             child: Card(
              //                               color: Color(0xff292929),
              //                               clipBehavior: Clip.antiAlias,
              //                               shape: RoundedRectangleBorder(
              //                                 borderRadius:
              //                                     BorderRadius.circular(24),
              //                               ),
              //                               child: Stack(
              //                                 children: [
              //                                   ElevatedButton(
              //                                     onPressed: () async {
              //                                       print(items
              //                                           .data?[index].username);
              //                                       final accountIdToBeViewed =
              //                                           items.data?[index]
              //                                               .username;
              //                                       SharedPreferences prefs =
              //                                           await SharedPreferences
              //                                               .getInstance();
              //                                       await prefs.setString(
              //                                           "accountIdToBeViewed",
              //                                           accountIdToBeViewed!);
              //                                       showModalBottomSheet(
              //                                         context: context,
              //                                         backgroundColor:
              //                                             Color(0xff252525),
              //                                         builder: (context) =>
              //                                             Container(
              //                                           height: height * 0.3,
              //                                           child: Row(
              //                                             mainAxisAlignment:
              //                                                 MainAxisAlignment
              //                                                     .spaceBetween,
              //                                             crossAxisAlignment:
              //                                                 CrossAxisAlignment
              //                                                     .center,
              //                                             children: [
              //                                               CircleAvatar(
              //                                                 radius: 48,
              //                                                 backgroundColor:
              //                                                     Color(
              //                                                         0xff292929),
              //                                                 child: Card(
              //                                                   color: Color(
              //                                                       0xff292929),
              //                                                   clipBehavior: Clip
              //                                                       .antiAlias,
              //                                                   shape:
              //                                                       RoundedRectangleBorder(
              //                                                     borderRadius:
              //                                                         BorderRadius
              //                                                             .circular(
              //                                                                 48),
              //                                                   ),
              //                                                   child: Stack(
              //                                                     children: [
              //                                                       Ink.image(
              //                                                         image: NetworkImage(
              //                                                             "${items.data![index].profileResponse?.imageUrl}"),
              //                                                         height:
              //                                                             76,
              //                                                         width: 76,
              //                                                         fit: BoxFit
              //                                                             .cover,
              //                                                       ),
              //                                                     ],
              //                                                   ),
              //                                                 ),
              //                                               ),
              //                                               Padding(
              //                                                 padding:
              //                                                     const EdgeInsets
              //                                                             .fromLTRB(
              //                                                         2,
              //                                                         0,
              //                                                         0,
              //                                                         0),
              //                                                 child: Column(
              //                                                     mainAxisAlignment:
              //                                                         MainAxisAlignment
              //                                                             .center,
              //                                                     crossAxisAlignment:
              //                                                         CrossAxisAlignment
              //                                                             .start,
              //                                                     children: [
              //                                                       ReusableText(
              //                                                           text:
              //                                                               "${items.data?[index].profileResponse?.firstName} ${items.data?[index].profileResponse?.lastName}",
              //                                                           style: appstyle(
              //                                                               18,
              //                                                               Color(0xffF6F0F0),
              //                                                               FontWeight.w600)),
              //                                                       Container(
              //                                                         width: width *
              //                                                             0.33,
              //                                                         child: ReusableText(
              //                                                             text:
              //                                                                 "@${items.data?[index].username} ",
              //                                                             style: appstyle(
              //                                                                 14,
              //                                                                 Color(0xffF6F0F0),
              //                                                                 FontWeight.w400)),
              //                                                       ),
              //                                                       ReusableText(
              //                                                           text:
              //                                                               "Followings:${items.data![index].profileResponse!.totalFollowing} ",
              //                                                           style: appstyle(
              //                                                               12,
              //                                                               Color(0xffF6F0F0),
              //                                                               FontWeight.w400)),
              //                                                     ]),
              //                                               ),
              //                                               Padding(
              //                                                 padding:
              //                                                     const EdgeInsets
              //                                                             .fromLTRB(
              //                                                         0,
              //                                                         28,
              //                                                         0,
              //                                                         0),
              //                                                 child: Column(
              //                                                   children: [
              //                                                     IconButton(
              //                                                       onPressed:
              //                                                           () {
              //                                                         if (accountIdToBeViewed ==
              //                                                             _currentLoggedInUsername) {
              //                                                           Get.to(() =>
              //                                                               const ProfileWidget());
              //                                                         } else {
              //                                                           Get.to(() =>
              //                                                               const ViewSpecificProfileWidget());
              //                                                         }
              //                                                       },
              //                                                       icon: Icon(Icons
              //                                                           .account_circle_outlined),
              //                                                       color: Color(
              //                                                           0xff8026D9),
              //                                                       iconSize:
              //                                                           36,
              //                                                     ),
              //                                                     IconButton(
              //                                                       onPressed:
              //                                                           () {},
              //                                                       icon: Icon(
              //                                                           MdiIcons
              //                                                               .messageProcessing),
              //                                                       color: Color(
              //                                                           0xff8026D9),
              //                                                       iconSize:
              //                                                           36,
              //                                                     ),
              //                                                   ],
              //                                                 ),
              //                                               ),
              //                                             ],
              //                                           ),
              //                                         ),
              //                                       );
              //                                     },
              //                                     style:
              //                                         ElevatedButton.styleFrom(
              //                                       backgroundColor: Colors
              //                                           .transparent, // Set the button background color to transparent
              //                                       elevation:
              //                                           0, // Remove the button shadow
              //                                       padding: EdgeInsets
              //                                           .zero, // Remove default button padding
              //                                       // Reduce the button's tap target size
              //                                     ),
              //                                     child: Ink.image(
              //                                       image: NetworkImage(
              //                                           "${items.data![index].profileResponse?.imageUrl}"),
              //                                       height: 105,
              //                                       width: 104,
              //                                       fit: BoxFit.cover,
              //                                     ),
              //                                   ),
              //                                   // Positioned(
              //                                   //   bottom: 12,
              //                                   //   // child: ReusableText(
              //                                   //   //   text:
              //                                   //   //       "  ${index + 1}. ${items?.data?[index].username} ",
              //                                   //   //   style: appstyle(
              //                                   //   //       15,
              //                                   //   //       Color(kLight.value),
              //                                   //   //       FontWeight.w600),
              //                                   //   // ),
              //                                   // ),
              //                                 ],
              //                               ),
              //                             ),
              //                           ),
              //                           Container(
              //                             width: 80,
              //                             child: ReusableTextLong(
              //                               text:
              //                                   "  ${index + 1}. ${items?.data?[index].username} ",
              //                               style: appstyle(
              //                                   15,
              //                                   Color(kLight.value),
              //                                   FontWeight.w600),
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ],
              //                 );
              //               },
              //             );
              //           }
              //         },
              //       )),
              //     )),
              // // end of scroll row

              //see more lol
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: ReusableText(
                      text: "TOP CREATORS",
                      style: appstyle(16, Color(0xFFF6F0F0), FontWeight.w600),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const TopCreatorLeaderboardWidget());
                        },
                        child: ReusableText(
                          text: "See more",
                          style:
                              appstyle(15, Color(0xFFAB55F7), FontWeight.w600),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_outlined,
                        color: Color(0xFFAB55F7),
                      ),
                    ],
                  ),
                ],
              ),
              // starting categories
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    height: 170,
                    width: width,
                    child: Container(
                        child: FutureBuilder<GetTopCreator>(
                      future: getData1(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child:
                                  CircularProgressIndicator()); // Show a loading indicator while waiting for data.
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          ); // Handle the error.
                        } else if (!snapshot.hasData) {
                          return Center(
                            child: Text(
                                'No data available'), // Handle no data case.
                          );
                        } else {
                          // Access metadata property after the Future completes
                          var items = snapshot.data!;

                          return ListView.builder(
                            itemCount: items.metadata?.total,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      print(items.data?[index].username);
                                      final accountIdToBeViewed =
                                          items.data?[index].username;
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setString(
                                          "accountIdToBeViewed",
                                          accountIdToBeViewed!);
                                      if (accountIdToBeViewed ==
                                          _currentLoggedInUsername) {
                                        Get.to(() => const ProfileWidget());
                                      } else {
                                        Get.to(() =>
                                            const ViewSpecificProfileWidget());
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors
                                          .transparent, // Set the button background color to transparent
                                      elevation: 0, // Remove the button shadow
                                      padding: EdgeInsets
                                          .zero, // Remove default button padding
                                      // Reduce the button's tap target size
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 105,
                                            width: 104,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(24),
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
                                                        "${items.data![index].imageUrl}"),
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
                                          Container(
                                            width: 80,
                                            child: ReusableTextLong(
                                              text:
                                                  "  ${index + 1}. ${items?.data?[index].username} ",
                                              style: appstyle(
                                                  15,
                                                  Color(kLight.value),
                                                  FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    )),
                  )), //see more lol
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: ReusableText(
                      text: "PUBLIC ELEMENTS",
                      style: appstyle(16, Color(0xFFF6F0F0), FontWeight.w600),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const PublicElementsWidget());
                        },
                        child: ReusableText(
                          text: "See more",
                          style:
                              appstyle(15, Color(0xFFAB55F7), FontWeight.w600),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_outlined,
                        color: Color(0xFFAB55F7),
                      ),
                    ],
                  ),
                ],
              ),
              // starting categories
              Container(
                  width: width,
                  height: 240,
                  child: FutureBuilder<GetAllElementsToShow>(
                    future: getData2(),
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
                        // Access metadata property after the Future completes
                        var items = snapshot.data!;

                        return ListView.builder(
                          itemCount: snapshot.data!.data!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 8, 0),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 125,
                                        width: 153,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(21),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFFAB55F7),
                                              offset: Offset(0, 1),
                                              blurRadius: 12,
                                            ),
                                          ],
                                        ),
                                        child: Card(
                                          color: Color(0xff292929),
                                          clipBehavior: Clip.antiAlias,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Stack(
                                            children: [
                                              Container(
                                                color: Colors.black,
                                                child: Column(
                                                  children: [
                                                    Row(children: [
                                                      //item1
                                                      Column(
                                                        children: [
                                                          Container(
                                                            width: 145,
                                                            height: 116.85,
                                                            child: Card(
                                                              child:
                                                                  FutureBuilder(
                                                                future: FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'elements')
                                                                    .doc(
                                                                        "${snapshot.data!.data![index].id}")
                                                                    .get(),
                                                                builder: (context,
                                                                    snapshot) {
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
                                                                        snapshot
                                                                            .data!;

                                                                    var htmlCode =
                                                                        document[
                                                                            'html'];
                                                                    var cssCode =
                                                                        document[
                                                                            'css'];

                                                                    var hexColor =
                                                                        document[
                                                                            'background'];
                                                                    var typeCss =
                                                                        document[
                                                                            'typeCSS'];
                                                                    var fullHtmlCode;
                                                                    if (typeCss ==
                                                                        'tailwind') {
                                                                      fullHtmlCode =
                                                                          '$htmlCode<style>body { width: 55%;background:$hexColor; height:55%; display: flex; align-items: center; justify-content: center; font-family: Montserrat, sans-serif;   }$cssCode</style><script src="https://cdn.tailwindcss.com"></script>';
                                                                    } else {
                                                                      fullHtmlCode =
                                                                          '$htmlCode<style>body { width: 55%;background:$hexColor; height: 55%; display: flex; align-items: center; justify-content: center; font-family: Montserrat, sans-serif;   }$cssCode</style>';
                                                                    }
                                                                    ;

                                                                    int backgroundColor = int.parse(
                                                                        hexColor
                                                                            .substring(
                                                                                1),
                                                                        radix:
                                                                            16);
                                                                    return WebViewWidget(
                                                                      controller:
                                                                          WebViewController()
                                                                            ..setJavaScriptMode(JavaScriptMode.unrestricted)
                                                                            ..loadHtmlString(fullHtmlCode)
                                                                            ..clearLocalStorage(),
                                                                    );
                                                                  }
                                                                },
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
                                      ElevatedButton(
                                        onPressed: () async {
                                          print(index);
                                          var idForElements =
                                              snapshot.data!.data![index].id;
                                          print("22112222$idForElements");
                                          print(snapshot.data!.data![index]
                                              .toJson());

                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          await prefs.setInt(
                                              "idForElements", idForElements!);
                                          Get.to(
                                            () => DetailedWidget(),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors
                                              .transparent, // Set the button background color to transparent
                                          elevation:
                                              0, // Remove the button shadow
                                          padding: EdgeInsets
                                              .zero, // Remove default button padding
                                          // Reduce the button's tap target size
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 8, 0, 0),
                                          child: ReusableText(
                                            text:
                                                "Name: ${snapshot.data!.data![index].title}",
                                            style: appstyle(
                                                14,
                                                Color(0xfff0f0f0),
                                                FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  )),
              // // end of scroll row
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
