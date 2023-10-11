import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/login_page.dart';
import '../../components/reusable_text.dart';
import '../../components/reusable_text_for_long_text.dart';
import '../../components/reusable_text_long.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_style.dart';
import '../../models/response/functionals/temp_creator_model.dart';
import '../../services/helpers/creator_helper.dart';

class CodeUIHomeScreenForGuest extends StatefulWidget {
  const CodeUIHomeScreenForGuest({super.key});

  @override
  State<CodeUIHomeScreenForGuest> createState() =>
      _CodeUIHomeScreenForGuestState();
}

class _CodeUIHomeScreenForGuestState extends State<CodeUIHomeScreenForGuest> {
  late Future<AllCreatorsTempModel> _creatorFuture;
  late Future<List<AllCreatorsTempModel>> items;
  Future<AllCreatorsTempModel> getData() async {
    try {
      final AllCreatorsTempModel response =
          (await (GetAllCreatorService().getAll()));

      return response;
    } catch (e) {
      throw e;
    }
  }

  @override
  void initState() {
    _creatorFuture = getData();
    super.initState();
  }

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

          selectedIndex: 0,
          // onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: NavigationDestination(
                  icon: Icon(
                    Icons.home_outlined,
                    color: Color(0xffEC4899),
                  ),
                  label: ""),
            ),
            NavigationDestination(
                icon: Icon(
                  Icons.search,
                  color: Color(0xffEC4899).withOpacity(0.4),
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
                  color: Color(0xffEC4899).withOpacity(0.4),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: height * 0.8,
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Column(children: [
            //categories
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: ReusableText(
                    text: "Top creators",
                    style: appstyle(16, Color(0xFFF6F0F0), FontWeight.w600),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const LoginWidget());
                      },
                      child: ReusableText(
                        text: "See more",
                        style: appstyle(12, Color(0xFFAB55F7), FontWeight.w600),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_outlined,
                      color: Color(0xFFAB55F7),
                    ),
                  ],
                ),
              ],
            ),
            // starting categories
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: 170,
                  width: width,
                  child: Container(
                      child: FutureBuilder<AllCreatorsTempModel>(
                    future: _creatorFuture,
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
                        // Access metadata property after the Future completes
                        var items = snapshot.data!;

                        return ListView.builder(
                          itemCount: items.metadata?.total,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 105,
                                        width: 104,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFFAB55F7),
                                              offset: Offset(0, 1),
                                              blurRadius: 12,
                                              spreadRadius: 1.0,
                                            ),
                                          ],
                                        ),
                                        child: Card(
                                          color: Color(0xff292929),
                                          clipBehavior: Clip.antiAlias,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          child: Stack(
                                            children: [
                                              Ink.image(
                                                image: NetworkImage(
                                                    "${items.data![index].profileResponse?.imageUrl}"),
                                                height: 105,
                                                width: 104,
                                                fit: BoxFit.cover,
                                              ),
                                              // Positioned(
                                              //   bottom: 12,
                                              //   // child: ReusableText(
                                              //   //   text:
                                              //   //       "  ${index + 1}. ${items?.data?[index].username} ",
                                              //   //   style: appstyle(
                                              //   //       15,
                                              //   //       Color(kLight.value),
                                              //   //       FontWeight.w600),
                                              //   // ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 80,
                                        child: ReusableTextLong(
                                          text:
                                              "  ${index + 1}. ${items?.data?[index].username} ",
                                          style: appstyle(
                                              15,
                                              Color(kLight.value),
                                              FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  )),
                )),
            //see more lol
          ]),
        ),
      ),
    );
  }
}
