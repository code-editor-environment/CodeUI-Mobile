import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/common/models/request/functional/send_reports_for_elements_without_images.dart';
import 'package:mobile/common/models/response/functionals/get_one_element_by_id_of_user.dart';
import 'package:mobile/common/models/response/functionals/like_element_response.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/components/reusable_text_long.dart';
import 'package:mobile/services/helpers/element_helper.dart';
import 'package:mobile/services/helpers/report_helper.dart';
import 'package:mobile/view/widget/image_utils.dart';
import 'package:mobile/view/widget/profile_page.dart';
import 'package:mobile/view/widget/save_favourite.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:mobile/view/widget/view_specific_profile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../common/models/request/functional/send_reports_for_elements.dart';
import '../../common/models/response/functionals/create_comment_by_element_id.dart';
import '../../common/models/response/functionals/get_comment_by_element_id.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/reusable_text.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/constants/custom_textfield.dart';
import '../../common/constants/custom_textfield_with_hint_text.dart';
import '../../services/helpers/comment_helper.dart';
import 'add_image_data.dart';
import 'home_page_user_logged_in.dart';

class DetailedWidget extends StatefulWidget {
  const DetailedWidget({super.key});

  @override
  State<DetailedWidget> createState() => _DetailedWidgetState();
}

class _DetailedWidgetState extends State<DetailedWidget> {
  String? selectedValue = "Choose your reason";
  bool isCodeVisible = false;
  RxBool isLiked = false.obs;
  RxBool isLikedTrue = false.obs;
  RxBool isFavorite = false.obs;
  RxBool isFavoriteTrue = false.obs;

  late String elementsNameToReport = '';
  late String _currentLoggedInUsername = "";
  late String creatorName;
  late Future<GetOneElement> _profileFuture;
  late Future<GetCommentAndReplyByElementsId> _profileFuture1;
  late int idForElements = 0;
  // @override
  // void dispose() {
  //   _commentsStreamController
  //       .close(); // Don't forget to close the stream controller
  //   super.dispose();
  // }
  Future<GetOneElement> _getData() async {
    try {
      final items = await GetElementService().getOne();
      creatorName = items.data!.profileResponse!.username!;
      elementsNameToReport = items.data!.title!;
      return items;
    } catch (e) {
      rethrow;
    }
  }

  final TextEditingController comment = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("accessToken");
      var _currentLoggedInUsername =
          prefs.getString("currentLoggedInUsername")!;
      var accountIdToBeViewedInElements =
          prefs.getString("accountIdToBeViewed");
      var idForElements1 = prefs.getInt("idForElements");
      setState(() {
        idForElements = idForElements1!;
        _profileFuture = _getData();
        _profileFuture1 = _getCommentAndReply();
      });
      prefs.setString("elementsNameToReport", elementsNameToReport);
      print(_currentLoggedInUsername);
      print(accountIdToBeViewedInElements);
      print(idForElements1);
    });

    super.initState();
  }

  GetElementService getElementService = GetElementService();
  GetCommentService getCommentService = GetCommentService();
  Future<GetCommentAndReplyByElementsId> _getCommentAndReply() async {
    try {
      final items1 = await GetCommentService().getOne();
      return items1;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    super.dispose();
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
            shadowColor: Colors.black,
            height: 50,
            backgroundColor: Color(0xff181818),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            indicatorColor: Color(0xff292929),
            indicatorShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                        // Get.to(CodeUIHomeScreenForLoggedInUser());
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
                    color: Color(0xffEC4899).withOpacity(0.4),
                    onPressed: () {
                      Get.to(BookmarkedOwnedWidget());
                    },
                  ),
                  label: ""),
            ],
          ),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                    child: Text('No data available'), // Handle no data case.
                  );
                } else {
                  var items = snapshot.data!;
                  final tempName = items.data!.title;

                  if (items.data!.isLiked == false) {
                    isLiked = true.obs;
                  }
                  if (items.data!.isLiked == true) {
                    isLikedTrue = true.obs;
                  }
                  if (items.data!.isFavorite == false) {
                    isFavorite = true.obs;
                  }
                  if (items.data!.isFavorite == true) {
                    isFavoriteTrue = true.obs;
                  }

                  return Container(
                    width: width,
                    color: Colors.black,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Color(0xffAB55F7),
                                    size: 22,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => MyDialog(
                                        elementsNameToReport: '$tempName',
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.report_problem_rounded,
                                    color: Color(0xffAB55F7),
                                    size: 22,
                                  ),
                                ),
                              ],
                            ),
                            // elements after built ,cái này về sau gắn html css qua package để  webview

                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                child: Container(
                                  height: height / 5.5,
                                  width: width * 0.7,
                                  child: ListView.builder(
                                    itemCount: 1,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var idForElements1 = items.data!.id;
                                      print(idForElements1);

                                      return Container(
                                        child: Column(
                                          children: [
                                            Row(children: [
                                              //item1
                                              Container(
                                                width: width * 0.7,
                                                height: height,
                                                child: Card(
                                                  child: ElevatedButton(
                                                    onPressed: () async {},
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
                                                    child: FutureBuilder(
                                                      future: FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'elements')
                                                          .doc(
                                                              "$idForElements1")
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

                                                          var fullHtmlCode =
                                                              '<style>body {             zoom: 3;      }$cssCode</style>$htmlCode';
                                                          var hexColor =
                                                              document[
                                                                  'background'];
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
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              //item1 ending

                                              //item1 ending
                                            ]),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            //content whatever
                            SizedBox(
                              height: 8,
                            ),
                            FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection('elements')
                                  .doc("$idForElements")
                                  .get(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error loading data'));
                                } else if (!snapshot.hasData) {
                                  return Center(
                                      child: Text('No data available'));
                                } else {
                                  var document = snapshot.data!;

                                  var htmlCode = document['html'];
                                  var cssCode = document['css'];

                                  var fullHtmlCode =
                                      '<style>body {             zoom:1.5;      }$cssCode</style>$htmlCode';
                                  var hexColor = document['background'];
                                  int backgroundColor = int.parse(
                                      hexColor.substring(1),
                                      radix: 16);

                                  return Column(
                                    children: [
                                      Container(
                                        width: width * 0.85,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              12, 0, 0, 0),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 8),
                                              backgroundColor:
                                                  Color(0xff292929),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: Text(
                                              "HTML code:\n ${htmlCode} ",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(kLight.value),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.85,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              12, 12, 0, 0),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 8),
                                              backgroundColor:
                                                  Color(0xff292929),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: Text(
                                              "CSS code:\n ${cssCode} ",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(kLight.value),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final accountIdToBeViewed =
                                    items.data?.ownerUsername;

                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString("accountIdToBeViewed",
                                    accountIdToBeViewed!);
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Color(0xff252525),
                                  builder: (context) => Container(
                                    height: 150,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 48,
                                          backgroundColor: Color(0xff292929),
                                          child: Card(
                                            color: Color(0xff292929),
                                            clipBehavior: Clip.antiAlias,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(48),
                                            ),
                                            child: Stack(
                                              children: [
                                                Ink.image(
                                                  image: NetworkImage(
                                                      "${items.data!.profileResponse?.imageUrl}"),
                                                  height: 76,
                                                  width: 76,
                                                  fit: BoxFit.cover,
                                                  onImageError:
                                                      (exception, stackTrace) {
                                                    AssetImage(
                                                        'assets/logo.png');
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              2, 0, 0, 0),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ReusableText(
                                                    text:
                                                        "${items.data?.profileResponse?.firstName} ${items.data?.profileResponse?.lastName}",
                                                    style: appstyle(
                                                        18,
                                                        Color(0xffF6F0F0),
                                                        FontWeight.w600)),
                                                Container(
                                                  width: 200,
                                                  child: ReusableText(
                                                      text:
                                                          "@${items.data?.ownerUsername} ",
                                                      style: appstyle(
                                                          14,
                                                          Color(0xffF6F0F0),
                                                          FontWeight.w400)),
                                                ),
                                                ReusableText(
                                                    text:
                                                        "Followings:${items.data!.profileResponse?.totalFollowing} ",
                                                    style: appstyle(
                                                        12,
                                                        Color(0xffF6F0F0),
                                                        FontWeight.w400)),
                                              ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 28, 0, 0),
                                          child: Column(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  if (accountIdToBeViewed ==
                                                      _currentLoggedInUsername) {
                                                    Get.to(() =>
                                                        const ProfileWidget());
                                                  } else {
                                                    Get.to(() =>
                                                        const ViewSpecificProfileWidget());
                                                  }
                                                },
                                                icon: Icon(Icons
                                                    .account_circle_outlined),
                                                color: Color(0xff8026D9),
                                                iconSize: 36,
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                    MdiIcons.messageProcessing),
                                                color: Color(0xff8026D9),
                                                iconSize: 36,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
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
                              child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(16, 16, 0, 0),
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: Color(0xffA855F7),
                                      child: CircleAvatar(
                                        radius: 16,
                                        backgroundImage: NetworkImage(
                                            "${items.data!.profileResponse!.imageUrl}"),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 16, 0, 0),
                                    child: ReusableText(
                                        text: "$creatorName",
                                        style: appstyle(15, Color(0xffF6F0F0),
                                            FontWeight.w600)),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 16, 0, 0),
                                  child: ReusableText(
                                      text: "${items.data!.title} ",
                                      style: appstyle(15, Color(0xffF6F0F0),
                                          FontWeight.w600)),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 0, 0, 0),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 8),
                                        backgroundColor: Colors.grey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        "Buy $creatorName a coffee",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(kLight.value),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: ReusableText(
                                  text:
                                      "Description: ${items.data!.description} ",
                                  style: appstyle(
                                      15, Color(0xffF6F0F0), FontWeight.w600)),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: ReusableText(
                                  text:
                                      "Category: ${items.data!.categoryName} ",
                                  style: appstyle(
                                      15, Color(0xffF6F0F0), FontWeight.w600)),
                            ),
                            //bookmarked times
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(14, 10, 0, 0),
                                    child: Icon(
                                      MdiIcons.heart,
                                      color: Color(0xffAB55F7),
                                      size: 20,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: ReusableText(
                                        text: " ${items.data?.likeCount}",
                                        style: appstyle(13, Color(0xffF6F0F0),
                                            FontWeight.w400)),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 0),
                                        child: Icon(
                                          MdiIcons.bookmark,
                                          color: Color(0xffAB55F7),
                                          size: 20,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 0),
                                        child: ReusableText(
                                            text: " ${items.data?.favorites}",
                                            style: appstyle(
                                                13,
                                                Color(0xffF6F0F0),
                                                FontWeight.w400)),
                                      ),
                                    ],
                                  ),
                                ]),

                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Obx(
                                        () => Visibility(
                                          visible: isLiked.value,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                print(items.data!.id!);
                                                getElementService.likeElement(
                                                    items.data!.id!);
                                                isLiked.value = !isLiked.value;
                                                isLikedTrue.value =
                                                    !isLikedTrue.value;
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
                                              child: Icon(
                                                MdiIcons.thumbUpOutline,
                                                color: Color(0xffAB55F7),
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Obx(
                                        () => Visibility(
                                          visible: isLikedTrue.value,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                print(items.data!.id!);
                                                getElementService.unlikeElement(
                                                    items.data!.id!);
                                                isLiked.value = !isLiked.value;

                                                isLikedTrue.value =
                                                    !isLikedTrue.value;
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
                                              child: Icon(
                                                MdiIcons.thumbUp,
                                                color: Color(0xffAB55F7),
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Obx(
                                        () => Visibility(
                                          visible: isFavorite.value,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                print(items.data!.id!);
                                                getElementService
                                                    .saveFavoriteElement(
                                                        items.data!.id!);
                                                isFavorite.value =
                                                    !isFavorite.value;
                                                isFavoriteTrue.value =
                                                    !isFavoriteTrue.value;
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
                                              child: Icon(
                                                MdiIcons.bookmarkOutline,
                                                color: Color(0xffAB55F7),
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Obx(
                                        () => Visibility(
                                          visible: isFavoriteTrue.value,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                print(items.data!.id!);
                                                getElementService
                                                    .unsaveFavoriteElement(
                                                        items.data!.id!);
                                                isFavorite.value =
                                                    !isFavorite.value;
                                                isFavoriteTrue.value =
                                                    !isFavoriteTrue.value;
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
                                              child: Icon(
                                                MdiIcons.bookmark,
                                                color: Color(0xffAB55F7),
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors
                                                .transparent, // Set the button background color to transparent
                                            elevation:
                                                0, // Remove the button shadow
                                            padding: EdgeInsets
                                                .zero, // Remove default button padding
                                            // Reduce the button's tap target size
                                          ),
                                          child: Icon(
                                            MdiIcons.share,
                                            color: Color(0xffAB55F7),
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ]),

                                //save times idk
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: ReusableText(
                                  text: " Comment ",
                                  style: appstyle(
                                      16, Color(0xffF6F0F0), FontWeight.w800)),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: width * 0.8,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(24, 12, 0, 0),
                                    child: CustomTextFieldWithHintText(
                                      controller: comment,
                                      keyboardType: TextInputType.text,
                                      hintText: "Add comment....",
                                      heightBox: 80,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: width * 0.12,
                                  child: IconButton(
                                    onPressed: () {
                                      CreateCommentByElementId model =
                                          CreateCommentByElementId(
                                              commentContent: comment.text);
                                      print(model);
                                      if (model != null) {
                                        getCommentService.createComment(model);
                                        comment.clear();
                                        print(comment);
                                        comment.text = "";
                                        print(comment);
                                        FocusScope.of(context).unfocus();
                                      } else if (comment.text == "") {
                                        return;
                                      }
                                    },
                                    icon: Icon(
                                      Icons.send,
                                      color: Color(0xffEC4899),
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            // get all comment by listview
                            Container(
                              height: height / 1.65,
                              child: FutureBuilder(
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
                                      width: width * 0.85,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            32, 0, 0, 0),
                                        child: ReusableText(
                                            text:
                                                "This elements hasnt got any comment!",
                                            style: appstyle(
                                                14,
                                                Color(0xfff0f0f0),
                                                FontWeight.w500)),
                                      ),
                                    );
                                  } else {
                                    var items2 = snapshot.data;
                                    print(items2?.toJson());
                                    return ListView.builder(
                                      itemCount: items2?.metadata?.total,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        bool isInverseRootCommentNotEmpty =
                                            items2!.data![index]
                                                .inverseRootComment!.isNotEmpty;
                                        String apiTimestamp =
                                            items2!.data![index]!.timestamp!;
                                        DateTime apiDateTime =
                                            DateTime.parse(apiTimestamp);
                                        DateTime currentTime = DateTime.now();
                                        Duration difference =
                                            currentTime.difference(apiDateTime);
                                        int minutesPassed =
                                            difference.inMinutes;
                                        bool replyComment = false;
                                        return Container(
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        24, 16, 0, 20),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: CircleAvatar(
                                                        radius: 20,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                '${items2!.data?[index].account?.profile!.imageUrl}'),
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                12, 12, 0, 0),
                                                        child: Card(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xff212121),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.sp),
                                                            ),
                                                            width: width * 0.65,
                                                            child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            8,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          ReusableText(
                                                                        text:
                                                                            "${items2!.data?[index].account?.username}",
                                                                        style: appstyle(
                                                                            14,
                                                                            Color(0xffe5e7eb),
                                                                            FontWeight.w600),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.fromLTRB(
                                                                            4,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        "${items2!.data![index].commentContent}",
                                                                        style: appstyle(
                                                                            14,
                                                                            Color(0xffC5C6CA),
                                                                            FontWeight.w500),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ]),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                16, 0, 0, 0),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "${minutesPassed} minutes ago",
                                                              style: appstyle(
                                                                  14,
                                                                  Color(
                                                                      0xffC5C6CA),
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      8,
                                                                      0,
                                                                      0,
                                                                      0),
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    replyComment =
                                                                        !replyComment;
                                                                  });
                                                                },
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent, // Set the button background color to transparent
                                                                  elevation:
                                                                      0, // Remove the button shadow
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero, // Remove default button padding
                                                                  // Reduce the button's tap target size
                                                                ),
                                                                child: Text(
                                                                  "Reply",
                                                                  style: appstyle(
                                                                      14,
                                                                      Color(
                                                                          0xffEC4899),
                                                                      FontWeight
                                                                          .w400),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: replyComment,
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width:
                                                                  width * 0.8,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        24,
                                                                        12,
                                                                        0,
                                                                        0),
                                                                child:
                                                                    CustomTextFieldWithHintText(
                                                                  controller:
                                                                      comment,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  hintText:
                                                                      "Add comment....",
                                                                  heightBox: 80,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  width * 0.12,
                                                              child: IconButton(
                                                                onPressed: () {
                                                                  CreateCommentByElementId
                                                                      model =
                                                                      CreateCommentByElementId(
                                                                          commentContent:
                                                                              comment.text);
                                                                  print(model);
                                                                  if (model !=
                                                                      null) {
                                                                    getCommentService
                                                                        .createComment(
                                                                            model);
                                                                    comment
                                                                        .clear();
                                                                    print(
                                                                        comment);
                                                                    comment.text =
                                                                        "";
                                                                    print(
                                                                        comment);
                                                                    FocusScope.of(
                                                                            context)
                                                                        .unfocus();
                                                                  } else if (comment
                                                                          .text ==
                                                                      "") {
                                                                    return;
                                                                  }
                                                                },
                                                                icon: Icon(
                                                                  Icons.send,
                                                                  color: Color(
                                                                      0xffEC4899),
                                                                  size: 20,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Visibility(
                                                          visible:
                                                              isInverseRootCommentNotEmpty,
                                                          child: Container(
                                                            height:
                                                                height * 0.13,
                                                            width: width * 0.8,
                                                            child: ListView
                                                                .builder(
                                                              itemCount: items2!
                                                                  .data![index]
                                                                  .inverseRootComment
                                                                  ?.length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index1) {
                                                                return Container(
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.fromLTRB(
                                                                                0,
                                                                                16,
                                                                                0,
                                                                                0),
                                                                            child:
                                                                                Align(
                                                                              alignment: Alignment.topLeft,
                                                                              child: CircleAvatar(
                                                                                radius: 20,
                                                                                backgroundImage: NetworkImage('${items2!.data![index].inverseRootComment![index1].account?.profile?.imageUrl}'),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
                                                                                child: Card(
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(
                                                                                      color: Color(0xff212121),
                                                                                      borderRadius: BorderRadius.circular(10.sp),
                                                                                    ),
                                                                                    width: width * 0.6,
                                                                                    child: Column(children: [
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                                                                        child: Align(
                                                                                          alignment: Alignment.topLeft,
                                                                                          child: ReusableText(
                                                                                            text: "${items2!.data![index].inverseRootComment![index1].account?.username}",
                                                                                            style: appstyle(14, Color(0xffe5e7eb), FontWeight.w700),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                                                                                        child: Align(
                                                                                          alignment: Alignment.topLeft,
                                                                                          child: Text(
                                                                                            "@${items2!.data?[index].account?.username} ${items2!.data![index].inverseRootComment![index1].commentContent}",
                                                                                            style: appstyle(14, Color(0xffC5C6CA), FontWeight.w600),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ]),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                                                                                child: Text(
                                                                                  "Reply",
                                                                                  style: appstyle(14, Color(0xffEC4899), FontWeight.w400),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
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
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            )
                            //end of all comment
                          ]),
                    ),
                  );
                }
              },
            )));
  }
}

class MyDialog extends StatefulWidget {
  final String elementsNameToReport;

  MyDialog({required this.elementsNameToReport});
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  Uint8List? _image;
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  String selectedValue = "Choose your reason";
  late String elementsNameToReport1;
  TextEditingController reason = TextEditingController();
  @override
  void initState() {
    super.initState();
    elementsNameToReport1 = widget.elementsNameToReport;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text("Report Element $elementsNameToReport1"),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                DropdownButton<String>(
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value!;
                    });
                  },
                  items: <String>[
                    "Choose your reason",
                    "Low quality's code",
                    "Code plagiarism",
                    "Misleading information",
                    "Code is harmful",
                    "Harassment code",
                    "Plaintext passwords",
                    "Performance concerns",
                    "Sensitive_comments",
                    "Non-coding content",
                    "Other",
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                TextField(
                  controller: reason,
                  decoration: InputDecoration(
                    hintText: "Enter your reason",
                    border: OutlineInputBorder(),
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: selectImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors
                            .transparent, // Set the button background color to transparent
                        shadowColor:
                            Color(0xff292929), // Set the shadow color to grey
                        elevation:
                            2, // Set the elevation to create a shadow effect
                        padding: EdgeInsets.all(4),
                      ),
                      child: _image != null
                          ? CircleAvatar(
                              radius: 32,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : CircleAvatar(
                              radius: 32,
                              backgroundImage: AssetImage(
                                  "assets/images/element_lambda_icon.png"),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: ReusableText(
                          text: "Upload Image\n(optional)",
                          style:
                              appstyle(14, Color(0xffab55f7), FontWeight.w400)),
                    )
                  ],
                ),
                ElevatedButton(
                    onPressed: () async {
                      int reasonId = 0;
                      if (selectedValue == "Low quality's code") {
                        reasonId = 1;
                      } else if (selectedValue == "Code plagiarism") {
                        reasonId = 2;
                      } else if (selectedValue == "Misleading information") {
                        reasonId = 3;
                      } else if (selectedValue == "Code is harmful") {
                        reasonId = 4;
                      } else if (selectedValue == "Harassment code") {
                        reasonId = 5;
                      } else if (selectedValue == "Plaintext passwords") {
                        reasonId = 6;
                      } else if (selectedValue == "Performance concerns") {
                        reasonId = 7;
                      } else if (selectedValue == "Sensitive_comments") {
                        reasonId = 8;
                      } else if (selectedValue == "Non-coding content") {
                        reasonId = 9;
                      } else if (selectedValue == "Other") {
                        reasonId = 10;
                      }

                      if (_image != null &&
                          reason.text != null &&
                          selectedValue != "Choose your reason") {
                        var uuid = Uuid();
                        String imageToUpload = await StoreData()
                            .uploadImageToStorage("${uuid.v4()}.png", _image!);
                        ReportImages image =
                            ReportImages(imageUrl: imageToUpload);
                        List<ReportImages> imagesList = [image];
                        SendReportForElements model = SendReportForElements(
                          reportContent: reason.text,
                          reportImages: imagesList,
                        );
                        print("vietnam + ${model.toJson()}");
                        ReportService reportService = ReportService();

                        // FocusScope.of(context).unfocus();
                        reportService.sendElementReportsWithImage(
                            model, reasonId);
                        Navigator.pop(context);
                      } else if (_image == null &&
                          reason.text != null &&
                          selectedValue != "Choose your reason") {
                        SendReportForElementsWithoutImages model =
                            SendReportForElementsWithoutImages(
                          reportContent: reason.text,
                        );
                        print("vietnamkhongcohinh + ${model.toJson()}");
                        ReportService reportService = ReportService();
                        reportService.sendElementReportsWithoutImage(
                            model, reasonId);
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Submit")),
              ],
            ),
          ),
        );
      },
    );
  }
}
