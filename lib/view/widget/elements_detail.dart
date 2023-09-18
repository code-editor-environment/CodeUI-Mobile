import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/bookmarks_owned.dart';
import 'package:mobile/view/widget/search_page.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/reusable_text.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_style.dart';
import '../../constants/custom_textfield.dart';
import '../../constants/custom_textfield_with_hint_text.dart';
import 'home_page_user_logged_in.dart';

class DetailedWidget extends StatefulWidget {
  const DetailedWidget({super.key});

  @override
  State<DetailedWidget> createState() => _DetailedWidgetState();
}

class _DetailedWidgetState extends State<DetailedWidget> {
  final TextEditingController comment = TextEditingController();
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
          child: Container(
            width: width,
            height: height,
            color: Colors.black,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              // elements after built ,cái này về sau gắn html css qua package để chơi webview
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
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                child: ReusableText(
                    text: "Button Learn more' ",
                    style: appstyle(15, Color(0xffF6F0F0), FontWeight.w600)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                child: ReusableText(
                  text: "đ100.000đ ",
                  style: appstyle(
                      18, Color(0xffAb55f7).withOpacity(1.0), FontWeight.w600),
                ),
              ),
              //bookmarked times
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                      child: Icon(
                        MdiIcons.heartOutline,
                        color: Color(0xffF6F0F0),
                        size: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                      child: ReusableText(
                          text: " 2099 ",
                          style:
                              appstyle(13, Color(0xffF6F0F0), FontWeight.w400)),
                    ),
                    Icon(
                      MdiIcons.bookmarkOutline,
                      color: Color(0xffF6F0F0),
                      size: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: ReusableText(
                          text: " 2099 ",
                          style:
                              appstyle(13, Color(0xffF6F0F0), FontWeight.w400)),
                    ),
                  ]),

                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                          child: Icon(
                            MdiIcons.heartOutline,
                            color: Color(0xffAB55F7),
                            size: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                          child: Icon(
                            MdiIcons.share,
                            color: Color(0xffAB55F7),
                            size: 20,
                          ),
                        ),
                      ]),

                  //save times idk
                ],
              ),
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
                child: ReusableText(
                    text: " Comment ",
                    style: appstyle(16, Color(0xffF6F0F0), FontWeight.w800)),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 0, 0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
                    child: CustomTextFieldWithHintText(
                      controller: comment,
                      keyboardType: TextInputType.text,
                      hintText: "Add comment....",
                      validator: (email) {
                        if (email!.isEmpty || !email.contains("@")) {
                          return "Ẹnter a valid email";
                        } else {
                          return null;
                        }
                      },
                      heightBox: 80,
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ));
  }
}
