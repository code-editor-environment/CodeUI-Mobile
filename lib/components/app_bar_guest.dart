import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/view/widget/login_page.dart';

class CustomGuestAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomGuestAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black,
        child: Row(
          // row chưa nguyên cái app bar
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Image.asset(
                "assets/images/logo.png",
                width: 133,
                height: 96,
              ),
            ),
            //row chứa 2 cái icon button
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                    child: Icon(
                      Icons.notifications_none_outlined,
                      color: Color(0xffA855F7),
                      size: 30,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(LoginWidget());
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      backgroundColor: Color(0xffa855f7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_2_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                        Text(
                          'Log in ',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              color: Color(0xfff6f0f0),
                              fontSize: 13,
                              fontWeight:
                                  FontWeight.w500, // Change the text color here
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(
        double.maxFinite,
        80,
      );
}
