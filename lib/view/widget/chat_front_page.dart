import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/login_page.dart';
import 'package:mobile/view/widget/profile_page.dart';
import 'package:mobile/view/widget/responsive_chat_page.dart';
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

class ChatFrontPage extends StatefulWidget {
  const ChatFrontPage({super.key});

  @override
  State<ChatFrontPage> createState() => _ChatFrontPageState();
}

class _ChatFrontPageState extends State<ChatFrontPage> {
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: NavigationDestination(
                  icon: Icon(
                    Icons.home_outlined,
                    color: Color(0xffEC4899).withOpacity(0.4),
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
                  color: Color(0xffEC4899),
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
      body: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: height * 0.14,
                width: width,
                child: Container(
                  child: ListView.builder(
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 0, 0, 8),
                            child: Column(
                              children: [
                                Container(
                                  height: 65,
                                  width: 64,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(48),
                                  ),
                                  child: Card(
                                    color: Color(0xff292929),
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Stack(
                                      children: [
                                        Ink.image(
                                          image: NetworkImage(
                                              "https://scontent.fsgn5-15.fna.fbcdn.net/v/t1.6435-9/149013484_190222949125848_8721369720258518493_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=7a1959&_nc_ohc=N32UJLQwOdoAX94R7wG&_nc_ht=scontent.fsgn5-15.fna&_nc_e2o=f&oh=00_AfBLjixnY7hmvy7hpaVx_4AuzB7z2MJ32NxxT6JNV1gw-w&oe=6554FBF9"),
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
                                  width: 56,
                                  child: ReusableTextLong(
                                    text: " 2323 wdwdwdwdwdwdwdw",
                                    style: appstyle(15, Color(kLight.value),
                                        FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            // xong 5 cái user currently online or watever
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: height * 0.55,
                width: width,
                child: Container(
                  child: ListView.builder(
                    itemCount: 12,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                        onPressed: () {
                          Get.to(() => const SinglePeopleChatPage());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .transparent, // Set the button background color to transparent
                          elevation: 0, // Remove the button shadow
                          padding:
                              EdgeInsets.zero, // Remove default button padding
                          // Reduce the button's tap target size
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                              child: Row(
                                children: [
                                  Container(
                                    height: 65,
                                    width: 64,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(48),
                                    ),
                                    child: Card(
                                      color: Color(0xff292929),
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      child: Stack(
                                        children: [
                                          Ink.image(
                                            image: NetworkImage(
                                                "https://scontent.fsgn5-15.fna.fbcdn.net/v/t1.6435-9/149013484_190222949125848_8721369720258518493_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=7a1959&_nc_ohc=N32UJLQwOdoAX94R7wG&_nc_ht=scontent.fsgn5-15.fna&_nc_e2o=f&oh=00_AfBLjixnY7hmvy7hpaVx_4AuzB7z2MJ32NxxT6JNV1gw-w&oe=6554FBF9"),
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
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              12, 0, 0, 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ReusableTextLong(
                                                text: "Bích Ngọc",
                                                style: appstyle(
                                                    15,
                                                    Color(kLight.value),
                                                    FontWeight.w800),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 130,
                                                    child: ReusableTextLong(
                                                      text:
                                                          "Đã bày tỏ cảm xúc với tin nhắn của bạn",
                                                      style: appstyle(
                                                          15,
                                                          Color(kLight.value),
                                                          FontWeight.w800),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(2, 0, 0, 0),
                                                    child: ReusableTextLong(
                                                      text: " . 6:53",
                                                      style: appstyle(
                                                          15,
                                                          Color(kLight.value),
                                                          FontWeight.w400),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          MdiIcons.circleSmall,
                                          color: Colors.blue,
                                          size: 32,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
      ),
    );
  }
}
