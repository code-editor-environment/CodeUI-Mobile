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
import '../../common/models/response/functionals/create_sandbox_payment_test.dart';
import '../../common/models/response/functionals/get_all_requests_to_show.dart';
import '../../common/models/response/functionals/get_package_to_show.dart';
import '../../common/models/response/functionals/get_request_by_id.dart';
import '../../components/app_bar_logged_in_user.dart';
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
import 'edit_owned_request_widget.dart';

class OwnedRequestWidgetDetails extends StatefulWidget {
  const OwnedRequestWidgetDetails({super.key});

  @override
  State<OwnedRequestWidgetDetails> createState() =>
      _OwnedRequestWidgetDetailsState();
}

class _OwnedRequestWidgetDetailsState extends State<OwnedRequestWidgetDetails> {
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("accessToken");
      var _currentLoggedInUsername =
          prefs.getString("currentLoggedInUsername")!;
      var accountIdToBeViewedInElements =
          prefs.getString("accountIdToBeViewed");
    });

    super.initState();
  }

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
          selectedIndex: 4,
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
                    //   Get.to(OwnedRequestWidgetDetails());
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
                          text: "Your request details",
                          style:
                              appstyle(16, Color(0xffEC4899), FontWeight.w600)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                    child: PopupMenuButton<String>(
                      onSelected: (value) {
                        // Handle the selected value here
                        if (value == 'settings1') {
                          Get.to(EditOwnedRequestWidget());
                          // Perform the action for the settings option
                        } else if (value == 'settings2') {
                          Get.defaultDialog(
                            middleTextStyle: appstyle(
                                16, Color(0xffA855F7), FontWeight.w600),
                            title: "Cancel?",
                            titleStyle: appstyle(
                                18, Color(0xffEC4899), FontWeight.w600),
                            middleText: "You want to cancel this request?",
                            backgroundColor: Colors.white,
                            radius: 10.0,
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  // Perform actions when the button in the dialog is pressed
                                  //   Get.back(); // Close the dialog
                                  GetElementService().deleteRequest();
                                },
                                child: Text("OK"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Perform actions when the button in the dialog is pressed
                                  Get.back(); // Close the dialog
                                },
                                child: Text("Cancel"),
                              ),
                            ],
                          );
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'settings1',
                          child: Row(
                            children: [
                              Icon(MdiIcons.pencil, color: Color(0xffEC4899)),
                              Text('Edit this request'),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'settings2',
                          child: Row(
                            children: [
                              Icon(MdiIcons.delete, color: Color(0xffEC4899)),
                              Text('Cancel this request'),
                            ],
                          ),
                        ),
                      ],
                      child: Icon(
                        Icons.settings,
                        color: Color(0xffEC4899),
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),

              /// content
              Expanded(
                flex: 1,
                child: FutureBuilder(
                  future: _getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error loading data'));
                    } else if (!snapshot.hasData) {
                      return Center(child: Text('No data available'));
                    } else {
                      var items = snapshot.data;
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                            child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 4, 0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  12), // Adjust the border radius as needed
                            ),
                            color: Color.fromARGB(105, 106, 106, 114),
                            child: SizedBox(
                              width: 540,
                              height: 250,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      leading: Image.network(
                                        "${items!.data!.avatar}",
                                        cacheHeight: 48,
                                        cacheWidth: 48,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          // Handle the error and return a placeholder image or error message widget
                                          return Icon(
                                            Icons.close,
                                            color: Colors.red,
                                            size: 48.0,
                                          );
                                        },
                                      ),
                                      title: Text(
                                        '${items.data!.name}',
                                        style: appstyle(14, Color(0xfff0f0f0),
                                            FontWeight.w600),
                                      ),
                                      subtitle: Text(
                                        '${items.data!.requestDescription}',
                                        style: appstyle(14, Color(0xfff0f0f0),
                                            FontWeight.w600),
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Status: ${items.data!.status}',
                                          style: appstyle(14, Color(0xffab55f7),
                                              FontWeight.w600),
                                        )),
                                    Text(
                                      'Category name:${items.data!.categoryName}',
                                      style: appstyle(14, Color(0xffEC4899),
                                          FontWeight.w600),
                                    ),
                                    Text(
                                      'Requester name:${items.data!.requesterName}',
                                      style: appstyle(14, Color(0xffEC4899),
                                          FontWeight.w600),
                                    ),
                                    Text(
                                      'Deadline: ${items.data!.deadline} days',
                                      style: appstyle(14, Color(0xffEC4899),
                                          FontWeight.w600),
                                    ),
                                    Text(
                                      'Deposit money: ${items.data!.deposit} ',
                                      style: appstyle(14, Color(0xffEC4899),
                                          FontWeight.w600),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          '${DateFormat('dd/MM/yyyy').format(DateTime.parse(items.data!.startDate!))}',
                                          style: appstyle(14, Color(0xffEC4899),
                                              FontWeight.w600),
                                        ),
                                        Text(
                                          'Reward:${items.data!.reward!.toStringAsFixed(0)}',
                                          style: appstyle(14, Color(0xffEC4899),
                                              FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                        )),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
