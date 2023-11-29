import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/save_favourite.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/app_bar_moderator_admin.dart';
import '../../components/reusable_text.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/constants/custom_textfield.dart';
import 'elements_detail.dart';
import 'home_page_user_logged_in.dart';
import 'moderator_elements_management.dart';
import 'moderator_get_approved_elements_by_category_filter.dart';
import 'moderator_get_approved_elements_by_username_filter.dart';

class ModeratorSearchWidget extends StatefulWidget {
  const ModeratorSearchWidget({super.key});

  @override
  State<ModeratorSearchWidget> createState() => _ModeratorSearchWidgetState();
}

class _ModeratorSearchWidgetState extends State<ModeratorSearchWidget> {
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
      appBar: ModeratorAppBarWidget(),
    
      body: Container(
          height: height,
          color: Theme.of(context).primaryColor,
          child: Container(
            color: Color(0xff1C1C1C),
            height: 80,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.to(() => const ModeratorElementsManagement());
                      },
                      icon: Icon(
                        MdiIcons.arrowLeft,
                        color: Color(0xffEC4899),
                      ),
                    )
                  ],
                ),
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
                                const ApprovedElementsListViewByFiltering());
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
                                const ApprovedElementsListViewByCategoryFiltering());
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
