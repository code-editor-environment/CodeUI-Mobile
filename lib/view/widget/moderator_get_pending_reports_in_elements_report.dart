import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
import 'moderator_get_pending_elements_report.dart';

class PendingReportedElementsListView extends StatefulWidget {
  const PendingReportedElementsListView({super.key});

  @override
  State<PendingReportedElementsListView> createState() =>
      _PendingReportedElementsListViewState();
}

class _PendingReportedElementsListViewState
    extends State<PendingReportedElementsListView> {
  late Future<ModeratorGetElementsReport> _profileFuture;
  var IdToGetReports = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var idElementToSeeReport = prefs.getString("idElementToSeeReport");
      print("Id:${idElementToSeeReport}");
      setState(() {
        IdToGetReports = idElementToSeeReport!;
        _profileFuture = _getData(IdToGetReports);
      });
    });
  }

  Future<ModeratorGetElementsReport> _getData(String id) async {
    try {
      final items = await GetElementService().moderatorGetElementsReport(id);
      return items;
    } catch (e) {
      rethrow;
    }
  }

  void refreshWidget() {
    setState(() {
      // Update any state variables here
      Get.back();
      Get.to(() => const ReportedElementsListView());
    });
  }

  GetElementService getElementService = GetElementService();
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
                      text: " Elements report id:${IdToGetReports}",
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Image.network(
                                            "${snapshot.data!.data![index].reportImages![0].imageUrl}",
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
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    ReusableText(
                                                        text:
                                                            "Report Id:${snapshot.data!.data![index].id} ",
                                                        style: appstyle(
                                                            15,
                                                            Color(0xffEC4899),
                                                            FontWeight.w600)),
                                                    ReusableText(
                                                        text:
                                                            "Status:${snapshot.data!.data![index].status} ",
                                                        style: appstyle(
                                                            15,
                                                            Color(0xffA855F7),
                                                            FontWeight.w600)),
                                                  ],
                                                ),
                                                Row(children: [
                                                  IconButton(
                                                    onPressed: () async {
                                                      var IdToAppoveReport =
                                                          snapshot.data!
                                                              .data![index].id!;
                                                      SharedPreferences prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      await prefs.setInt(
                                                          "idToActionElementsReport",
                                                          snapshot
                                                              .data!
                                                              .data![index]
                                                              .id!);
                                                      print(snapshot.data!
                                                          .data![index].id);
                                                      Get.defaultDialog(
                                                        middleTextStyle:
                                                            appstyle(
                                                                16,
                                                                Color(
                                                                    0xffA855F7),
                                                                FontWeight
                                                                    .w600),
                                                        title: "Approve?",
                                                        titleStyle: appstyle(
                                                            18,
                                                            Color(0xffEC4899),
                                                            FontWeight.w600),
                                                        middleText:
                                                            "You want to approve this report?",
                                                        backgroundColor:
                                                            Colors.white,
                                                        radius: 10.0,
                                                        actions: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              // Perform actions when the button in the dialog is pressed
                                                              //   Get.back(); // Close the dialog
                                                              getElementService
                                                                  .approveElements(
                                                                      IdToAppoveReport);
                                                              refreshWidget();
                                                            },
                                                            child: Text("OK"),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              // Perform actions when the button in the dialog is pressed
                                                              Get.back(); // Close the dialog
                                                            },
                                                            child:
                                                                Text("Cancel"),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                    icon: Icon(
                                                      MdiIcons.check,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      var IdToAppoveReport =
                                                          snapshot.data!
                                                              .data![index].id!;
                                                      SharedPreferences prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      await prefs.setInt(
                                                          "idToActionElementsReport",
                                                          snapshot
                                                              .data!
                                                              .data![index]
                                                              .id!);
                                                      TextEditingController
                                                          textEditingController1 =
                                                          TextEditingController();

                                                      Get.defaultDialog(
                                                        middleTextStyle:
                                                            appstyle(
                                                                16,
                                                                Color(
                                                                    0xffA855F7),
                                                                FontWeight
                                                                    .w600),
                                                        title: "Reject?",
                                                        titleStyle: appstyle(
                                                            18,
                                                            Color(0xffEC4899),
                                                            FontWeight.w600),
                                                        middleText:
                                                            "You want to reject this report?",
                                                        backgroundColor:
                                                            Colors.white,
                                                        content: Container(
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                  "Type your reason:"),
                                                              TextField(
                                                                controller:
                                                                    textEditingController1,
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      "Enter your comment here",
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        radius: 10.0,
                                                        actions: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              print(
                                                                  textEditingController1
                                                                      .text);
                                                              getElementService
                                                                  .rejectElements(
                                                                      IdToAppoveReport,
                                                                      "${textEditingController1.text}");
                                                              refreshWidget();
                                                              // Perform actions when the button in the dialog is pressed
                                                              //   Get.back(); // Close the dialog
                                                            },
                                                            child: Text("OK"),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              // Perform actions when the button in the dialog is pressed
                                                              Get.back(); // Close the dialog
                                                            },
                                                            child:
                                                                Text("Cancel"),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                    icon: Icon(
                                                      MdiIcons.close,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ]),
                                              ],
                                            ),
                                            Container(
                                              width: width * 0.5,
                                              child: ReusableText(
                                                  text:
                                                      "Time stamp:${formatTimestamp(snapshot.data!.data![index].timestamp!)} ",
                                                  style: appstyle(
                                                      15,
                                                      Color(0xffF6F0F0),
                                                      FontWeight.w600)),
                                            ),
                                          ],
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

String formatTimestamp(String timestampString) {
  DateTime dateTime = DateTime.parse(timestampString);
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
}
