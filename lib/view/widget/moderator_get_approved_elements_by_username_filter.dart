import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/models/response/functionals/moderator_get_approved_by_filtering.dart';
import '../../common/models/response/functionals/moderator_get_approved_elements.dart';
import '../../common/models/response/functionals/moderator_get_pending.dart';
import '../../common/models/response/functionals/save_favourite_elements_by_current_logged_in_user.dart';
import '../../components/app_bar_logged_in_user.dart';

import '../../components/app_bar_moderator_admin.dart';
import '../../components/liked_item.dart';
import '../../components/reusable_text.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/constants/custom_textfield.dart';
import '../../services/helpers/element_helper.dart';
import 'Moderator_element_details_approved_block.dart';
import 'Moderator_element_details_approved_pending.dart';
import 'elements_detail.dart';
import 'home_page_user_logged_in.dart';
import 'modeator_search_page.dart';

class ApprovedElementsListViewByFiltering extends StatefulWidget {
  const ApprovedElementsListViewByFiltering({super.key});

  @override
  State<ApprovedElementsListViewByFiltering> createState() =>
      _ApprovedElementsListViewByFilteringState();
}

class _ApprovedElementsListViewByFilteringState
    extends State<ApprovedElementsListViewByFiltering> {
  late Future<ModeratorGetApprovedByFiltering> _profileFuture;
  var username = "";

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var usernameFromPrefs = prefs.getString("usernamesElementToFilter");
      print("usernameFromPrefs:${usernameFromPrefs}");

      if (usernameFromPrefs != null) {
        setState(() {
          username = usernameFromPrefs;
          _profileFuture = _getData(username);
        });
      }
    });
  }

  Future<ModeratorGetApprovedByFiltering> _getData(String username) async {
    try {
      final items =
          await GetElementService().moderatorGetApprovedByFiltering(username);
      return items;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        //  extendBodyBehindAppBar: true,
        appBar: ModeratorAppBarWidget(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: height,
            color: Colors.black,
            child: Column(children: [
              // wrap this
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.to(() => const ModeratorSearchWidget());
                    },
                    icon: Icon(
                      MdiIcons.arrowLeft,
                      color: Color(0xffEC4899),
                    ),
                  )
                ],
              ),
              Container(
                child: FutureBuilder(
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
                        child:
                            Text('No data available'), // Handle no data case.
                      );
                    } else {
                      if (snapshot.data == []) {
                        return Center(
                          child: Text(
                              'The username is not existed'), // Handle no data case.
                        );
                      } else {
                        return Container(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      MdiIcons.searchWeb,
                                      color: Color(0xffEC4899),
                                    ),
                                    ReusableText(
                                      text:
                                          "  ${snapshot.data!.metadata!.total} results found",
                                      style: appstyle(18, Color(0xffEC4899),
                                          FontWeight.w400),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: height * 0.6,
                                  child: ListView.builder(
                                    itemCount: snapshot.data!.metadata!.total,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Column(children: [
                                            //item1
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Image.asset(
                                                    "assets/images/Mask_group.png",
                                                    width: 120,
                                                    height: 100,
                                                  ),
                                                ),
                                                // trên là cái hình elements
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ReusableText(
                                                        text:
                                                            "${snapshot.data!.data![index].profileResponse!.username} ",
                                                        style: appstyle(
                                                            15,
                                                            Color(0xffEC4899),
                                                            FontWeight.w600)),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor: Colors
                                                            .transparent, // Set the button background color to transparent
                                                        elevation:
                                                            0, // Remove the button shadow
                                                        padding: EdgeInsets
                                                            .zero, // Remove default button padding
                                                        // Reduce the button's tap target size
                                                      ),
                                                      onPressed: () async {
                                                        print(index);
                                                        var idForElements2 =
                                                            snapshot
                                                                .data!
                                                                .data![index]
                                                                .id;
                                                        print(idForElements2);
                                                        print(snapshot
                                                            .data!.data![index]
                                                            .toJson());
                                                        SharedPreferences
                                                            prefs =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        await prefs.setInt(
                                                            "idForElements",
                                                            idForElements2!);
                                                        Get.to(() =>
                                                            const ModeratorApprovedElementsDetail());
                                                      },
                                                      child: ReusableText(
                                                          text:
                                                              "${snapshot.data!.data![index].title} ",
                                                          style: appstyle(
                                                              15,
                                                              Color(0xffF6F0F0),
                                                              FontWeight.w600)),
                                                    ),
                                                    ReusableText(
                                                        text:
                                                            "${snapshot.data!.data![index].status} ",
                                                        style: appstyle(
                                                            15,
                                                            Color(0xffA855F7),
                                                            FontWeight.w600)),
                                                  ],
                                                )
                                              ],
                                            ),
                                            //item1 ending

                                            //item1 ending
                                          ]),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    }
                  },
                ),
              )
            ]),
          ),
        ));
  }
}
