import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/models/response/functionals/moderator_get_approved_elements.dart';
import '../../common/models/response/functionals/moderator_get_elements_report.dart';
import '../../common/models/response/functionals/moderator_get_pending.dart';
import '../../common/models/response/functionals/moderator_get_pending_reports.dart';
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
import 'moderator_get_pending_reports_in_elements_report.dart';

class ReportedElementsListView extends StatefulWidget {
  const ReportedElementsListView({super.key});

  @override
  State<ReportedElementsListView> createState() =>
      _ReportedElementsListViewState();
}

class _ReportedElementsListViewState extends State<ReportedElementsListView> {
  late Future<ModeratorGetPendingElementReports> _profileFuture;
  Future<ModeratorGetPendingElementReports> _getData() async {
    try {
      final items =
          await GetElementService().moderatorGetPendingElementsReport();
      return items;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("accessToken");
      var _currentLoggedInUsername =
          prefs.getString("currentLoggedInUsername")!;
      var accountIdToBeViewedInElements =
          prefs.getString("accountIdToBeViewed");

      print(_currentLoggedInUsername);
      print(accountIdToBeViewedInElements);
    });
    _profileFuture = _getData();

    super.initState();
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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      MdiIcons.blockHelper,
                      color: Color(0xffEC4899),
                    ),
                    ReusableText(
                      text: " Elements report",
                      style: appstyle(18, Color(0xffEC4899), FontWeight.w400),
                    ),
                  ],
                ),
              ),
              // wrap this
              Container(
                height: MediaQuery.of(context).size.height * 0.65,
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
                      return ListView.builder(
                        itemCount: snapshot.data!.metadata!.total,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //item1
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Image.asset(
                                            "assets/images/Mask_group.png",
                                            width: 96,
                                            height: 84,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              // Handle the error and return a placeholder image or error message widget
                                              return Icon(
                                                Icons.error,
                                                color: Colors.red,
                                                size: 48.0,
                                              );
                                            },
                                          ),
                                        ),
                                        // trên là cái hình elements
                                        ElevatedButton(
                                          onPressed: () async {
                                            var idElementToSeeReport = snapshot
                                                .data!.data![index].elementId.toString();
                                            print(idElementToSeeReport);
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            await prefs.setString(
                                                "idElementToSeeReport",
                                                idElementToSeeReport!);
                                            Get.to(() =>
                                                const PendingReportedElementsListView());
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors
                                                .transparent, // Set the button background color to transparent
                                            elevation:
                                                0, // Remove the button shadow
                                            padding: EdgeInsets
                                                .zero, // Remove default button padding
                                            // Reduce the button's tap target size
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ReusableText(
                                                  text:
                                                      "Element Id:${snapshot.data!.data![index].elementId} ",
                                                  style: appstyle(
                                                      15,
                                                      Color(0xffEC4899),
                                                      FontWeight.w600)),
                                              Container(
                                                width: width * 0.6,
                                                child: ReusableText(
                                                    text:
                                                        "Owner:${snapshot.data!.data![index].userName} ",
                                                    style: appstyle(
                                                        15,
                                                        Color(0xffF6F0F0),
                                                        FontWeight.w600)),
                                              ),
                                              ReusableText(
                                                  text:
                                                      "Total reports:${snapshot.data!.data![index].totalReport} ",
                                                  style: appstyle(
                                                      15,
                                                      Color(0xffA855F7),
                                                      FontWeight.w600)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    //item1 ending

                                    //item1 ending
                                  ]),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ]),
          ),
        ));
  }
}
