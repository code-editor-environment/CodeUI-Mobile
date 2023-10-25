import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/save_favourite.dart';
import 'package:mobile/view/widget/search_page.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/reusable_text.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/constants/custom_textfield.dart';
import 'elements_detail.dart';
import 'home_page_user_logged_in.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  var sampleItems = [
    "Search for elements",
    "Search for creators",
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
                  color: Color(0xffEC4899),
                  onPressed: () {
                    // Get.to(SearchWidget());
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
                icon: IconButton(
                  icon: Icon(Icons.bookmarks_outlined),
                  color: Color(0xffEC4899).withOpacity(0.4),
                  onPressed: () {
                    Get.to(BookmarkedOwnedWidget());
                  },
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
                      onTap: () {
                        if (item == "Search for elements") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailedWidget()),
                            // Replace DetailedWidget() with your actual element pages route.
                          );
                        } else if (item == "Search for creators") {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => CreatorPages()), // Replace CreatorPages() with your actual creator pages route.
                          // );
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
