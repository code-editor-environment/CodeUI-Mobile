import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/save_favourite.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:mobile/view/widget/user_get_approved_elements_by_category_filter.dart';
import 'package:mobile/view/widget/user_get_approved_elements_by_category_filter_guest.dart';
import 'package:mobile/view/widget/user_get_approved_elements_by_username_filter.dart';
import 'package:mobile/view/widget/user_get_approved_elements_by_username_filter_guest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/reusable_text.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/constants/custom_textfield.dart';
import 'elements_detail.dart';
import 'home_page_guest.dart';
import 'home_page_user_logged_in.dart';
import 'moderator_get_approved_elements_by_category_filter.dart';
import 'moderator_get_approved_elements_by_username_filter.dart';

class SearchWidgetGuest extends StatefulWidget {
  const SearchWidgetGuest({super.key});

  @override
  State<SearchWidgetGuest> createState() => _SearchWidgetGuestState();
}

class _SearchWidgetGuestState extends State<SearchWidgetGuest> {
  var sampleItems = [
    "Search all approved elements by the creators name",
    "Search by approved category name",
  ];
  var item = [];
  var searchHistory = [];
  final TextEditingController searchController = TextEditingController();
  // int index = 0;
  final TextEditingController keyword = TextEditingController();
  @override
  void initState() {
    super.initState();
    // searchController.addListener(q);
  }

  // void search(String query) {
  //   if (query.isEmpty) {
  //     setState(() {
  //       item = sampleItems;
  //     });
  //   } else {
  //     if (item == "Search for elements") {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => DetailedWidget()),
  //         // Replace DetailedWidget() with your actual element pages route.
  //       );
  //     } else if (item == "Search for creators") {
  //       // Navigator.push(
  //       //   context,
  //       //   MaterialPageRoute(builder: (context) => CreatorPages()), // Replace CreatorPages() with your actual creator pages route.
  //       // );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      //  extendBodyBehindAppBar: true,
      appBar: CustomGuestAppBar(),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(indicatorColor: Colors.black),
        child: NavigationBar(
          height: 50,
          backgroundColor: Color(0xff181818),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,

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
                      Get.to(CodeUIHomeScreenForGuest());
                    },
                  ),
                  label: ""),
            ),
            NavigationDestination(
                icon: IconButton(
                  icon: Icon(Icons.search),
                  color: Color(0xffEC4899),
                  onPressed: () {
                    Get.to(SearchWidgetGuest());
                  },
                ),
                label: ""),
          ],
        ),
      ),
      body: Container(
          height: height,
          color: Theme.of(context).primaryColor,
          child: Container(
            color: Color(0xff1C1C1C),
            height: 80,
            child: Column(
              children: [
                SearchAnchor(
                    // viewBackgroundColor: Color(0xff1C1C1C),
                    builder:
                        (BuildContext context, SearchController controller) {
                  return SearchBar(
                    textStyle: MaterialStateProperty.all<TextStyle?>(
                      TextStyle(
                        color: Colors.white, // Set your desired text color here
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll<Color>(
                      Color(0xff353535),
                    ),
                    controller: controller,
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0)),
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                    leading: const Icon(
                      Icons.search,
                      color: Color(0xffEC4899),
                    ),
                    hintText: "Search on CodeUI",
                    hintStyle: MaterialStatePropertyAll<TextStyle?>(
                        TextStyle(color: Color(0xffF6F0F0))),
                  );
                }, suggestionsBuilder:
                        (BuildContext context, SearchController controller) {
                  return sampleItems.map((item) {
                    // Widget page;
                    // if (item == "Search for elements") {
                    //   page =
                    //       DetailedWidget(); // Replace DetailedWidget() with your actual element pages widget.
                    // } else if (item == "Search for creators") {
                    //   // page =
                    //   //     CreatorPages(); // Replace CreatorPages() with your actual creator pages widget.
                    // }

                    return GestureDetector(
                      onTap: () async {
                        if (item ==
                            "Search all approved elements by the creators name") {
                          if (controller.text == '') {
                          } else {
                            var queryToPass = controller.text;
                            print(queryToPass);
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString(
                                "usernamesElementToFilter", queryToPass);
                            Get.to(() =>
                                const UserGetApprovedElementsListViewByFilteringGuest());
                          }
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => DetailedWidget()),
                          //   // Replace DetailedWidget() with your actual element pages route.
                          // );
                        } else if (item == "Search by approved category name") {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => CreatorPages()), // Replace CreatorPages() with your actual creator pages route.
                          // );

                          if (controller.text == '') {
                          } else {
                            var categoriesNameToFilter = controller.text;
                            print(categoriesNameToFilter);
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString("categoriesNameToFilter",
                                categoriesNameToFilter);
                            Get.to(() =>
                                const UserApprovedElementsListViewByCategoryFilteringGuest());
                          }
                        }
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.search,
                          color: Color(0xffEC4899),
                        ),
                        title: Text(item),
                        trailing: Icon(Icons.arrow_forward_outlined),
                      ),
                    );
                  }).toList();
                }),
              ],
            ),
          )),
    );
  }
}
