import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/search_page.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/reusable_text.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_style.dart';

class CodeUIHomeScreenForLoggedInUser extends StatefulWidget {
  const CodeUIHomeScreenForLoggedInUser({super.key});

  @override
  State<CodeUIHomeScreenForLoggedInUser> createState() =>
      _CodeUIHomeScreenForLoggedInUserState();
}

class _CodeUIHomeScreenForLoggedInUserState
    extends State<CodeUIHomeScreenForLoggedInUser> {
  // int index = 0;
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
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Column(children: [
            //lazy load pic in middle
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Container(
                height: height * 0.34,
                width: (812 / 331) * width,
                child: Card(
                  color: Color.fromARGB(0, 255, 255, 255),
                  margin: const EdgeInsets.fromLTRB(4, 2, 14, 0),
                  clipBehavior: Clip.antiAlias,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                  child: Stack(
                    children: [
                      Ink.image(
                        image: const AssetImage("assets/images/landing_2.png"),
                        height: height * 0.84,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //categories
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 0, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: ReusableText(
                  text: "Top creator",
                  style: appstyle(14, Color(0xFFF6F0F0), FontWeight.w600),
                ),
              ),
            ),
            // starting categories
            // starting categories
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Container(
                      height: 165,
                      width: 164,
                      child: Card(
                        color: Color(0xff292929),
                        clipBehavior: Clip.antiAlias,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                heightFactor: 1.6,
                                child: Ink.image(
                                  image: const AssetImage(
                                      "assets/images/top1.jpg"),
                                  height: 84,
                                  width: 84,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              child: ReusableText(
                                text: "1. peanuttfpg ",
                                style: appstyle(
                                    18, Color(kLight.value), FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //content 1
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Container(
                      height: 165,
                      width: 164,
                      child: Card(
                        color: Color(0xff292929),
                        clipBehavior: Clip.antiAlias,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                heightFactor: 1.6,
                                child: Ink.image(
                                  image: const AssetImage(
                                      "assets/images/tranquoclong.jpg"),
                                  height: 64,
                                  width: 64,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              child: ReusableText(
                                text: "2. tranquoclong",
                                style: appstyle(
                                    18, Color(kLight.value), FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //content 2
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Container(
                      height: 165,
                      width: 164,
                      child: Card(
                        color: Color(0xff292929),
                        clipBehavior: Clip.antiAlias,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                heightFactor: 1.6,
                                child: Ink.image(
                                  image: const AssetImage(
                                      "assets/images/ckien.jpg"),
                                  height: 64,
                                  width: 64,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              child: ReusableText(
                                text: "3.ckien ",
                                style: appstyle(
                                    18, Color(kLight.value), FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                    style: appstyle(16, Color(0xFFAB55F7), FontWeight.w600),
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
                  text: "RECENTLY",
                  style: appstyle(14, Color(0xFFF6F0F0), FontWeight.w600),
                ),
              ),
            ),
            // starting categories
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Container(
                      height: 165,
                      width: 164,
                      child: Card(
                        color: Color(0xff292929),
                        clipBehavior: Clip.antiAlias,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                heightFactor: 1.6,
                                child: Ink.image(
                                  image: const AssetImage(
                                      "assets/images/compo1.png"),
                                  height: 64,
                                  width: 64,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              child: ReusableText(
                                text: "BUTTONS ",
                                style: appstyle(
                                    18, Color(kLight.value), FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //content 1
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Container(
                      height: 165,
                      width: 164,
                      child: Card(
                        color: Color(0xff292929),
                        clipBehavior: Clip.antiAlias,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                heightFactor: 1.6,
                                child: Ink.image(
                                  image: const AssetImage(
                                      "assets/images/compo2.png"),
                                  height: 64,
                                  width: 64,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              child: ReusableText(
                                text: "LOADERS ",
                                style: appstyle(
                                    18, Color(kLight.value), FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //content 2
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Container(
                      height: 165,
                      width: 164,
                      child: Card(
                        color: Color(0xff292929),
                        clipBehavior: Clip.antiAlias,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                heightFactor: 1.6,
                                child: Ink.image(
                                  image: const AssetImage(
                                      "assets/images/compo3.png"),
                                  height: 64,
                                  width: 64,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 12,
                              child: ReusableText(
                                text: "CHECKBOXES ",
                                style: appstyle(
                                    18, Color(kLight.value), FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // end of scroll row
            //see more lol
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ReusableText(
                    text: "See more",
                    style: appstyle(16, Color(0xFFAB55F7), FontWeight.w600),
                  ),
                  Icon(
                    Icons.chevron_right_outlined,
                    color: Color(0xFFAB55F7),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
