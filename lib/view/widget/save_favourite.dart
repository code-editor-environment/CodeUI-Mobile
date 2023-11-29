import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../common/models/response/functionals/save_favourite_elements_by_current_logged_in_user.dart';
import '../../components/app_bar_logged_in_user.dart';

import '../../components/liked_item.dart';
import '../../components/reusable_text.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/constants/custom_textfield.dart';
import '../../services/helpers/element_helper.dart';
import 'elements_detail.dart';
import 'home_page_user_logged_in.dart';

class BookmarkedOwnedWidget extends StatefulWidget {
  const BookmarkedOwnedWidget({super.key});

  @override
  State<BookmarkedOwnedWidget> createState() => _BookmarkedOwnedWidgetState();
}

class _BookmarkedOwnedWidgetState extends State<BookmarkedOwnedWidget> {
  late Future<SaveFavouriteElements> _profileFuture;
  Future<SaveFavouriteElements> _getData() async {
    try {
      final items = await GetElementService().getSaveFavourite();
      return items;
    } catch (e) {
      rethrow;
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
            selectedIndex: 2,
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
                    color: Color(0xffEC4899),
                    onPressed: () {
                      Get.to(BookmarkedOwnedWidget());
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    MdiIcons.bookmarkOutline,
                    color: Color(0xffEC4899),
                  ),
                  ReusableText(
                    text: " Save favourite",
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
                      return ListView.builder(
                        itemCount: snapshot.data!.metadata!.total,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(16, 28, 0, 0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(children: [
                                //item1
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 125,
                                      width: 114,
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
                                            Container(
                                              child: Column(
                                                children: [
                                                  Row(children: [
                                                    //item1
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 104,
                                                          height: 101,
                                                          child: ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              print(index);
                                                              var idForElements =
                                                                  snapshot
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .id;
                                                              print(
                                                                  idForElements);
                                                              print(snapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .toJson());
                                                              SharedPreferences
                                                                  prefs =
                                                                  await SharedPreferences
                                                                      .getInstance();
                                                              await prefs.setInt(
                                                                  "idForElements",
                                                                  idForElements!);
                                                              Get.to(
                                                                () =>
                                                                    DetailedWidget(),
                                                              );
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent, // Set the button background color to transparent
                                                              elevation:
                                                                  1, // Remove the button shadow
                                                              padding: EdgeInsets
                                                                  .fromLTRB(
                                                                      8,
                                                                      24,
                                                                      0,
                                                                      12), // Remove default button padding
                                                              // Reduce the button's tap target size
                                                            ),
                                                            child: Card(
                                                              child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .fromLTRB(
                                                                          0,
                                                                          8,
                                                                          0,
                                                                          0),
                                                                  child:
                                                                      FutureBuilder(
                                                                    future: FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'elements')
                                                                        .doc(
                                                                            "${snapshot.data!.data![index].id}")
                                                                        .get(),
                                                                    builder:
                                                                        (context,
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
                                                                            child:
                                                                                Text('Error loading data'));
                                                                      } else if (!snapshot
                                                                          .hasData) {
                                                                        return Center(
                                                                            child:
                                                                                Text('No data available'));
                                                                      } else {
                                                                        var document =
                                                                            snapshot.data!;

                                                                        var htmlCode =
                                                                            document['html'];
                                                                        var cssCode =
                                                                            document['css'];
                                                                        var fullHtmlCode =
                                                                            '<style>body {             zoom: 1.75;      } $cssCode</style>$htmlCode';
                                                                        var hexColor =
                                                                            document['background'];
                                                                        int backgroundColor = int.parse(
                                                                            hexColor.substring(
                                                                                1),
                                                                            radix:
                                                                                16);
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
                                              // Get.to(DetailedWidget());
                                              print(index);
                                              var idForElements = snapshot
                                                  .data!.data![index].id;
                                              print(idForElements);
                                              print(snapshot.data!.data![index]
                                                  .toJson());
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              await prefs.setInt(
                                                  "idForElements",
                                                  idForElements!);
                                              Get.to(
                                                () => DetailedWidget(),
                                              );
                                            },
                                            child: ReusableText(
                                                text:
                                                    "Elements name: ${snapshot.data!.data![index].title} ",
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
                                                  Container(
                                                    width: width * 0.6,
                                                    child: ReusableText(
                                                        text:
                                                            "Owner: ${snapshot.data!.data![index].profileResponse!.username!} ",
                                                        style: appstyle(
                                                            16,
                                                            Color(0xffEC4899),
                                                            FontWeight.w400)),
                                                  ),
                                                ]),

                                            //save times idk
                                          ]),
                                          //bookmarked times
                                          Row(children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    MdiIcons.heartOutline,
                                                    color: Color(0xffAB55F7),
                                                    size: 20,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(2, 0, 0, 0),
                                                    child: ReusableText(
                                                        text:
                                                            "${snapshot.data!.data![index].likeCount} ",
                                                        style: appstyle(
                                                            13,
                                                            Color(0xffAB55F7),
                                                            FontWeight.w400)),
                                                  ),
                                                ]),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            //save times idk
                                            Row(children: [
                                              Row(children: [
                                                Icon(
                                                  MdiIcons.bookmarkOutline,
                                                  color: Color(0xffAB55F7),
                                                  size: 20,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          2, 0, 0, 0),
                                                  child: ReusableText(
                                                      text:
                                                          " ${snapshot.data!.data![index].favorites} ",
                                                      style: appstyle(
                                                          13,
                                                          Color(0xffAB55F7),
                                                          FontWeight.w400)),
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
