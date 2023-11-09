import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/login_page.dart';
import 'package:mobile/view/widget/moderator_elements_management.dart';
import 'package:mobile/view/widget/moderator_reports_management%20.dart';
import 'package:mobile/view/widget/profile_page.dart';
import 'package:mobile/view/widget/responsive_chat_page.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:mobile/view/widget/view_specific_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/app_bar_moderator_admin.dart';
import '../../components/reusable_text.dart';
import '../../components/reusable_text_long.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/models/response/functionals/profile_res_model.dart';
import '../../common/models/response/functionals/temp_creator_model.dart';
import '../../services/helpers/creator_helper.dart';
import '../../services/helpers/profile_helper.dart';
import 'moderator_categories_management.dart';
import 'moderator_packages_management.dart';

class ModeratorHomeWidget extends StatefulWidget {
  const ModeratorHomeWidget({super.key});

  @override
  State<ModeratorHomeWidget> createState() => _ModeratorHomeWidgetState();
}

class _ModeratorHomeWidgetState extends State<ModeratorHomeWidget> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      //  extendBodyBehindAppBar: true,
      appBar: ModeratorAppBarWidget(),
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
                    color: Color(0xffEC4899).withOpacity(0.4),
                  ),
                  label: ""),
            ),
            NavigationDestination(
                icon: IconButton(
                  icon: Icon(Icons.person_pin),
                  color: Color(0xffEC4899).withOpacity(0.4),
                  onPressed: () {
                    // Get.to(ProfileWidget());
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
              ElevatedButton(
                onPressed: () {
                  Get.to(() => const ModeratorElementsManagement());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .transparent, // Set the button background color to transparent
                  shadowColor:
                      Color(0xff292929), // Set the shadow color to grey
                  elevation: 2, // Set the elevation to create a shadow effect
                  padding: EdgeInsets.all(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Container(
                      width: width,
                      height: 100,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ReusableText(
                                      text: "Elements Management",
                                      style: appstyle(18, Color(0xff302C2E),
                                          FontWeight.w900)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 12, 12, 12),
                                  child: ReusableText(
                                      text: "Manager all status of elements",
                                      style: appstyle(15, Color(0xff353535),
                                          FontWeight.w400)),
                                )
                              ],
                            ),
                            //pic
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                              child: Image.asset(
                                "assets/images/landing_picture.png",
                                width: 64,
                                height: 80,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => const ModeratorReportsManagement());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .transparent, // Set the button background color to transparent
                  shadowColor:
                      Color(0xff292929), // Set the shadow color to grey
                  elevation: 2, // Set the elevation to create a shadow effect
                  padding: EdgeInsets.all(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Container(
                      width: width,
                      height: 100,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ReusableText(
                                      text: "Reports Management",
                                      style: appstyle(18, Color(0xff302C2E),
                                          FontWeight.w900)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 12, 12, 12),
                                  child: ReusableText(
                                      text: "Manager all reports",
                                      style: appstyle(15, Color(0xff353535),
                                          FontWeight.w400)),
                                )
                              ],
                            ),
                            //pic
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                              child: Image.asset(
                                "assets/images/landing_picture.png",
                                width: 64,
                                height: 80,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => const ModeratorPackagesManagement());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .transparent, // Set the button background color to transparent
                  shadowColor:
                      Color(0xff292929), // Set the shadow color to grey
                  elevation: 2, // Set the elevation to create a shadow effect
                  padding: EdgeInsets.all(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Container(
                      width: width,
                      height: 100,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ReusableText(
                                      text: "Packages Management",
                                      style: appstyle(18, Color(0xff302C2E),
                                          FontWeight.w900)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 12, 12, 12),
                                  child: ReusableText(
                                      text: "Manager all packages",
                                      style: appstyle(15, Color(0xff353535),
                                          FontWeight.w400)),
                                )
                              ],
                            ),
                            //pic
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                              child: Image.asset(
                                "assets/images/landing_picture.png",
                                width: 64,
                                height: 80,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => const ModeratorCategoriesManagement());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .transparent, // Set the button background color to transparent
                  shadowColor:
                      Color(0xff292929), // Set the shadow color to grey
                  elevation: 2, // Set the elevation to create a shadow effect
                  padding: EdgeInsets.all(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Container(
                      width: width,
                      height: 100,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ReusableText(
                                      text: "Categories Management",
                                      style: appstyle(18, Color(0xff302C2E),
                                          FontWeight.w900)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 12, 12, 12),
                                  child: ReusableText(
                                      text: "Manager all categories",
                                      style: appstyle(15, Color(0xff353535),
                                          FontWeight.w400)),
                                )
                              ],
                            ),
                            //pic
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                              child: Image.asset(
                                "assets/images/landing_picture.png",
                                width: 64,
                                height: 80,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
