import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/services/helpers/creator_helper.dart';
import 'package:mobile/services/helpers/profile_helper.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/models/response/functionals/get_elements_by_user_name_model.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/reusable_text.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/models/response/functionals/view_profile_res_model.dart';
import '../../services/helpers/element_helper.dart';
import 'elements_detail.dart';
import 'home_page_user_logged_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewSpecificProfileWidget extends StatefulWidget {
  const ViewSpecificProfileWidget({super.key});

  @override
  State<ViewSpecificProfileWidget> createState() =>
      _ViewSpecificProfileWidgetState();
}

class _ViewSpecificProfileWidgetState extends State<ViewSpecificProfileWidget> {
  late Future<ViewSpecificProfileResponse> _profileFuture;
  late Future<GetElementsFromASpecificUser> _profileFuture1;
  Future<ViewSpecificProfileResponse> _getData() async {
    try {
      final items = await GetProfileService().getOne();
      return items;
    } catch (e) {
      rethrow;
    }
  }

  Future<GetElementsFromASpecificUser> _getElementData() async {
    try {
      final items1 = await getElementService.getAll();
      return items1;
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
    _profileFuture1 = _getElementData();
    super.initState();
  }

  final db = FirebaseFirestore.instance;

  GetElementService getElementService = GetElementService();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: Color(0xffEC4899).withOpacity(0.4),
                ),
                label: ""),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            FutureBuilder<ViewSpecificProfileResponse>(
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
                    // Build your UI using the items and controllers
                    var items = snapshot.data!;
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //lazy load pic in middle
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.off(() =>
                                        const CodeUIHomeScreenForLoggedInUser());
                                  },
                                  icon: Icon(Icons.arrow_back),
                                  color: Color(0xffEC4899),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 48,
                                    backgroundColor: Color(0xffA855F7),
                                    child: CircleAvatar(
                                      radius: 48,
                                      backgroundImage: NetworkImage(
                                          "${items.data?.imageUrl}"),
                                      // backgroundImage:
                                      //     AssetImage("assets/images/123.png"),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 0, 0, 0),
                                        child: ReusableText(
                                          text:
                                              "${items.data?.firstName} ${items.data?.lastName}",
                                          style: appstyle(20, Color(0xffF6F0F0),
                                              FontWeight.w600),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 4, 0, 0),
                                        child: ReusableText(
                                          text: "@${items.data?.username}",
                                          style: appstyle(14, Color(0xffA0A0A0),
                                              FontWeight.w800),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                16, 0, 0, 0),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                GetAllCreatorService()
                                                    .followCreator();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 8),
                                                backgroundColor:
                                                    Color(0xffEC4899),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              child: Text(
                                                'Follow ',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(kLight.value),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                12, 0, 0, 0),
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 8),
                                                backgroundColor: Colors.grey,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              child: Text(
                                                'Message ',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(kLight.value),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Align(
                            //   alignment: Alignment.center,
                            //   child: ReusableText(
                            //     text: "Username ",
                            //     style: appstyle(
                            //         14, Color(0xffF6F0F0), FontWeight.w400),
                            //   ),
                            // ),

                            SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: ReusableText(
                                text: "${items.data?.description}",
                                style: appstyle(
                                    14, Color(0xffF6F0F0), FontWeight.w600),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_city,
                                        color: Color(0xffA855F7),
                                      ),
                                      ReusableText(
                                        text: "${items.data?.location}",
                                        style: appstyle(14, Color(0xffF6F0F0),
                                            FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        MdiIcons.genderTransgender,
                                        color: Color(0xffA855F7),
                                      ),
                                      ReusableText(
                                        text: "${items.data?.gender}",
                                        style: appstyle(14, Color(0xffF6F0F0),
                                            FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        MdiIcons.github,
                                        color: Colors.grey,
                                      ),
                                      ReusableText(
                                        text: "dowe",
                                        style: appstyle(14, Color(0xffF6F0F0),
                                            FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            //end of basic profiles
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 120,
                                    width: 120,
                                    child: Card(
                                      color: Color(0xff292929),
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: ReusableText(
                                              text:
                                                  "${items.data?.totalApprovedElement}",
                                              style: appstyle(
                                                  24,
                                                  Color(0xffF6F0F0),
                                                  FontWeight.w800),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: ReusableText(
                                              text: "Approved elements",
                                              style: appstyle(
                                                  16,
                                                  Color(0xffF6F0F0),
                                                  FontWeight.w800),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 120,
                                    width: 120,
                                    child: Card(
                                      color: Color(0xff292929),
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: ReusableText(
                                              text:
                                                  "${items.data?.totalFollower}",
                                              style: appstyle(
                                                  24,
                                                  Color(0xffF6F0F0),
                                                  FontWeight.w800),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: ReusableText(
                                              text: "Followers ",
                                              style: appstyle(
                                                  16,
                                                  Color(0xffF6F0F0),
                                                  FontWeight.w800),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 120,
                                    width: 120,
                                    child: Card(
                                      color: Color(0xff292929),
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: ReusableText(
                                              text:
                                                  "${items.data?.totalFollowing}",
                                              style: appstyle(
                                                  24,
                                                  Color(0xffF6F0F0),
                                                  FontWeight.w800),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: ReusableText(
                                              text: "Followings",
                                              style: appstyle(
                                                  16,
                                                  Color(0xffF6F0F0),
                                                  FontWeight.w800),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // start elements owned but will move it to another futurebuilder for viewing
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      index = 0;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .transparent, // Set the button background color to transparent
                                    shadowColor: Color(
                                        0xff292929), // Set the shadow color to grey
                                    elevation:
                                        2, // Set the elevation to create a shadow effect
                                    padding: EdgeInsets.all(4),
                                  ),
                                  child: Icon(MdiIcons.check),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      index = 1;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .transparent, // Set the button background color to transparent
                                    shadowColor: Color(
                                        0xff292929), // Set the shadow color to grey
                                    elevation:
                                        2, // Set the elevation to create a shadow effect
                                    padding: EdgeInsets.all(4),
                                  ),
                                  child: Icon(
                                    MdiIcons.clockTimeThreeOutline,
                                    color: Colors.amber,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      index = 2;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .transparent, // Set the button background color to transparent
                                    shadowColor: Color(
                                        0xff292929), // Set the shadow color to grey
                                    elevation:
                                        2, // Set the elevation to create a shadow effect
                                    padding: EdgeInsets.all(4),
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      index = 3;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .transparent, // Set the button background color to transparent
                                    shadowColor: Color(
                                        0xff292929), // Set the shadow color to grey
                                    elevation:
                                        2, // Set the elevation to create a shadow effect
                                    padding: EdgeInsets.all(4),
                                  ),
                                  child: Icon(
                                    MdiIcons.folder,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ), //indexedstack in here
                            IndexedStack(
                              children: [
                                FutureBuilder<GetElementsFromASpecificUser>(
                                  future: _profileFuture1,
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
                                    } else if (snapshot.data!.data!.isEmpty) {
                                      return Container(
                                        height: 200,
                                        child: Center(
                                            child: ReusableText(
                                                text:
                                                    "Nothing here to be shown",
                                                style: appstyle(
                                                    14,
                                                    Colors.amber,
                                                    FontWeight.w400))
                                            // Handle no data case.
                                            ),
                                      );
                                    } else {
                                      int? indexForElements =
                                          snapshot.data!.metadata!.total;

                                      String? ownerofElements =
                                          snapshot.data!.data![0].ownerUsername;
                                      print(indexForElements);
                                      print(ownerofElements);
                                      // Build your UI using the items and controller

                                      return Container(
                                        height: height / 1.5,
                                        width: 340,
                                        child: ListView.builder(
                                          itemCount:
                                              snapshot.data!.metadata?.total,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              child: Row(children: [
                                                //item1
                                                Container(
                                                  width: 160,
                                                  height: 80,
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      print(index);
                                                      var idForElements =
                                                          snapshot.data!
                                                              .data![index].id;
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
                                                        () =>
                                                            const DetailedWidget(),
                                                      );
                                                    },
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
                                                    child: Card(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 15, 20, 0),
                                                        child: StreamBuilder<
                                                            QuerySnapshot>(
                                                          stream:
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'elements')
                                                                  .snapshots(),
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
                                                                    .hasData ||
                                                                snapshot
                                                                    .data!
                                                                    .docs
                                                                    .isEmpty) {
                                                              return Center(
                                                                  child: Text(
                                                                      'No data available'));
                                                            } else {
                                                              var document =
                                                                  snapshot.data!
                                                                          .docs[
                                                                      index];

                                                              print(snapshot
                                                                  .data!
                                                                  .docs[index]);
                                                              var htmlCode =
                                                                  document[
                                                                      'html'];
                                                              var cssCode =
                                                                  document[
                                                                      'css'];
                                                              var fullHtmlCode =
                                                                  '<style>$cssCode</style>$htmlCode';
                                                              var hexColor =
                                                                  document[
                                                                      'background'];
                                                              int backgroundColor =
                                                                  int.parse(
                                                                      hexColor
                                                                          .substring(
                                                                              1),
                                                                      radix:
                                                                          16);
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
                                                ),
                                                //item1 ending

                                                //item1 ending
                                              ]),
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  },
                                ),
                                Center(
                                  child: Image.asset("assets/flags/ki.png"),
                                ),
                                Center(
                                  child: Image.asset("assets/flags/vn.png"),
                                ),
                                Center(
                                  child: Image.asset("assets/flags/zw.png"),
                                ),
                              ],
                              index: index,
                            ),
                          ]),
                    );
                  }
                }),
          ],
        ),
      ),
    ));
  }
}
