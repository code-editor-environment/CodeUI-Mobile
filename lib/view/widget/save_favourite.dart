import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/search_page.dart';

import '../../components/app_bar_logged_in_user.dart';
import '../../components/bookmarked_item.dart';
import '../../components/liked_item.dart';
import '../../components/reusable_text.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_style.dart';
import '../../constants/custom_textfield.dart';
import 'home_page_user_logged_in.dart';

class BookmarkedOwnedWidget extends StatefulWidget {
  const BookmarkedOwnedWidget({super.key});

  @override
  State<BookmarkedOwnedWidget> createState() => _BookmarkedOwnedWidgetState();
}

class _BookmarkedOwnedWidgetState extends State<BookmarkedOwnedWidget> {
  final TextEditingController searchController = TextEditingController();
  // int index = 0;
  final TextEditingController keyword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        //  extendBodyBehindAppBar: true,
        appBar: CustomLoggedInUserAppBar(),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(indicatorColor: Colors.black),
          child: NavigationBar(
            height: 50,
            backgroundColor: Color(0xff181818),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            indicatorColor: Color(0xff292929),
            indicatorShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            selectedIndex: 1,
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
                      // Get.to(BookmarkedOwnedWidget());
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
                    color: Color(0xffEC4899),
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
        body: Container(
          color: Color(0xff1C1C1C),
          width: double.infinity,
          height: double.infinity,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 1200,
              minHeight: 1200,
            ),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      MdiIcons.bookmarkOutline,
                      color: Color(0xffEC4899),
                    ),
                    ReusableText(
                      text: " Save favourite",
                      style: appstyle(18, Color(0xffEC4899), FontWeight.w400),
                    ),
                  ],
                ),
              ),
              BookmarkedItemWidget(),
            ]),
          ),
        ));
  }
}
