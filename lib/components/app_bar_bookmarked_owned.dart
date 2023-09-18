import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/components/reusable_text.dart';
import 'package:mobile/view/widget/login_page.dart';
import 'package:mobile/view/widget/profile_page.dart';

import '../constants/app_style.dart';

class CustomLoggedInUserAppBarBookmarkOwned extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomLoggedInUserAppBarBookmarkOwned({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        children: [
          Container(
            color: Colors.black,
            child: Column(
              children: [
                Row(
                  // row chưa nguyên cái app bar
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Image.asset(
                        "assets/images/logo.png",
                        width: 133,
                        height: 96,
                      ),
                    ),
                    //row chứa 2 cái icon button
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                            child: Icon(
                              Icons.notifications_none_outlined,
                              color: Color(0xffA855F7),
                              size: 30,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .transparent, // Set the button background color to transparent
                              elevation: 0, // Remove the button shadow
                              padding: EdgeInsets
                                  .zero, // Remove default button padding
                              // Reduce the button's tap target size
                            ),
                            onPressed: () {
                              Get.to(ProfileWidget());
                            },
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor: Color(0xffA855F7),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    AssetImage('assets/images/avatar.jpg'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TabBar(
                  tabs: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Tab(
                          icon: Icon(Icons.heart_broken),
                          height: 26,
                        ),
                        ReusableText(
                          text: "Liked",
                          style:
                              appstyle(12, Color(0xffD0DAB6), FontWeight.w800),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Tab(
                          icon: Icon(Icons.bookmark),
                          height: 26,
                        ),
                        ReusableText(
                          text: "Owned",
                          style:
                              appstyle(12, Color(0xffD0DAB6), FontWeight.w800),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(
        5600,
        124,
      );
}
