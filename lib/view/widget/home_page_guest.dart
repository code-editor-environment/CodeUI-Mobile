import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/common/models/response/functionals/get_random_elements_landing.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/login_page.dart';
import 'package:mobile/view/widget/public_elements_widget.dart';
import 'package:mobile/view/widget/public_elements_widget_guest.dart';
import 'package:mobile/view/widget/search_page_guest.dart';
import 'package:mobile/view/widget/top_creator_leaderboard.dart';
import 'package:mobile/view/widget/top_creator_leaderboard_guest.dart';
import 'package:mobile/view/widget/view_specific_profile.dart';
import 'package:mobile/view/widget/view_specific_profile_guest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../common/models/response/functionals/get_all_elements_to_show.dart';
import '../../components/reusable_text.dart';
import '../../components/reusable_text_for_long_text.dart';
import '../../components/reusable_text_long.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/models/response/functionals/temp_creator_model.dart';
import '../../services/helpers/creator_helper.dart';
import '../../common/models/response/functionals/get_top_creator.dart';
import '../../services/helpers/element_helper.dart';
import 'elements_detail.dart';
import 'elements_detail_guest.dart';

class CodeUIHomeScreenForGuest extends StatefulWidget {
  const CodeUIHomeScreenForGuest({super.key});

  @override
  State<CodeUIHomeScreenForGuest> createState() =>
      _CodeUIHomeScreenForGuestState();
}

class _CodeUIHomeScreenForGuestState extends State<CodeUIHomeScreenForGuest> {
  late Future<AllCreatorsTempModel> _creatorFuture;
  late Future<List<AllCreatorsTempModel>> items;
  Future<AllCreatorsTempModel> getData() async {
    try {
      final AllCreatorsTempModel response =
          (await (GetAllCreatorService().getAll()));

      return response;
    } catch (e) {
      throw e;
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
  void initState() {
    _creatorFuture = getData();
    super.initState();
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

          selectedIndex: 0,
          // onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: NavigationDestination(
                  icon: Icon(
                    Icons.home_outlined,
                    color: Color(0xffEC4899),
                  ),
                  label: ""),
            ),
            NavigationDestination(
                icon: IconButton(
                  icon: Icon(Icons.search),
                  color: Color(0xffEC4899).withOpacity(0.4),
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
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            children: [
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
                          Get.to(
                              () => const TopCreatorLeaderboardGuestWidget());
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
                                      Get.to(() =>
                                          const ViewSpecificProfileGuestWidget());
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
                          Get.to(() => const PublicElementsWidgetGuest());
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
                  color: Colors.black,
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
                            return Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 8, 0),
                                  child: Column(
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
                                          print(idForElements);
                                          print(snapshot.data!.data![index]
                                              .toJson());
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          await prefs.setInt(
                                              "idForElements", idForElements!);
                                          Get.to(
                                            () => GuestDetailedWidget(),
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
                                ),
                              ],
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
