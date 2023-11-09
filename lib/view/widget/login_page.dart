import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/components/reusable_text.dart';
import 'package:mobile/services/helpers/auth_helper.dart';
import 'package:mobile/view/widget/home_page_user_logged_in.dart';
import 'package:provider/provider.dart';
import 'package:mobile/common/constants/app_constants.dart';
import 'package:mobile/common/constants/app_style.dart';
import 'package:mobile/common/constants/custom_textfield.dart';
import 'package:mobile/common/models/request/auth/login_model.dart';
import 'package:mobile/model_validation.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthHelper authHelper = AuthHelper();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer<ValidateNotifier>(
      builder: (context, loginNotifier, child) {
        return SafeArea(
          child: Scaffold(
            // appBar: PreferredSize(
            //   preferredSize: Size.fromHeight(20),
            //   child: AppBar(
            //     foregroundColor: Colors.red,
            //     automaticallyImplyLeading: true,
            //     backgroundColor: Color(0xff1C1C1C),
            //     // title: Text("Login"),
            //   ),
            // ),
            backgroundColor: Color(0xff1C1C1C),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                color: Color(0xff1C1C1C),
                // Set your container properties here, e.g., color, width, height, etc.
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: height * 0.25,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                      child: ReusableText(
                        text: "Log in ",
                        style: appstyle(20, Color(0xffF6F0F0), FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      color: Color(0xFF3A3A3A),
                      indent: 20,
                      endIndent: 20,
                      height: height * 0.003,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                      child: Container(
                        width: width * 0.89,
                        child: ElevatedButton(
                          onPressed: () {
                            authHelper.handleSignin();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(
                                16, 8, 16, 8), // Adjust the padding here
                            // Set minimum width to 0 to allow the button to size based on content
                            backgroundColor: Color(0xff292929),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/google.png",
                                width: 36,
                                height: 24,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(42, 0, 0, 0),
                                child: Text(
                                  'Sign in with google',
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      color: Color(0xfff6f0f0),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                      child: Container(
                        width: width * 0.89,
                        child: ElevatedButton(
                          onPressed: () {
                            authHelper.signInWithGithub();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(
                                16, 8, 16, 8), // Adjust the padding here
                            // Set minimum width to 0 to allow the button to size based on content
                            backgroundColor: Color(0xff292929),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/github.png",
                                width: 36,
                                height: 24,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(42, 0, 0, 0),
                                child: Text(
                                  'Sign in with github',
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      color: Color(0xfff6f0f0),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                      child: Container(
                        width: width * 0.89,
                        child: ElevatedButton(
                          onPressed: () {
                            // Get.off(
                            //     () => const CodeUIHomeScreenForLoggedInUser());
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.fromLTRB(
                                16, 0, 0, 0), // Adjust the padding here
                            // Set minimum width to 0 to allow the button to size based on content
                            backgroundColor: Color(0xff292929),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(MdiIcons.phone),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                                child: Text(
                                  'Sign in with phone number',
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      color: Color(0xfff6f0f0),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        // end of login page
      },
    );
  }
}
