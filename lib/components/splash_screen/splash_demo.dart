import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/view/widget/home_page_user_logged_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../view/widget/home_page_guest.dart';

class FakeSplashWidget extends StatelessWidget {
  const FakeSplashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x001c1c1c),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors
                    .transparent, // Set the button background color to transparent
                elevation: 0, // Remove the button shadow
                padding: EdgeInsets.zero, // Remove default button padding
                // Reduce the button's tap target size
              ),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var token = prefs.getString("accessToken");
                print(token);
                if (token == null) {
                  Get.off(() => const CodeUIHomeScreenForGuest());
                } else {
                  Get.off(() => CodeUIHomeScreenForLoggedInUser());
                }
                // Get.to(CodeUIHomeScreenForGuest());
              },
              child: Image.asset(
                "assets/images/logo.png",
                width: 340,
                height: 200,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
            child: Text(
              "To make your website just ",
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: Color(0xffA855F7),
                  fontSize: 20,
                  fontWeight: FontWeight.w500, // Change the text color here
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
            child: Text(
              "a bit more unique",
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: Color(0xffA855F7),
                  fontSize: 20,
                  fontWeight: FontWeight.w500, // Change the text color here
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
