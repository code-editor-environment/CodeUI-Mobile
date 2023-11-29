import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/components/reusable_text_for_long_text.dart';
import 'package:mobile/components/reusable_text_three_line.dart';
import 'package:mobile/view/widget/login_page.dart';
import 'package:mobile/view/widget/moderator_home_widget.dart';
import 'package:mobile/view/widget/moderator_pending_elements.dart';
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
import 'modeator_search_page.dart';
import 'moderator_get_approved_elements.dart';

class ModeratorElementsManagement extends StatefulWidget {
  const ModeratorElementsManagement({super.key});

  @override
  State<ModeratorElementsManagement> createState() =>
      _ModeratorElementsManagementState();
}

class _ModeratorElementsManagementState
    extends State<ModeratorElementsManagement> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      //  extendBodyBehindAppBar: true,
      appBar: ModeratorAppBarWidget(),
    
      body: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Get.to(() => const ModeratorHomeWidget());
                  },
                  icon: Icon(
                    MdiIcons.arrowLeft,
                    color: Color(0xffEC4899),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const ApprovedElementsListView());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .transparent, // Set the button background color to transparent
                  shadowColor:
                      Color(0xff292929), // Set the shadow color to grey
                  elevation: 2, // Set the elevation to create a shadow effect
                  padding: EdgeInsets.all(4),
                ),
                child: Card(
                  child: Container(
                    width: width,
                    height: 125,
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
                                    text: "Get Approved elements",
                                    style: appstyle(17, Color(0xff302C2E),
                                        FontWeight.w900)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 12, 12, 12),
                                child: Container(
                                  width: width * 0.65,
                                  child: ReusableTextThree(
                                      text:
                                          "See all of approved elements to do your desired actions",
                                      style: appstyle(15, Color(0xff353535),
                                          FontWeight.w400)),
                                ),
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
                Get.to(() => const ModeratorSearchWidget());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors
                    .transparent, // Set the button background color to transparent
                shadowColor: Color(0xff292929), // Set the shadow color to grey
                elevation: 2, // Set the elevation to create a shadow effect
                padding: EdgeInsets.all(4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(
                    width: width,
                    height: 145,
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
                                    text: "Search Elements",
                                    style: appstyle(18, Color(0xff302C2E),
                                        FontWeight.w900)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 12, 12, 12),
                                child: Container(
                                  width: width * 0.5,
                                  child: ReusableTextThree(
                                      text:
                                          "Search to see the element with the property you want",
                                      style: appstyle(15, Color(0xff353535),
                                          FontWeight.w400)),
                                ),
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
                Get.to(() => const PendingElementsListView());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors
                    .transparent, // Set the button background color to transparent
                shadowColor: Color(0xff292929), // Set the shadow color to grey
                elevation: 2, // Set the elevation to create a shadow effect
                padding: EdgeInsets.all(4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(
                    width: width,
                    height: 120,
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
                                    text: "Get Pending Elements",
                                    style: appstyle(18, Color(0xff302C2E),
                                        FontWeight.w900)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 12, 12, 12),
                                child: Container(
                                  width: width * 0.55,
                                  child: ReusableText(
                                      text:
                                          "Get all elements with status: Pending",
                                      style: appstyle(15, Color(0xff353535),
                                          FontWeight.w400)),
                                ),
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
    );
  }
}
