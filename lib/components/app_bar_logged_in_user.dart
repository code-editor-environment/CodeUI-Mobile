import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/view/widget/login_page.dart';
import 'package:mobile/view/widget/membership_widget.dart';
import 'package:mobile/view/widget/profile_page.dart';

import '../common/models/response/functionals/profile_res_model.dart';
import '../services/helpers/profile_helper.dart';
import '../view/widget/home_page_user_logged_in.dart';

class CustomLoggedInUserAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  const CustomLoggedInUserAppBar({super.key});
  @override
  Size get preferredSize => Size(
        double.maxFinite,
        100,
      );
  @override
  State<CustomLoggedInUserAppBar> createState() =>
      _CustomLoggedInUserAppBarState();
}

class _CustomLoggedInUserAppBarState extends State<CustomLoggedInUserAppBar> {
  String title1 = "Profile";
  String title3 = "Log out";
  String title2 = "Membership";
  String title0 = "Home";
  late Future<ViewProfileResponse> _profileFuture;
  Future<ViewProfileResponse> _getData() async {
    try {
      final items = await GetProfileService().getAll();
      return items;
    } catch (e) {
      throw e;
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize your future here, for example:
    _profileFuture = _getData(); // You need to implement this function
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
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
                          size: 24,
                        ),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          // handle menu item selection here
                          if (value == title0) {
                            //get to profile page
                            Get.to(
                                () => const CodeUIHomeScreenForLoggedInUser());
                          } else if (value == title1) {
                            //get to profile page
                            Get.to(() => const ProfileWidget());
                          } else if (value == title2) {
                            //get to membership page4
                            Get.to(() => const MembershipWidget());
                          } else if (value == title3) {
                            FirebaseAuth.instance.signOut();
                            print(FirebaseAuth.instance.currentUser);
                            Get.off(() => const LoginWidget());
                          }
                        },
                        itemBuilder: (context) => <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: title0,
                            child: Row(
                              children: [
                                Icon(Icons.home),
                                Text(title0),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: title1,
                            child: Row(
                              children: [
                                Icon(Icons.person),
                                Text(title1),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: title2,
                            child: Row(
                              children: [
                                Icon(Icons.card_membership),
                                Text(title2),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: title3,
                            child: Row(
                              children: [
                                Icon(Icons.logout),
                                Text(title3),
                              ],
                            ),
                          ),
                        ],
                        child: FutureBuilder(
                          future: _profileFuture,
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
                              return CircleAvatar(
                                radius: 18,
                                backgroundColor: Color(0xffA855F7),
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundImage: NetworkImage(
                                      "${snapshot.data!.data!.profileResponse!.imageUrl}"),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
