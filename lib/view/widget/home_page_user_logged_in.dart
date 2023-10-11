import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/login_page.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:mobile/view/widget/view_specific_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/reusable_text.dart';
import '../../components/reusable_text_long.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_style.dart';
import '../../models/response/functionals/profile_res_model.dart';
import '../../models/response/functionals/temp_creator_model.dart';
import '../../services/helpers/creator_helper.dart';
import '../../services/helpers/profile_helper.dart';

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
    });
    _creatorFuture = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
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
                    Get.to(SearchWidget());
                  },
                ),
                label: ""),
            NavigationDestination(
                icon: Icon(
                  MdiIcons.messageProcessing,
                  color: Color(0xffEC4899).withOpacity(0.4),
                ),
                label: ""),
            NavigationDestination(
                icon: Icon(
                  Icons.bookmarks_outlined,
                  color: Color(0xffEC4899).withOpacity(0.4),
                ),
                label: ""),
            NavigationDestination(
                icon: IconButton(
                  icon: Icon(Icons.shopping_cart_outlined),
                  color: Color(0xffEC4899).withOpacity(0.4),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Get.off(() => const LoginWidget());
                  },
                ),
                label: ""),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: height * 0.8,
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            children: [
              //categories
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 0, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ReusableText(
                    text: "TOP CREATORS",
                    style: appstyle(16, Color(0xFFF6F0F0), FontWeight.w600),
                  ),
                ),
              ),
              // starting categories
              // starting categories
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    height: 170,
                    width: width,
                    child: Container(
                        child: FutureBuilder<AllCreatorsTempModel>(
                      future: _creatorFuture,
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
                          var total = items.metadata?.total ??
                              0; // Access total property
                          return ListView.builder(
                            itemCount: items?.metadata?.total,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Padding(
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
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    print(items
                                                        .data?[index].username);
                                                    final accountIdToBeViewed =
                                                        items.data?[index]
                                                            .username;
                                                    SharedPreferences prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    await prefs.setString(
                                                        "accountIdToBeViewed",
                                                        accountIdToBeViewed!);
                                                    showModalBottomSheet(
                                                      context: context,
                                                      backgroundColor:
                                                          Color(0xff252525),
                                                      builder: (context) =>
                                                          Container(
                                                        height: 150,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 48,
                                                              backgroundColor:
                                                                  Color(
                                                                      0xff292929),
                                                              child: Card(
                                                                color: Color(
                                                                    0xff292929),
                                                                clipBehavior: Clip
                                                                    .antiAlias,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              48),
                                                                ),
                                                                child: Stack(
                                                                  children: [
                                                                    Ink.image(
                                                                      image: NetworkImage(
                                                                          "${items.data![index].profileResponse?.imageUrl}"),
                                                                      height:
                                                                          76,
                                                                      width: 76,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      2,
                                                                      0,
                                                                      0,
                                                                      0),
                                                              child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    ReusableText(
                                                                        text:
                                                                            "${items.data?[index].profileResponse?.firstName} ${items.data?[index].profileResponse?.lastName}",
                                                                        style: appstyle(
                                                                            18,
                                                                            Color(0xffF6F0F0),
                                                                            FontWeight.w600)),
                                                                    Container(
                                                                      width:
                                                                          200,
                                                                      child: ReusableText(
                                                                          text:
                                                                              "@${items.data?[index].username} ",
                                                                          style: appstyle(
                                                                              14,
                                                                              Color(0xffF6F0F0),
                                                                              FontWeight.w400)),
                                                                    ),
                                                                    ReusableText(
                                                                        text:
                                                                            "Followings:${items.data?[index].followFollowings} ",
                                                                        style: appstyle(
                                                                            12,
                                                                            Color(0xffF6F0F0),
                                                                            FontWeight.w400)),
                                                                  ]),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      0,
                                                                      28,
                                                                      0,
                                                                      0),
                                                              child: Column(
                                                                children: [
                                                                  IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      Get.to(() =>
                                                                          const ViewSpecificProfileWidget());
                                                                    },
                                                                    icon: Icon(Icons
                                                                        .account_circle_outlined),
                                                                    color: Color(
                                                                        0xff8026D9),
                                                                    iconSize:
                                                                        36,
                                                                  ),
                                                                  IconButton(
                                                                    onPressed:
                                                                        () {},
                                                                    icon: Icon(
                                                                        MdiIcons
                                                                            .messageProcessing),
                                                                    color: Color(
                                                                        0xff8026D9),
                                                                    iconSize:
                                                                        36,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
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
                                                  child: Ink.image(
                                                    image: NetworkImage(
                                                        "${items.data![index].profileResponse?.imageUrl}"),
                                                    height: 105,
                                                    width: 104,
                                                    fit: BoxFit.cover,
                                                  ),
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
                                ],
                              );
                            },
                          );
                        }
                      },
                    )),
                  )),
              // end of scroll row
              //see more lol
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 2, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ReusableText(
                      text: "See more",
                      style: appstyle(14, Color(0xFFAB55F7), FontWeight.w600),
                    ),
                    Icon(
                      Icons.chevron_right_outlined,
                      color: Color(0xFFAB55F7),
                    ),
                  ],
                ),
              ),
              //categories
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 0, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ReusableText(
                    text: "RECENTLY SEEN",
                    style: appstyle(18, Color(0xFFF6F0F0), FontWeight.w600),
                  ),
                ),
              ),
              // // starting categories
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              //         child: Container(
              //           height: 165,
              //           width: 164,
              //           child: Card(
              //             color: Color(0xff292929),
              //             clipBehavior: Clip.antiAlias,
              //             shape: const RoundedRectangleBorder(
              //               borderRadius: BorderRadius.all(Radius.circular(24)),
              //             ),
              //             child: Stack(
              //               children: [
              //                 Padding(
              //                   padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              //                   child: Align(
              //                     alignment: Alignment.centerLeft,
              //                     heightFactor: 1.6,
              //                     child: Ink.image(
              //                       image: const AssetImage(
              //                           "assets/images/compo1.png"),
              //                       height: 64,
              //                       width: 64,
              //                       fit: BoxFit.cover,
              //                     ),
              //                   ),
              //                 ),
              //                 Positioned(
              //                   bottom: 12,
              //                   child: ReusableText(
              //                     text: " Buttons ",
              //                     style: appstyle(
              //                         15, Color(kLight.value), FontWeight.w600),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //       //content 1
              //       Padding(
              //         padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              //         child: Container(
              //           height: 165,
              //           width: 164,
              //           child: Card(
              //             color: Color(0xff292929),
              //             clipBehavior: Clip.antiAlias,
              //             shape: const RoundedRectangleBorder(
              //               borderRadius: BorderRadius.all(Radius.circular(24)),
              //             ),
              //             child: Stack(
              //               children: [
              //                 Padding(
              //                   padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              //                   child: Align(
              //                     alignment: Alignment.centerLeft,
              //                     heightFactor: 1.6,
              //                     child: Ink.image(
              //                       image: const AssetImage(
              //                           "assets/images/compo2.png"),
              //                       height: 64,
              //                       width: 64,
              //                       fit: BoxFit.cover,
              //                     ),
              //                   ),
              //                 ),
              //                 Positioned(
              //                   bottom: 12,
              //                   child: ReusableText(
              //                     text: " Loaders ",
              //                     style: appstyle(
              //                         15, Color(kLight.value), FontWeight.w600),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //       //content 2
              //       Padding(
              //         padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              //         child: Container(
              //           height: 165,
              //           width: 164,
              //           child: Card(
              //             color: Color(0xff292929),
              //             clipBehavior: Clip.antiAlias,
              //             shape: const RoundedRectangleBorder(
              //               borderRadius: BorderRadius.all(Radius.circular(24)),
              //             ),
              //             child: Stack(
              //               children: [
              //                 Padding(
              //                   padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              //                   child: Align(
              //                     alignment: Alignment.centerLeft,
              //                     heightFactor: 1.6,
              //                     child: Ink.image(
              //                       image: const AssetImage(
              //                           "assets/images/compo3.png"),
              //                       height: 64,
              //                       width: 64,
              //                       fit: BoxFit.cover,
              //                     ),
              //                   ),
              //                 ),
              //                 Positioned(
              //                   bottom: 12,
              //                   child: ReusableText(
              //                     text: " Checkboxes ",
              //                     style: appstyle(
              //                         15, Color(kLight.value), FontWeight.w600),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // // end of scroll row
              SizedBox(
                height: 20,
              ),

              Align(
                alignment: Alignment.center,
                child: ReusableText(
                  text: "No elements here yet. \nPlease try again later :( ",
                  style: appstyle(14, Color(0xffF6F0F0), FontWeight.w500),
                ),
              ),
              //see more lol
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // ReusableText(
                    //   text: "See more",
                    //   style: appstyle(14, Color(0xFFAB55F7), FontWeight.w600),
                    // ),
                    // Icon(
                    //   Icons.chevron_right_outlined,
                    //   color: Color(0xFFAB55F7),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
