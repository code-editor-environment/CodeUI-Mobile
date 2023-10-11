import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/constants/custom_textfield_bio.dart';
import 'package:mobile/services/helpers/profile_helper.dart';
import 'package:mobile/view/widget/edit_profile.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/reusable_text.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_style.dart';
import '../../constants/custom_textfield.dart';
import '../../constants/custom_textfield_lock.dart';
import '../../models/response/functionals/profile_res_model.dart';
import 'home_page_user_logged_in.dart';

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
      body: FutureBuilder<ViewProfileResponse>(
          future: _profileFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child:
                      CircularProgressIndicator()); // Show a loading indicator while waiting for data.
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
                            text: "${bioController.text}",
                            style: appstyle(
                                14, Color(0xffF6F0F0), FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_city,
                                    color: Colors.amber,
                                  ),
                                  ReusableText(
                                    text: "${locationController.text}",
                                    style: appstyle(
                                        14, Color(0xffF6F0F0), FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    MdiIcons.genderTransgender,
                                    color: Colors.amber,
                                  ),
                                  ReusableText(
                                    text: "${genderController.text}",
                                    style: appstyle(
                                        14, Color(0xffF6F0F0), FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    MdiIcons.github,
                                    color: Colors.grey,
                                  ),
                                  ReusableText(
                                    text: "${lastNameController.text}",
                                    style: appstyle(
                                        14, Color(0xffF6F0F0), FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        //end of basic profiles
                        // start elements owned
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 20, 0, 0),
                          child: ReusableText(
                            text: "Approved elements",
                            style: appstyle(
                                16, Color(0xffF6F0F0), FontWeight.w800),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        Align(
                          alignment: Alignment.center,
                          child: ReusableText(
                            text:
                                "No approved elements. \nPlease try again later :( ",
                            style: appstyle(
                                14, Color(0xffF6F0F0), FontWeight.w500),
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
