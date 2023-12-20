import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/services/helpers/creator_helper.dart';
import 'package:mobile/services/helpers/profile_helper.dart';
import 'package:mobile/view/widget/profile_page.dart';
import 'package:mobile/view/widget/save_favourite.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/models/response/functionals/get_elements_by_user_name_model.dart';
import '../../common/models/response/functionals/get_elements_by_user_name_model_1.dart';
import '../../common/models/response/functionals/get_elements_by_user_name_model_2.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/reusable_text.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/models/response/functionals/view_profile_res_model.dart';
import '../../services/helpers/element_helper.dart';
import 'Request_widget.dart';
import 'chat_front_page.dart';
import 'owned_draft_elements_detail.dart';
import 'elements_detail.dart';
import 'home_page_user_logged_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'owned_rejected_elements_detail.dart';

class ViewOwnedRejectedElements extends StatefulWidget {
  const ViewOwnedRejectedElements({super.key});

  @override
  State<ViewOwnedRejectedElements> createState() =>
      _ViewOwnedRejectedElementsState();
}

class _ViewOwnedRejectedElementsState extends State<ViewOwnedRejectedElements> {
  GetElementService getElementService = GetElementService();
  Future<GetElementsFromASpecificUser> _getElementData() async {
    final items1 = await getElementService.getAll3();
    return items1;
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
    }); // Wait for each asynchronous operation to complete before starting the next one

    super.initState();
    // _profileFuture2 = _getElementData1();
    // _profileFuture3 = _getElementData2();
    // _profileFuture4 = _getElementData3();
  }

  final db = FirebaseFirestore.instance;

  int index = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print(height);
    print(width);
    return SafeArea(
        child: Scaffold(
      //  extendBodyBehindAppBar: true,
      appBar: CustomLoggedInUserAppBar(),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(indicatorColor: Colors.black),
        child: NavigationBar(
          height: 50,
          backgroundColor: Color(0xff181818),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,

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
          width: width,
          color: Colors.black,
          child: Column(
            children: [
              FutureBuilder<GetElementsFromASpecificUser>(
                future: _getElementData(),
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
                  } else if (snapshot.data!.data!.isEmpty) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                // Get.off(() =>
                                //     const CodeUIHomeScreenForLoggedInUser());
                                Get.to(ProfileWidget());
                              },
                              icon: Icon(Icons.arrow_back),
                              color: Color(0xffEC4899),
                            ),
                          ],
                        ),
                        Container(
                          height: 200,
                          child: Center(
                              child: ReusableText(
                                  text: "No rejected element here",
                                  style: appstyle(
                                      14, Colors.amber, FontWeight.w400))
                              // Handle no data case.
                              ),
                        ),
                      ],
                    );
                  } else {
                    int? indexForElements = snapshot.data!.metadata!.total;

                    String? ownerofElements =
                        snapshot.data!.data![0].ownerUsername;
                    print(indexForElements);
                    print(ownerofElements);
                    // Build your UI using the items and controller

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                // Get.off(() =>
                                //     const CodeUIHomeScreenForLoggedInUser());
                                Get.to(ProfileWidget());
                              },
                              icon: Icon(Icons.arrow_back),
                              color: Color(0xffEC4899),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ReusableText(
                                text: "Your rejected elements",
                                style: appstyle(
                                    16, Color(0xffab55f7), FontWeight.w800))
                          ],
                        ),
                        Container(
                          height: height / 1.5,
                          child: ListView.builder(
                            itemCount: snapshot.data!.metadata?.total,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var idForElements1 =
                                  snapshot.data!.data![index].id;
                              print(idForElements1);
                              return Container(
                                child: Row(children: [
                                  //item1
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                    child: Container(
                                      width: 110,
                                      height: 130,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          print(index);
                                          var idForElements =
                                              snapshot.data!.data![index].id;
                                          print("testing:${idForElements}");
                                          print(snapshot.data!.data![index]
                                              .toJson());
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          await prefs.setInt(
                                              "idForElements", idForElements!);
                                          Get.to(
                                            () => RejectedDetailedWidget(),
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
                                        child: Card(
                                          color: Colors.black,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 15, 0, 0),
                                              child: FutureBuilder(
                                                future: FirebaseFirestore
                                                    .instance
                                                    .collection('elements')
                                                    .doc("$idForElements1")
                                                    .get(),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
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

                                                    var hexColor =
                                                        document['background'];
                                                    var typeCss =
                                                        document['typeCSS'];
                                                    var fullHtmlCode;
                                                    if (typeCss == 'tailwind') {
                                                      fullHtmlCode =
                                                          '$htmlCode<style>body {height:55%, width: 35%;background:$hexColor; height:55%; display: flex; align-items: center; justify-content: center; font-family: Montserrat, sans-serif;   }$cssCode</style><script src="https://cdn.tailwindcss.com"></script>';
                                                    } else {
                                                      fullHtmlCode =
                                                          '$htmlCode<style>body { width: 35%;background:$hexColor; height: 55%; display: flex; align-items: center; justify-content: center; font-family: Montserrat, sans-serif;   }$cssCode</style>';
                                                    }
                                                    ;
                                                    int backgroundColor =
                                                        int.parse(
                                                            hexColor
                                                                .substring(1),
                                                            radix: 16);
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
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //item1 ending thumbnails
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 0, 0),
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
                                            var idForElements =
                                                snapshot.data!.data![index].id;
                                            print(idForElements);
                                            print(snapshot.data!.data![index]
                                                .toJson());
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            await prefs.setInt("idForElements",
                                                idForElements!);
                                            Get.to(
                                              () => RejectedDetailedWidget(),
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
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: width * 0.6,
                                                  child: ReusableText(
                                                      text:
                                                          "Status: ${snapshot.data!.data![index].status!} ",
                                                      style: appstyle(
                                                          16,
                                                          Color(0xffF6F0F0),
                                                          FontWeight.w400)),
                                                ),
                                              ]),

                                          //save times idk
                                        ]),
                                        //bookmarked times
                                        Row(children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ReusableText(
                                                    text:
                                                        "Creation date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(snapshot.data!.data![index].createDate!))} ",
                                                    style: appstyle(
                                                        16,
                                                        Color(0xffF6F0F0),
                                                        FontWeight.w400)),
                                              ]),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          //save times idk
                                        ]),
                                      ],
                                    ),
                                  )
                                  //item1 ending
                                ]),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
