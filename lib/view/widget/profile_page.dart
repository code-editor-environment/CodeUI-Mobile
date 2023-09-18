import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/search_page.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/reusable_text.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_style.dart';
import '../../constants/custom_textfield.dart';
import 'home_page_user_logged_in.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final TextEditingController bio = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController company = TextEditingController();
  final TextEditingController location = TextEditingController();
  // int index = 0;
  final TextEditingController keyword = TextEditingController();
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
                      // Get.to(ProfileWidget());
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
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //lazy load pic in middle
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: Color(0xffA855F7),
                      child: CircleAvatar(
                        radius: 48,
                        backgroundImage: AssetImage('assets/images/avatar.jpg'),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ReusableText(
                      text: "Change image ",
                      style: appstyle(16, Color(0xffEC4899), FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: Align(
                      alignment: Alignment.center,
                      child: ReusableText(
                        text: "Full name ",
                        style: appstyle(20, Color(0xffF6F0F0), FontWeight.w600),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ReusableText(
                      text: "Username ",
                      style: appstyle(14, Color(0xffF6F0F0), FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ReusableText(
                      text: "Setting Profile ",
                      style: appstyle(20, Color(0xffF6F0F0), FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                    child: ReusableText(
                      text: "Bio ",
                      style: appstyle(16, Color(0xffF6F0F0), FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                    child: Container(
                      child: CustomTextField(
                        controller: bio,
                        keyboardType: TextInputType.emailAddress,
                        //  hintText: "Email or mobile number",
                        validator: (bio) {
                          if (bio!.isEmpty) {
                            return "Enter a valid email";
                          } else {
                            return null;
                          }
                        },
                        heightBox: 120,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  //first name lastname
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 2, 0, 0),
                            child: ReusableText(
                              text: "First name",
                              style: appstyle(
                                  16, Color(0xffF6F0F0), FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                            child: Container(
                              width: width * 0.4,
                              child: CustomTextField(
                                controller: bio,
                                keyboardType: TextInputType.emailAddress,
                                //  hintText: "Email or mobile number",
                                validator: (bio) {
                                  if (bio!.isEmpty) {
                                    return "Enter a valid email";
                                  } else {
                                    return null;
                                  }
                                },
                                heightBox: 48,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 2, 32, 0),
                            child: ReusableText(
                              text: "Last name",
                              style: appstyle(
                                  16, Color(0xffF6F0F0), FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(32, 8, 24, 0),
                            child: Container(
                              width: width * 0.4,
                              child: CustomTextField(
                                controller: bio,
                                keyboardType: TextInputType.emailAddress,
                                //  hintText: "Email or mobile number",
                                validator: (bio) {
                                  if (bio!.isEmpty) {
                                    return "Enter a valid email";
                                  } else {
                                    return null;
                                  }
                                },
                                heightBox: 48,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //first name lastname ending
                  SizedBox(
                    height: 10,
                  ),
                  // email,company,location
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                    child: ReusableText(
                      text: "E-mail ",
                      style: appstyle(16, Color(0xffF6F0F0), FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                    child: Container(
                      child: CustomTextField(
                        controller: bio,
                        keyboardType: TextInputType.emailAddress,
                        //  hintText: "Email or mobile number",
                        validator: (bio) {
                          if (bio!.isEmpty) {
                            return "Enter a valid email";
                          } else {
                            return null;
                          }
                        },
                        heightBox: 40,
                      ),
                    ),
                  ),
                  // email,company,location
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                    child: ReusableText(
                      text: "Company",
                      style: appstyle(16, Color(0xffF6F0F0), FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                    child: Container(
                      child: CustomTextField(
                        controller: bio,
                        keyboardType: TextInputType.emailAddress,
                        //  hintText: "Email or mobile number",
                        validator: (bio) {
                          if (bio!.isEmpty) {
                            return "Enter a valid email";
                          } else {
                            return null;
                          }
                        },
                        heightBox: 40,
                      ),
                    ),
                  ), // email,company,location
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                    child: ReusableText(
                      text: "Location ",
                      style: appstyle(16, Color(0xffF6F0F0), FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                    child: Container(
                      child: CustomTextField(
                        controller: bio,
                        keyboardType: TextInputType.emailAddress,
                        //  hintText: "Email or mobile number",
                        validator: (bio) {
                          if (bio!.isEmpty) {
                            return "Enter a valid email";
                          } else {
                            return null;
                          }
                        },
                        heightBox: 40,
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
