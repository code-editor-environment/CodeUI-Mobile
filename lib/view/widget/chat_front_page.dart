import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/login_page.dart';
import 'package:mobile/view/widget/profile_page.dart';
import 'package:mobile/view/widget/responsive_chat_page.dart';
import 'package:mobile/view/widget/save_favourite.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:mobile/view/widget/view_specific_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/reusable_text.dart';
import '../../components/reusable_text_long.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/models/response/functionals/profile_res_model.dart';
import '../../common/models/response/functionals/temp_creator_model.dart';
import '../../services/helpers/creator_helper.dart';
import '../../services/helpers/profile_helper.dart';
import 'home_page_user_logged_in.dart';

class ChatFrontPage extends StatefulWidget {
  const ChatFrontPage({super.key});

  @override
  State<ChatFrontPage> createState() => _ChatFrontPageState();
}

class _ChatFrontPageState extends State<ChatFrontPage> {
  String? accountIdToViewNotifications1;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("accessToken");
      var _currentLoggedInUsername =
          prefs.getString("currentLoggedInUsername")!;
      var accountIdToBeViewedInElements =
          prefs.getString("accountIdToBeViewed");
      var accountIdToViewNotifications = prefs.getString("accountId");
      print(_currentLoggedInUsername);
      print("Notification check: $accountIdToViewNotifications");
      setState(() {
        accountIdToViewNotifications1 = accountIdToViewNotifications;
      });
    });

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
          selectedIndex: 2,
          indicatorShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                  color: Color(0xffEC4899),
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
              //ver
              Container(
                height: height,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('userChats')
                      .doc("$accountIdToViewNotifications1")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return Center(child: Text('No data available'));
                      } else {
                        var document = snapshot.data;
                        if (document!.exists) {
                          var documentData = document.data();
                          if (documentData != null && documentData.isNotEmpty) {
                            List<dynamic> dataList =
                                documentData.values.toList();

                            // Sort dataList based on 'date' field
                            dataList.sort((a, b) {
                              var dateA = a['date'];
                              var dateB = b['date'];

                              // Convert timestamp to DateTime
                              DateTime dateTimeA =
                                  DateTime.fromMillisecondsSinceEpoch(
                                      dateA.seconds * 1000 +
                                          dateA.nanoseconds ~/ 1000000);
                              DateTime dateTimeB =
                                  DateTime.fromMillisecondsSinceEpoch(
                                      dateB.seconds * 1000 +
                                          dateB.nanoseconds ~/ 1000000);

                              // Compare DateTime objects to sort in descending order
                              return dateTimeB.compareTo(dateTimeA);
                            });

                            return ListView.builder(
                              itemCount: dataList.length,
                              itemBuilder: (context, index) {
                                var data = dataList[index];

                                var date = data['date'];
                                print(date);
                                // Convert timestamp to DateTime
                                DateTime dateTime =
                                    DateTime.fromMillisecondsSinceEpoch(
                                        date.seconds * 1000 +
                                            date.nanoseconds ~/ 1000000);

                                // Calculate time ago
                                String timeAgo = getTimeAgo(dateTime);

                                var userInfo = data['userInfo'];
                                print(userInfo['id']);
                                String idUserForChat = userInfo['id'];
                                return SizedBox(
                                  width: width,
                                  child: Container(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        String chatViewId =
                                            accountIdToViewNotifications1! +
                                                userInfo['id'];
                                        print("chatViewtest:$chatViewId");
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        await prefs.setString(
                                            "chatViewId", chatViewId!);
                                        await prefs.setString("senderId",
                                            accountIdToViewNotifications1!);
                                        await prefs.setString(
                                            "recieverId", userInfo['id']!);
                                        Get.to(
                                            () => const SinglePeopleChatPage());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                        padding: EdgeInsets.zero,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Your widget structure here
                                          // ...
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 0, 0, 8),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 48,
                                                  width: 48,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            48),
                                                  ),
                                                  child: Card(
                                                    color: Color(0xff292929),
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  userInfo[
                                                                      'imageUrl']),
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
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          12, 0, 0, 0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ReusableTextLong(
                                                            text:
                                                                "${userInfo['username']}",
                                                            style: appstyle(
                                                                15,
                                                                Color(kLight
                                                                    .value),
                                                                FontWeight
                                                                    .w800),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: 120,
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child:
                                                                    ReusableTextLong(
                                                                  text: data['lastmessage'] !=
                                                                          null
                                                                      ? "${data['lastmessage']['text']}"
                                                                      : '', // Show blank if null
                                                                  style: appstyle(
                                                                      15,
                                                                      Color(kLight
                                                                          .value),
                                                                      FontWeight
                                                                          .w400),
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
                                                                child:
                                                                    ReusableTextLong(
                                                                  text:
                                                                      " ${timeAgo} ",
                                                                  style: appstyle(
                                                                      15,
                                                                      Color(kLight
                                                                          .value),
                                                                      FontWeight
                                                                          .w400),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center(
                                child: Text('No chat data available'));
                          }
                        } else {
                          return Center(child: Text('Document does not exist'));
                        }
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Function to get time ago
String getTimeAgo(DateTime dateTime) {
  DateTime now = DateTime.now();
  Duration difference = now.difference(dateTime);

  if (difference.inDays > 0) {
    return '${difference.inDays} days ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} hours ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} minutes ago';
  } else {
    return '${difference.inMinutes} seconds ago';
  }
}
