import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile/common/models/response/functionals/get_one_element_by_id_of_user.dart';
import 'package:mobile/common/models/response/functionals/like_element_response.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/components/reusable_text_long.dart';
import 'package:mobile/services/helpers/element_helper.dart';
import 'package:mobile/view/widget/save_favourite.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/models/response/functionals/create_comment_by_element_id.dart';
import '../../common/models/response/functionals/get_comment_by_element_id.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/reusable_text.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/constants/custom_textfield.dart';
import '../../common/constants/custom_textfield_with_hint_text.dart';
import '../../services/helpers/comment_helper.dart';
import 'home_page_user_logged_in.dart';

class DetailedWidget extends StatefulWidget {
  const DetailedWidget({super.key});

  @override
  State<DetailedWidget> createState() => _DetailedWidgetState();
}

class _DetailedWidgetState extends State<DetailedWidget> {
  late Future<GetOneElement> _profileFuture;
  late Future<GetCommentAndReplyByElementsId> _profileFuture1;
  Future<GetOneElement> _getData() async {
    try {
      final items = await GetElementService().getOne();
      return items;
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // void dispose() {
  //   _commentsStreamController
  //       .close(); // Don't forget to close the stream controller
  //   super.dispose();
  // }

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
      var idForElements = prefs.getInt("idForElements");
      print(_currentLoggedInUsername);
      print(accountIdToBeViewedInElements);
      print(idForElements);
    });
    _getData();
    _profileFuture = _getData();
    _profileFuture1 = _getCommentAndReply();
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
            selectedIndex: 3,
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
                      // Get.to(DetailedWidget());
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
                  icon: IconButton(
                    icon: Icon(Icons.bookmarks_outlined),
                    color: Color(0xffEC4899).withOpacity(0.4),
                    onPressed: () {
                      Get.to(BookmarkedOwnedWidget());
                    },
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
                                  onPressed: () {},
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
                                child: Image.asset(
                                  "assets/images/Mask_group.png",
                                  width: width * 0.8,
                                  height: height * 0.33,
                                ),
                              ),
                            ),
                            //content whatever
                            SizedBox(
                              height: 8,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    backgroundColor: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    "View this element's code ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(kLight.value),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                              child: ReusableText(
                                  text: "${items.data!.title} ",
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
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            print(items.data!.id!);
                                            getElementService
                                                .likeElement(items.data!.id!);
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
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            print(items.data!.id!);
                                            getElementService
                                                .saveFavoriteElement(
                                                    items.data!.id!);
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
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(24, 16, 0, 0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                        AssetImage('assets/images/avatar.jpg'),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 12, 0, 0),
                                  child: CustomTextFieldWithHintText(
                                    controller: comment,
                                    keyboardType: TextInputType.text,
                                    hintText: "Add comment....",
                                    heightBox: 80,
                                  ),
                                ),
                                IconButton(
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
                                      setState(() {});
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
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            // get all comment by listview
                            FutureBuilder(
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
                                } else {
                                  var items2 = snapshot.data;
                                  print(items2?.toJson());
                                  return ListView.builder(
                                    itemCount: items2?.metadata?.total,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                24, 16, 0, 20),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundImage: NetworkImage(
                                                    '${items2!.data![index].account!.profile!.imageUrl}'),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        12, 12, 0, 0),
                                                child: Card(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.sp),
                                                    ),
                                                    width: width * 0.65,
                                                    child: Column(children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8, 0, 0, 0),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: ReusableText(
                                                            text:
                                                                "${items2!.data![index].account!.username}",
                                                            style: appstyle(
                                                                14,
                                                                Color(
                                                                    0xffAB55F7),
                                                                FontWeight
                                                                    .w400),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                4, 0, 0, 0),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            "${items2!.data![index].commentContent}",
                                                            style: appstyle(
                                                                14,
                                                                Color(
                                                                    0xffEC4899),
                                                                FontWeight
                                                                    .w400),
                                                          ),
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        16, 0, 0, 0),
                                                child: Text(
                                                  "Reply",
                                                  style: appstyle(
                                                      14,
                                                      Color(0xffEC4899),
                                                      FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
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
