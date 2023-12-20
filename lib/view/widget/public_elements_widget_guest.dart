import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:mobile/view/widget/search_page_guest.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/models/response/functionals/get_all_elements_to_show.dart';
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
import 'elements_detail.dart';
import 'elements_detail_guest.dart';
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

class PublicElementsWidgetGuest extends StatefulWidget {
  const PublicElementsWidgetGuest({super.key});

  @override
  State<PublicElementsWidgetGuest> createState() =>
      _PublicElementsWidgetGuestState();
}

class _PublicElementsWidgetGuestState extends State<PublicElementsWidgetGuest> {
  late Future<SaveFavouriteElements> _profileFuture;

  Future<GetAllElementsToShow> getData2() async {
    try {
      final GetAllElementsToShow response =
          (await (GetElementService().getAllElementsToShow1()));

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

      var accountIdToBeViewedInElements =
          prefs.getString("accountIdToBeViewed");

      print(accountIdToBeViewedInElements);
    });

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
                    icon: IconButton(
                      icon: Icon(Icons.home_outlined),
                      color: Color(0xffEC4899),
                      onPressed: () {
                        Get.to(CodeUIHomeScreenForGuest());
                      },
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
                    MdiIcons.codeJson,
                    color: Color(0xffEC4899),
                  ),
                  ReusableText(
                    text: " Public elements",
                    style: appstyle(18, Color(0xffEC4899), FontWeight.w400),
                  ),
                ],
              ),
            ),
            // wrap this
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: height / 1.6,
                child: FutureBuilder(
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
                      return ListView.builder(
                        itemCount: 25,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                height: height * 0.85,
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
                                        Container(
                                          width: 110,
                                          height: 130,
                                          child: ElevatedButton(
                                            onPressed: () async {
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
                                                              '$htmlCode<style>body {height:55%, width: 35%;background:$hexColor; height:55%; display: flex; align-items: center; justify-content: center; font-family: Montserrat, sans-serif;   }$cssCode</style><script src="https://cdn.tailwindcss.com"></script>';
                                                        } else {
                                                          fullHtmlCode =
                                                              '$htmlCode<style>body { width: 35%;background:$hexColor; height: 55%; display: flex; align-items: center; justify-content: center; font-family: Montserrat, sans-serif;   }$cssCode</style>';
                                                        }
                                                        ;

                                                        int backgroundColor =
                                                            int.parse(
                                                                hexColor
                                                                    .substring(
                                                                        1),
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
                                        //item1 ending thumbnails
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 0, 0, 0),
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
                                                  print(snapshot
                                                      .data!.data![index]
                                                      .toJson());
                                                  SharedPreferences prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  await prefs.setInt(
                                                      "idForElements",
                                                      idForElements!);
                                                  Get.to(
                                                    () => GuestDetailedWidget(),
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: width * 0.6,
                                                        child: ReusableText(
                                                            text:
                                                                "Owner: ${snapshot.data!.data![index].profileResponse!.username!} ",
                                                            style: appstyle(
                                                                16,
                                                                Color(
                                                                    0xffF6F0F0),
                                                                FontWeight
                                                                    .w400)),
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Icon(
                                                        MdiIcons.heartOutline,
                                                        color:
                                                            Color(0xffAB55F7),
                                                        size: 20,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                2, 0, 0, 0),
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
                                                      MdiIcons.bookmarkOutline,
                                                      color: Color(0xffAB55F7),
                                                      size: 20,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(2, 0, 0, 0),
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
                                        //item1 ending
                                      ]),
                                    );
                                  },
                                ),
                              ),
                            ],
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
