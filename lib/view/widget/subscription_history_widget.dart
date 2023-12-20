import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/login_page.dart';
import 'package:mobile/view/widget/payment_widget.dart';
import 'package:mobile/view/widget/profile_page.dart';
import 'package:mobile/view/widget/responsive_chat_page.dart';
import 'package:mobile/view/widget/save_favourite.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:mobile/view/widget/view_specific_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/models/response/functionals/create_sandbox_payment_test.dart';
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
import 'Request_widget.dart';
import 'chat_front_page.dart';

class SubscriptionHistoryWidget extends StatefulWidget {
  const SubscriptionHistoryWidget({super.key});

  @override
  State<SubscriptionHistoryWidget> createState() =>
      _SubscriptionHistoryWidgetState();
}

class _SubscriptionHistoryWidgetState extends State<SubscriptionHistoryWidget> {
  String? accountIdToViewNotifications1;
  Future<PackageToShowToUser> _getData() async {
    try {
      final items = await PaymentService().getPackageToShow();
      return items;
    } catch (e) {
      throw e;
    }
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
                  color: Color(0xffEC4899).withOpacity(0.4),
                  onPressed: () {
                    Get.to(RequestWidget());
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
          width: width * 3,
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      text: "Subscription History",
                      style: appstyle(16, Color(0xffEC4899), FontWeight.w600)),
                ],
              ),
              // noti content
              Expanded(
                child: FutureBuilder(
                  future: _getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error loading data'));
                    } else if (!snapshot.hasData || snapshot.data! == null) {
                      return Center(child: Text('No data available'));
                    } else {
                      var document = snapshot.data!;
                      if (document.data![0]!.endDate == null) {
                        return ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 30,
                              child: Card(
                                margin: EdgeInsets.all(18),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(
                                        Icons.card_membership,
                                        color: Color(0xffa855f7),
                                      ),
                                      title: Text(
                                          'Name of the package: ${document.data![1]!.name}'),
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.card_travel_outlined,
                                        color: Color(0xffa855f7),
                                      ),
                                      title: Text(
                                          'Expore in: ${DateFormat('dd--MM--yyyy').format(DateTime.parse(document.data![1]!.endDate!))}'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 30,
                              child: Card(
                                margin: EdgeInsets.all(18),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(
                                        Icons.card_membership,
                                        color: Color(0xffa855f7),
                                      ),
                                      title: Text(
                                          'Name of the package: ${document.data![0]!.name}'),
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.card_travel_outlined,
                                        color: Color(0xffa855f7),
                                      ),
                                      title: Text(
                                          'Expore in: ${DateFormat('dd--MM--yyyy').format(DateTime.parse(document.data![0]!.endDate!))}'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
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
