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
import 'package:mobile/view/widget/publicly_request_widget_details.dart';
import 'package:mobile/view/widget/responsive_chat_page.dart';
import 'package:mobile/view/widget/save_favourite.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:mobile/view/widget/view_specific_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/models/response/functionals/create_sandbox_payment_test.dart';
import '../../common/models/response/functionals/get_all_requests_to_show.dart';
import '../../common/models/response/functionals/get_package_to_show.dart';
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
import 'owned_request_widget_details.dart';

class OwnedRequestWidget extends StatefulWidget {
  const OwnedRequestWidget({super.key});

  @override
  State<OwnedRequestWidget> createState() => _OwnedRequestWidgetState();
}

class _OwnedRequestWidgetState extends State<OwnedRequestWidget> {
  Future<RequestToShowToUser> _getData() async {
    try {
      final items = await GetElementService().getOwnRequest();
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
                    //   Get.to(OwnedRequestWidget());
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
                          text: "Your own request",
                          style:
                              appstyle(16, Color(0xffEC4899), FontWeight.w600)),
                    ],
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
                          height: height * 0.65,
                          child: ListView.builder(
                            itemCount: items!.metadata!.total,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 4, 0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    var idRequestToBeSeen =
                                        items.data![index].id;
                                    print("IdRequest:$idRequestToBeSeen");
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setInt("idRequestToBeSeen",
                                        idRequestToBeSeen!);
                                    Get.to(OwnedRequestWidgetDetails());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .transparent, // Set the button background color to transparent
                                    elevation: 0, // Remove the button shadow
                                    padding: EdgeInsets
                                        .zero, // Remove default button padding
                                    // Reduce the button's tap target size
                                  ),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          12), // Adjust the border radius as needed
                                    ),
                                    color: Color.fromARGB(105, 106, 106, 114),
                                    child: SizedBox(
                                      width: 340,
                                      height: 120,
                                      child: Column(children: [
                                        ListTile(
                                          leading: Image.network(
                                            "${items.data![index].avatar}",
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
                                            '${items.data![index].name}',
                                            style: appstyle(
                                                14,
                                                Color(0xfff0f0f0),
                                                FontWeight.w600),
                                          ),
                                          subtitle: Text(
                                            '${items.data![index].requestDescription}',
                                            style: appstyle(
                                                14,
                                                Color(0xfff0f0f0),
                                                FontWeight.w400),
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Status: ${items.data![index].status}',
                                              style: appstyle(
                                                  14,
                                                  Color(0xffab55f7),
                                                  FontWeight.w600),
                                            )),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '${DateFormat('dd/MM/yyyy').format(DateTime.parse(items.data![index].startDate!))}',
                                              style: appstyle(
                                                  14,
                                                  Color(0xffEC4899),
                                                  FontWeight.w600),
                                            ),
                                            Text(
                                              'Reward:${items.data![index].reward!.toStringAsFixed(0)}',
                                              style: appstyle(
                                                  14,
                                                  Color(0xffEC4899),
                                                  FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
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
