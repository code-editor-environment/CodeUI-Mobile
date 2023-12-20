import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/common/constants/custom_textfield_bio.dart';
import 'package:mobile/components/reusable_text_for_long_text.dart';
import 'package:mobile/services/helpers/profile_helper.dart';
import 'package:mobile/view/widget/edit_profile.dart';
import 'package:mobile/view/widget/save_favourite.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:mobile/view/widget/view_others_approved_elements.dart';
import 'package:mobile/view/widget/view_others_draft_elements.dart';
import 'package:mobile/view/widget/view_others_rejected_elements.dart';
import 'package:mobile/view/widget/view_owned_approved_elements.dart';
import 'package:mobile/view/widget/view_owned_pending_elements.dart';
import 'package:mobile/view/widget/view_owned_rejected_elements.dart';
import 'package:mobile/view/widget/view_pending_approved_elements.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/reusable_text.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/constants/custom_textfield.dart';
import '../../common/constants/custom_textfield_lock.dart';
import '../../common/models/response/functionals/profile_res_model.dart';
import 'Request_widget.dart';
import 'chat_front_page.dart';
import 'home_page_user_logged_in.dart';
import 'package:mobile/view/widget/view_owned_draft_elements.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
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
    _profileFuture = _getData();
    super.initState();
    _profileFuture.then((profileResponse) {
      if (profileResponse != null) {
        setState(() {
          // Initialize controllers with data from the ProfileResponse object
          bioController = TextEditingController(
              text: profileResponse.data!.profileResponse!.description);
          usernameController =
              TextEditingController(text: profileResponse.data?.username);
          firstNameController = TextEditingController(
              text: profileResponse.data?.profileResponse?.firstName);
          lastNameController = TextEditingController(
              text: profileResponse.data?.profileResponse?.lastName);
          phoneController = TextEditingController(
              text: profileResponse.data?.profileResponse?.phone);
          locationController = TextEditingController(
              text: profileResponse.data?.profileResponse?.location);
          genderController = TextEditingController(
              text: profileResponse.data?.profileResponse?.gender);
          dobController = TextEditingController(
              text: profileResponse.data?.profileResponse?.dateOfBirth);
          keyword1Controller = TextEditingController(
              text: profileResponse.data?.profileResponse?.imageUrl);
        });
      }
    });
  }

  late TextEditingController keyword1Controller;
  late TextEditingController usernameController;
  late TextEditingController bioController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;
  late TextEditingController locationController;
  late TextEditingController genderController;
  late TextEditingController dobController;
  int index = 0;
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
                      Get.to(() => const CodeUIHomeScreenForLoggedInUser());
                    },
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
                icon: IconButton(
                  icon: Icon(Icons.message),
                  color: Color(0xffEC4899).withOpacity(0.4),
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
            NavigationDestination(
                icon: IconButton(
                  icon: Icon(MdiIcons.codeJson),
                  color: Color(0xffEC4899).withOpacity(0.4),
                  onPressed: () {
                    Get.to(RequestWidget());
                  },
                ),
                label: ""),
          ],
        ),
      ),
      body: FutureBuilder<ViewProfileResponse>(
          future: _profileFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                color: Colors.black,
                child: Center(child: CircularProgressIndicator()),
              ); // Show a loading indicator while waiting for data.
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              ); // Handle the error.
            } else if (!snapshot.hasData) {
              return Center(
                child: Text('No data available'), // Handle no data case.
              );
            } else {
              // Build your UI using the items and controllers
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  height: height,
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //lazy load pic in middle
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.off(() =>
                                    const CodeUIHomeScreenForLoggedInUser());
                              },
                              icon: Icon(Icons.arrow_back),
                              color: Color(0xffEC4899),
                            ),
                            IconButton(
                              onPressed: () {
                                Get.to(EditProfileWidget());
                              },
                              icon: Icon(Icons.edit),
                              color: Color(0xffEC4899),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 48,
                                backgroundColor: Color(0xffA855F7),
                                child: CircleAvatar(
                                  radius: 48,
                                  backgroundImage: NetworkImage(
                                      "${keyword1Controller.text}"),
                                  // AssetImage("assets/images/123.png"),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(16, 0, 0, 0),
                                    child: ReusableText(
                                      text:
                                          "${firstNameController.text} ${lastNameController.text} ",
                                      style: appstyle(20, Color(0xffF6F0F0),
                                          FontWeight.w600),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(16, 4, 0, 0),
                                    child: ReusableText(
                                      text: "@${usernameController.text} ",
                                      style: appstyle(14, Color(0xffA0A0A0),
                                          FontWeight.w800),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(16, 4, 0, 0),
                                    child: ReusableText(
                                      text: "${phoneController.text} ",
                                      style: appstyle(14, Color(0xffF6F0F0),
                                          FontWeight.w800),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Align(
                        //   alignment: Alignment.center,
                        //   child: ReusableText(
                        //     text: "Username ",
                        //     style: appstyle(
                        //         14, Color(0xffF6F0F0), FontWeight.w400),
                        //   ),
                        // ),

                        SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: ReusableText(
                            text: "Bio:${bioController.text}",
                            style: appstyle(
                                14, Color(0xffF6F0F0), FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_city,
                                      color: Color(0xffA855F7),
                                    ),
                                    ReusableText(
                                      text: "${locationController.text}",
                                      style: appstyle(14, Color(0xffF6F0F0),
                                          FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                                child: Row(
                                  children: [
                                    Icon(
                                      MdiIcons.genderTransgender,
                                      color: Color(0xffA855F7),
                                    ),
                                    ReusableText(
                                      text: "${genderController.text}",
                                      style: appstyle(14, Color(0xffF6F0F0),
                                          FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        //end of basic profiles
                        //start of counting stuffs
                        Padding(
                          padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 110,
                                width: 110,
                                child: Card(
                                  color: Color(0xff292929),
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: ReusableText(
                                          text:
                                              "${snapshot.data!.data!.profileResponse?.totalApprovedElement}",
                                          style: appstyle(24, Color(0xffF6F0F0),
                                              FontWeight.w800),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: ReusableText(
                                          text: "Approved elements",
                                          style: appstyle(15, Color(0xffF6F0F0),
                                              FontWeight.w800),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 110,
                                width: 110,
                                child: Card(
                                  color: Color(0xff292929),
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: ReusableText(
                                          text:
                                              "${snapshot.data!.data!.profileResponse?.totalFollower}",
                                          style: appstyle(24, Color(0xffF6F0F0),
                                              FontWeight.w800),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: ReusableText(
                                          text: "Followers ",
                                          style: appstyle(15, Color(0xffF6F0F0),
                                              FontWeight.w800),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Container(
                                  height: 110,
                                  width: 110,
                                  child: Card(
                                    color: Color(0xff292929),
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: ReusableText(
                                            text:
                                                "${snapshot.data!.data!.profileResponse?.totalFollowing}",
                                            style: appstyle(
                                                24,
                                                Color(0xffF6F0F0),
                                                FontWeight.w800),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: ReusableText(
                                            text: "Followings",
                                            style: appstyle(
                                                15,
                                                Color(0xffF6F0F0),
                                                FontWeight.w800),
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
                        // start elements owned

                        SizedBox(
                          height: 20,
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: width * 0.8,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 8, 0, 0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      await prefs.setString(
                                          "accountIdToBeViewed",
                                          usernameController.text!);

                                      Get.to(() =>
                                          const ViewOwnedApprovedElements());
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      backgroundColor: Colors.grey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(MdiIcons.check),
                                        Container(
                                          width: width * 0.55,
                                          child: Text(
                                            "View your approved element ",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(kLight.value),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: width * 0.8,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 8, 0, 0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        await prefs.setString(
                                            "accountIdToBeViewed",
                                            usernameController.text!);
                                        Get.to(() =>
                                            const ViewOwnedPendingElements());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 8),
                                        backgroundColor: Colors.grey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            MdiIcons.clockTimeThreeOutline,
                                            color: Colors.amber,
                                          ),
                                          Container(
                                            width: width * 0.55,
                                            child: Text(
                                              "View your pending element ",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(kLight.value),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: width * 0.8,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 8, 0, 0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        await prefs.setString(
                                            "accountIdToBeViewed",
                                            usernameController.text!);
                                        Get.to(() =>
                                            const ViewOwnedRejectedElements());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 8),
                                        backgroundColor: Colors.grey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          ),
                                          Container(
                                            width: width * 0.55,
                                            child: Text(
                                              "View your rejected element ",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(kLight.value),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: width * 0.8,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 8, 0, 0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        await prefs.setString(
                                            "accountIdToBeViewed",
                                            usernameController.text!);
                                        Get.to(() =>
                                            const ViewOwnedDraftElements());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 8),
                                        backgroundColor: Colors.grey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            MdiIcons.folder,
                                            color: Colors.blue,
                                          ),
                                          Container(
                                            width: width * 0.55,
                                            child: Text(
                                              "View your draft element ",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Color(kLight.value),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              );
            }
          }),
    ));
  }
}
