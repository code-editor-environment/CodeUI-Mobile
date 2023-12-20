import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/services/helpers/element_helper.dart';
import 'package:mobile/view/widget/login_page.dart';
import 'package:mobile/view/widget/payment_widget.dart';
import 'package:mobile/view/widget/profile_page.dart';
import 'package:mobile/view/widget/responsive_chat_page.dart';
import 'package:mobile/view/widget/save_favourite.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:mobile/view/widget/view_specific_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/constants/custom_textfield.dart';
import '../../common/constants/custom_textfield_bio_change.dart';
import '../../common/models/response/functionals/create_sandbox_payment_test.dart';
import '../../common/models/response/functionals/edit_request_model.dart';
import '../../common/models/response/functionals/get_all_requests_to_show.dart';
import '../../common/models/response/functionals/get_package_to_show.dart';
import '../../common/models/response/functionals/get_request_by_id.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/reusable_disable_button_text.dart';
import '../../components/reusable_text.dart';
import '../../components/reusable_text_long.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/models/response/functionals/profile_res_model.dart';
import '../../common/models/response/functionals/temp_creator_model.dart';
import '../../services/helpers/creator_helper.dart';
import '../../services/helpers/payment_helper.dart';
import '../../services/helpers/profile_helper.dart';
import 'chat_front_page.dart';

class EditOwnedRequestWidget extends StatefulWidget {
  const EditOwnedRequestWidget({super.key});

  @override
  State<EditOwnedRequestWidget> createState() => _EditOwnedRequestWidgetState();
}

class _EditOwnedRequestWidgetState extends State<EditOwnedRequestWidget> {
  late Future<GetRequestById> _profileFuture;
  Future<GetRequestById> _getData() async {
    try {
      final items = await GetElementService().getOneRequest();
      return items;
    } catch (e) {
      throw e;
    }
  }

  @override
  void initState() {
    _profileFuture = _getData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("accessToken");
      var _currentLoggedInUsername =
          prefs.getString("currentLoggedInUsername")!;
      var accountIdToBeViewedInElements =
          prefs.getString("accountIdToBeViewed");
      var idRequestToBeSeen = prefs.getInt("idRequestToBeSeen");
    });
    _profileFuture.then((items) {
      if (items != null) {
        setState(() {
          // Initialize controllers with data from the ProfileResponse object
          requestDescription =
              TextEditingController(text: items.data!.requestDescription);
          requestName = TextEditingController(text: items.data!.name);
        });
      }
    });
    super.initState();
  }

  late TextEditingController requestName;
  late TextEditingController requestDescription;
  late var a = requestName.text;
  late var b = requestDescription.text;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
            NavigationDestination(
                icon: Icon(
                  Icons.home_outlined,
                  color: Color(0xffEC4899).withOpacity(0.4),
                ),
                label: ""),
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
                  color: Color(0xffEC4899),
                  onPressed: () {
                    //   Get.to(EditOwnedRequestWidget());
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
          width: width,
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back),
                          color: Color(0xffEC4899),
                        ),
                      ),
                      ReusableText(
                          text: "Edit your request",
                          style:
                              appstyle(16, Color(0xffEC4899), FontWeight.w600)),
                    ],
                  ),
                ],
              ),

              /// content
              FutureBuilder<GetRequestById>(
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
                        child:
                            Text('No data available'), // Handle no data case.
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
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 16, 0),
                                    child: DisableableTextButton(
                                      text: "Save",
                                      onPressed: () async {
                                        EditRequestModel model =
                                            EditRequestModel(
                                                name: requestName.text,
                                                requestDescription:
                                                    requestDescription.text);
                                        print(
                                            "Model to send 14122023 ${model.toJson()}");
                                            GetElementService().updateRequest(model);
                                            
                                      },
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 8, 0, 0),
                                  child: ReusableText(
                                    text: "Request name ",
                                    style: appstyle(
                                        16, Color(0xffF6F0F0), FontWeight.w400),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: Container(
                                        width: width * 0.92,
                                        child: CustomTextFieldBioChange(
                                          onChanged: (requestName) {},
                                          controller: requestName,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          //  hintText: "Email or mobile number",
                                          validator: (requestName) {
                                            if (requestName!.isEmpty) {
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

                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 8, 0, 0),
                                  child: ReusableText(
                                    text: "Request description",
                                    style: appstyle(
                                        16, Color(0xffF6F0F0), FontWeight.w400),
                                  ),
                                ),

                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 8, 0, 0),
                                  child: Container(
                                    width: width * 0.92,
                                    child: CustomTextFieldBioChange(
                                      onChanged: (requestDescription) {},
                                      controller: requestDescription,
                                      keyboardType: TextInputType.emailAddress,
                                      //  hintText: "Email or mobile number",
                                      validator: (requestDescription) {
                                        if (requestDescription!.isEmpty) {
                                          return "Enter a valid email";
                                        } else {
                                          return null;
                                        }
                                      },
                                      heightBox: 120,
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      );
                    }
                  }),
              //hehe
            ],
          ),
        ),
      ),
    );
  }
}
