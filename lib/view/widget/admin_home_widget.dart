import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/search_page.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/reusable_text.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_style.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  // int index = 0;
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
          selectedIndex: 0,
          indicatorShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                icon: IconButton(
                  icon: Icon(Icons.search),
                  color: Color(0xffEC4899).withOpacity(0.4),
                  onPressed: () {
                    //  Get.to(SearchWidget());
                  },
                ),
                label: ""),
            NavigationDestination(
                icon: Icon(
                  MdiIcons.messageProcessing,
                  color: Color(0xffEC4899).withOpacity(0.4),
                ),
                label: ""),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Column(children: [
            //lazy load pic in middle
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    // Get.to(CodeUIHomeScreenForLoggedInUser());
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(60, 8, 60, 8),
                    backgroundColor: Color(0xffA855F7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    'User management ',
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: Color(0xfff6f0f0),
                        fontSize: 13,
                        fontWeight:
                            FontWeight.w500, // Change the text color here
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //usage wever
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    // Get.to(CodeUIHomeScreenForLoggedInUser());
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(60, 8, 60, 8),
                    backgroundColor: Color(0xffA855F7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    'Elements  ',
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: Color(0xfff6f0f0),
                        fontSize: 13,
                        fontWeight:
                            FontWeight.w500, // Change the text color here
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //categories
          ]),
        ),
      ),
    );
  }
}
