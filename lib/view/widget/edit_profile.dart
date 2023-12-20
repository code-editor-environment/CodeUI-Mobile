import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/components/intl_phone_picker_refactored/intl_phone_field.dart';
import 'package:mobile/components/reusable_disable_button_text.dart';
import 'package:mobile/common/constants/custom_textfield_bio.dart';
import 'package:mobile/common/models/request/functional/update_profile_model.dart';
import 'package:mobile/services/helpers/profile_helper.dart';
import 'package:mobile/view/widget/add_image_data.dart';
import 'package:mobile/view/widget/image_utils.dart';
import 'package:mobile/view/widget/profile_page.dart';
import 'package:mobile/view/widget/save_favourite.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/reusable_text.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/constants/custom_textfield.dart';
import '../../common/constants/custom_textfield_bio_change.dart';
import '../../common/constants/custom_textfield_lock.dart';
import '../../common/models/response/functionals/profile_res_model.dart';
import 'home_page_user_logged_in.dart';
import 'package:uuid/uuid.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({super.key});

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  Uint8List? _image;
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        _image = img;
      });
    }
  }

  late Future<ViewProfileResponse> _profileFuture;

  List<String> genderItems = ['other','Non-binary', 'Male', 'Female'];
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
          if (profileResponse.data!.profileResponse!.dateOfBirth! != null) {
            DateTime dateTime = DateTime.parse(
                profileResponse.data!.profileResponse!.dateOfBirth!);

            dobController = TextEditingController(
                text: DateFormat('yyyy/MM/dd').format(dateTime));
          } else {
            dobController = TextEditingController(
                text: profileResponse.data?.profileResponse!.dateOfBirth!);
          }
          keyword1Controller = TextEditingController(
              text: profileResponse.data?.profileResponse?.imageUrl);
          walletController = TextEditingController(
              text: profileResponse.data?.profileResponse!.wallet.toString());
        });
      }
    });
  }

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
  late var userNameToPass = usernameController.text;
  late var selectedValue = genderController.text;
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
                icon: IconButton(
                  icon: Icon(Icons.bookmarks_outlined),
                  color: Color(0xffEC4899).withOpacity(0.4),
                  onPressed: () {
                    Get.to(BookmarkedOwnedWidget());
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
                            ElevatedButton(
                              onPressed: selectImage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors
                                    .transparent, // Set the button background color to transparent
                                elevation: 0, // Remove the button shadow
                                padding: EdgeInsets
                                    .zero, // Remove default button padding
                                // Reduce the button's tap target size
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
                                child: Align(
                                  alignment: Alignment.center,
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
                                          child:
                                              Text('Error: ${snapshot.error}'),
                                        ); // Handle the error.
                                      } else if (!snapshot.hasData) {
                                        return Center(
                                          child: Text(
                                              'No data available'), // Handle no data case.
                                        );
                                      } else {
                                        return _image != null
                                            ? CircleAvatar(
                                                radius: 48,
                                                backgroundImage:
                                                    MemoryImage(_image!),
                                              )
                                            : CircleAvatar(
                                                radius: 48,
                                                backgroundColor:
                                                    Color(0xffA855F7),
                                                child: CircleAvatar(
                                                  radius: 48,
                                                  backgroundImage: NetworkImage(
                                                      "${snapshot.data!.data!.profileResponse!.imageUrl}"),
                                                ),
                                              );
                                      }
                                    },
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
                                    : () async {
                                        if (_image != null) {
                                          var uuid = Uuid();
                                          String imageToUpload =
                                              await StoreData()
                                                  .uploadImageToStorage(
                                                      "${uuid.v4()}.png",
                                                      _image!);
                                          UpdateProfileModel model =
                                              UpdateProfileModel(
                                            gender: genderController.text,
                                            dateOfBirth: dobController.text,
                                            description: bioController.text,
                                            firstName: firstNameController.text,
                                            imageUrl: imageToUpload,
                                            lastName: lastNameController.text,
                                            location: locationController.text,
                                            phone: phoneController.text,
                                            // username: usernameController.text,
                                            // wallet: l,
                                            wallet: 120,
                                          );
                                          print(model.toJson());
                                          updateProfileService
                                              .updateProfile(model);
                                        } else if (_image == null) {
                                          var uuid = Uuid();
                                          // String imageToUpload = await StoreData()
                                          //     .uploadImageToStorage(
                                          //         "${uuid.v4()}.png", _image!);
                                          UpdateProfileModel model =
                                              UpdateProfileModel(
                                            gender: genderController.text,
                                            dateOfBirth: dobController.text,
                                            description: bioController.text,
                                            firstName: firstNameController.text,
                                            imageUrl: keyword1Controller.text,
                                            lastName: lastNameController.text,
                                            location: locationController.text,
                                            phone: phoneController.text,
                                            // username: usernameController.text,
                                            // wallet: l,
                                            wallet: 120,
                                          );
                                          print(model.toJson());
                                          updateProfileService
                                              .updateProfile(model);
                                        }
                                      },
                              ),
                            ),
                          ],
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
                            // child: CustomTextField(
                            //   controller: phoneController,
                            //   keyboardType: TextInputType.number,
                            //   //  hintText: "Email or mobile number",
                            //   validator: (bio) {
                            //     if (bio!.isEmpty) {
                            //       return "Enter a valid email";
                            //     } else {
                            //       return null;
                            //     }
                            //   },
                            //   heightBox: 40,
                            // ),
                            child: Container(
                              width: width * 0.9,
                              child: IntlPhoneField(
                                dropdownTextStyle: appstyle(
                                    14, Color(0xffF6F0F0), FontWeight.w400),
                                style: appstyle(
                                    14, Color(0xffF6F0F0), FontWeight.w400),
                                decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  filled: true,
                                  fillColor: Color(0xff292929),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                languageCode: "en",
                                onChanged: (phone) {
                                  print(phone.completeNumber);
                                  phoneController.text = phone.completeNumber;
                                  print(phoneController.text);
                                },
                                onCountryChanged: (country) {
                                  print('Country changed to: ' + country.name);
                                },
                              ),
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
                            width: width * 0.9,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(14),
                              color: Color(0xff292929),
                            ),
                            // child: CustomTextField(
                            //   controller: genderController,
                            //   keyboardType: TextInputType.emailAddress,
                            //   //  hintText: "Email or mobile number",
                            //   validator: (bio) {
                            //     if (bio!.isEmpty) {
                            //       return "Enter a valid email";
                            //     } else {
                            //       return null;
                            //     }
                            //   },
                            //   heightBox: 40,
                            // ),
                            child: DropdownButton(
                              hint: ReusableText(
                                text: "Select your gender",
                                style: appstyle(
                                    14, Color(0xffA855F7), FontWeight.w400),
                              ),
                              style: appstyle(
                                  14, Color(0xffA855F7), FontWeight.w400),
                              value: selectedValue,
                              isExpanded: true,
                              items: genderItems.map((String value) {
                                return DropdownMenuItem<String>(
                                    value: value, child: Text(value));
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedValue = newValue!;
                                  f = selectedValue!;
                                  print(selectedValue);
                                  print(f);
                                });
                              },
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
                                : () async {
                                    if (_image != null) {
                                      var uuid = Uuid();
                                      String imageToUpload = await StoreData()
                                          .uploadImageToStorage(
                                              "${uuid.v4()}.png", _image!);
                                      UpdateProfileModel model =
                                          UpdateProfileModel(
                                        gender: genderController.text,
                                        dateOfBirth: dobController.text,
                                        description: bioController.text,
                                        firstName: firstNameController.text,
                                        imageUrl: imageToUpload,
                                        lastName: lastNameController.text,
                                        location: locationController.text,
                                        phone: phoneController.text,
                                        // username: usernameController.text,
                                        // wallet: l,
                                        wallet: 120,
                                      );
                                      print(model.toJson());
                                      updateProfileService.updateProfile(model);
                                    } else if (_image == null) {
                                      var uuid = Uuid();
                                      // String imageToUpload = await StoreData()
                                      //     .uploadImageToStorage(
                                      //         "${uuid.v4()}.png", _image!);
                                      UpdateProfileModel model =
                                          UpdateProfileModel(
                                        gender: genderController.text,
                                        dateOfBirth: dobController.text,
                                        description: bioController.text,
                                        firstName: firstNameController.text,
                                        imageUrl: keyword1Controller.text,
                                        lastName: lastNameController.text,
                                        location: locationController.text,
                                        phone: phoneController.text,
                                        // username: usernameController.text,
                                        // wallet: l,
                                        wallet: 120,
                                      );
                                      print(model.toJson());
                                      updateProfileService.updateProfile(model);
                                    }
                                  },
                          ),
                        ),
                      ]),
                ),
              );
            }
          }),
          //hehe
    ));
  }
}
