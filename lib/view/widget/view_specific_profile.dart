import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/constants/custom_textfield_bio.dart';
import 'package:mobile/services/helpers/creator_helper.dart';
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
import '../../models/response/functionals/view_profile_res_model.dart';
import 'home_page_user_logged_in.dart';

class ViewSpecificProfileWidget extends StatefulWidget {
  const ViewSpecificProfileWidget({super.key});

  @override
  State<ViewSpecificProfileWidget> createState() =>
      _ViewSpecificProfileWidgetState();
}

class _ViewSpecificProfileWidgetState extends State<ViewSpecificProfileWidget> {
  late Future<ViewSpecificProfileResponse> _profileFuture;
  Future<ViewSpecificProfileResponse> _getData() async {
    try {
      final items = await GetProfileService().getOne();
      return items;
    } catch (e) {
      throw e;
    }
  }

  @override
  void initState() {
    _profileFuture = _getData();
    super.initState();
  }

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
      body: FutureBuilder<ViewSpecificProfileResponse>(
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
              var items = snapshot.data!;
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
                                  backgroundImage:
                                      NetworkImage("${items.data?.imageUrl}"),
                                  // backgroundImage:
                                  //     AssetImage("assets/images/123.png"),
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
                                          "${items.data?.firstName} ${items.data?.lastName}",
                                      style: appstyle(20, Color(0xffF6F0F0),
                                          FontWeight.w600),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(16, 4, 0, 0),
                                    child: ReusableText(
                                      text: "@${items.data?.username}",
                                      style: appstyle(14, Color(0xffA0A0A0),
                                          FontWeight.w800),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 0, 0, 0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            GetAllCreatorService()
                                                .followCreator();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                            backgroundColor: Color(0xffEC4899),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Text(
                                            'Follow ',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(kLight.value),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            12, 0, 0, 0),
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 8),
                                            backgroundColor: Colors.grey,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Text(
                                            'Message ',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(kLight.value),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
                            text: "${items.data?.description}",
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
                                    color: Color(0xffA855F7),
                                  ),
                                  ReusableText(
                                    text: "${items.data?.location}",
                                    style: appstyle(
                                        14, Color(0xffF6F0F0), FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    MdiIcons.genderTransgender,
                                    color: Color(0xffA855F7),
                                  ),
                                  ReusableText(
                                    text: "${items.data?.gender}",
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
                                    text: "dowe",
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
