import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/components/reusable_disable_button_text.dart';
import 'package:mobile/constants/custom_textfield_bio.dart';
import 'package:mobile/models/request/functional/update_profile_model.dart';
import 'package:mobile/services/helpers/profile_helper.dart';
import 'package:mobile/view/widget/profile_page.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/reusable_text.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_style.dart';
import '../../constants/custom_textfield.dart';
import '../../constants/custom_textfield_bio_change.dart';
import '../../constants/custom_textfield_lock.dart';
import '../../models/response/functionals/profile_res_model.dart';
import 'home_page_user_logged_in.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({super.key});

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
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
          usernameController = TextEditingController(
              text: profileResponse.data?.profileResponse?.username);
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
          walletController = TextEditingController(
              text: profileResponse.data?.profileResponse!.wallet.toString());

          //  keyword1Controller = TextEditingController(text: profileResponse.data!.wallet);
        });
      }
    });
    // // Add listeners to the controllers to check for changes
    // bioController.addListener(checkChanges);
    // firstNameController.addListener(checkChanges);
    // lastNameController.addListener(checkChanges);
    // phoneController.addListener(checkChanges);
    // locationController.addListener(checkChanges);
    // genderController.addListener(checkChanges);
    // dobController.addListener(checkChanges);
  }

  // void checkChanges() {
  //   // Check if any of the controllers have non-empty text
  //   if (bioController.text.isNotEmpty ||
  //       firstNameController.text.isNotEmpty ||
  //       lastNameController.text.isNotEmpty ||
  //       phoneController.text.isNotEmpty ||
  //       locationController.text.isNotEmpty ||
  //       genderController.text.isNotEmpty ||
  //       dobController.text.isNotEmpty) {
  //     // Make the text color blue
  //     setState(() {
  //       hasChanges = true;
  //     });
  //   } else {
  //     // Make the text color the original color
  //     setState(() {
  //       hasChanges = false;
  //     });
  //   }
  // }
  late TextEditingController walletController;
  late TextEditingController usernameController;
  late TextEditingController bioController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;
  late TextEditingController locationController;
  late TextEditingController genderController;
  late TextEditingController dobController;
  late TextEditingController keyword1Controller;
  late var a = bioController.text;
  late var b = firstNameController.text;
  late var c = lastNameController.text;
  late var d = phoneController.text;
  late var e = locationController.text;
  late var f = genderController.text;
  late var g = dobController.text;
  late var h = keyword1Controller.text;
  late var l = walletController.text;
  bool hasChanges = false;
//   void checkStatus(){
//     // Get the state of the bio controller
// final bioControllerState = bioController.;

// // Check if the bio controller state is valid and there is data changed
// if (bioControllerState!.isValid && bioControllerState.text != '') {
//   // Make the text clickable
//   hasChanges = true;
// } else {
//   // Make the text unclickable
//   hasChanges = false;
// }
//   }
  @override
  Widget build(BuildContext context) {
    UpdateProfileService updateProfileService = UpdateProfileService();
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
                    // Get.to(EditProfileWidget());
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
                                Get.off(() => ProfileWidget());
                              },
                              icon: Icon(Icons.arrow_back),
                              color: Color(0xffEC4899),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
                              child: Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 48,
                                  backgroundColor: Color(0xffA855F7),
                                  child: CircleAvatar(
                                    radius: 48,
                                    backgroundImage:
                                        AssetImage('assets/images/avatar.jpg'),
                                  ),
                                ),
                              ),
                            ),
                            // IconButton(
                            //   onPressed: () {},
                            //   icon: Icon(Icons.edit),
                            //   color: Color(0xffEC4899),
                            // ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                              child: DisableableTextButton(
                                text: "Save",
                                onPressed: (bioController.text == "$a" &&
                                        firstNameController.text == "$b" &&
                                        lastNameController.text == "$c" &&
                                        phoneController.text == "$d" &&
                                        locationController.text == "$e" &&
                                        genderController.text == "$f" &&
                                        dobController.text == "$g" &&
                                        keyword1Controller.text == "$h")
                                    ? null
                                    : () {
                                        UpdateProfileModel model =
                                            UpdateProfileModel(
                                          gender: genderController.text,
                                          dateOfBirth: g,
                                          description: bioController.text,
                                          firstName: firstNameController.text,
                                          imageUrl: h,
                                          lastName: lastNameController.text,
                                          location: locationController.text,
                                          phone: phoneController.text,
                                          // wallet: l,
                                          wallet: 120,
                                        );
                                        print(model);
                                        updateProfileService
                                            .updateProfile(model);
                                        ;
                                      },
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: ReusableText(
                            text: "Change image ",
                            style: appstyle(
                                16, Color(0xffEC4899), FontWeight.w400),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ReusableText(
                            text: "Setting Profile ",
                            style: appstyle(
                                20, Color(0xffF6F0F0), FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                          child: ReusableText(
                            text: "Bio ",
                            style: appstyle(
                                16, Color(0xffF6F0F0), FontWeight.w400),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                              child: Container(
                                width: width * 0.92,
                                child: CustomTextFieldBioChange(
                                  onChanged: (bioController) {},
                                  controller: bioController,
                                  keyboardType: TextInputType.emailAddress,
                                  //  hintText: "Email or mobile number",
                                  validator: (bioController) {
                                    if (bioController!.isEmpty) {
                                      return "Enter a valid email";
                                    } else {
                                      return null;
                                    }
                                  },
                                  heightBox: 120,
                                ),
                              ),
                            ),
                            // Icon(
                            //   Icons.arrow_forward,
                            //   color: Colors.white,
                            // ),
                          ],
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
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 2, 0, 0),
                                  child: ReusableText(
                                    text: "First name",
                                    style: appstyle(
                                        16, Color(0xffF6F0F0), FontWeight.w400),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 8, 0, 0),
                                  child: Container(
                                    width: width * 0.34,
                                    child: CustomTextField(
                                      controller: firstNameController,
                                      keyboardType: TextInputType.emailAddress,
                                      //  hintText: "Email or mobile number",
                                      validator: (firstNameController) {
                                        if (firstNameController!.isEmpty) {
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
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 2, 32, 0),
                                  child: ReusableText(
                                    text: "Last name",
                                    style: appstyle(
                                        16, Color(0xffF6F0F0), FontWeight.w400),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(32, 8, 24, 0),
                                  child: Container(
                                    width: width * 0.45,
                                    child: CustomTextField(
                                      controller: lastNameController,
                                      keyboardType: TextInputType.emailAddress,
                                      //  hintText: "Email or mobile number",
                                      validator: (lastName) {
                                        if (lastName!.isEmpty) {
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
                            text: "Phone number",
                            style: appstyle(
                                16, Color(0xffF6F0F0), FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                          child: Container(
                            // child: TextField(
                            //   controller: phoneController,
                            //   style: appstyle(
                            //       16, Color(0xffF6F0F0), FontWeight.w500),
                            // ),
                            child: CustomTextField(
                              controller: phoneController,
                              keyboardType: TextInputType.number,
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
                            text: "Gender",
                            style: appstyle(
                                16, Color(0xffF6F0F0), FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                          child: Container(
                            child: CustomTextField(
                              controller: genderController,
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
                            style: appstyle(
                                16, Color(0xffF6F0F0), FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                          child: Container(
                            child: CustomTextField(
                              controller: locationController,
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                          child: ReusableText(
                            text: "Date of birth ",
                            style: appstyle(
                                16, Color(0xffF6F0F0), FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                          child: Container(
                            child: CustomTextField(
                              controller: dobController,
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
                        Center(
                          child: DisableableTextButton(
                            text: "Save",
                            onPressed: (bioController.text == "$a" &&
                                    firstNameController.text == "$b" &&
                                    lastNameController.text == "$c" &&
                                    phoneController.text == "$d" &&
                                    locationController.text == "$e" &&
                                    genderController.text == "$f" &&
                                    dobController.text == "$g" &&
                                    keyword1Controller.text == "$h")
                                ? null
                                : () {
                                    UpdateProfileModel model =
                                        UpdateProfileModel(
                                      gender: genderController.text,
                                      dateOfBirth: g,
                                      description: bioController.text,
                                      firstName: firstNameController.text,
                                      imageUrl: h,
                                      lastName: lastNameController.text,
                                      location: locationController.text,
                                      phone: phoneController.text,
                                      // wallet: l,
                                      wallet: 120,
                                    );
                                    print(model);
                                    updateProfileService.updateProfile(model);
                                    ;
                                  },
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
