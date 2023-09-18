import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/components/reusable_text.dart';

import '../../constants/app_constants.dart';
import '../../constants/app_style.dart';
import '../../constants/custom_textfield.dart';
import 'login_page.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final TextEditingController email = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController password2 = TextEditingController();
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                    text: "Sign up",
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
                //field
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                  child: ReusableText(
                    text: "Username ",
                    style: appstyle(16, Color(0xffF6F0F0), FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                  child: CustomTextField(
                    controller: username,
                    keyboardType: TextInputType.emailAddress,
                    //  hintText: "Email or mobile number",
                    validator: (username) {
                      if (username!.isEmpty || !username.contains("@")) {
                        return "Ẹnter a valid email";
                      } else {
                        return null;
                      }
                    },
                    heightBox: 40,
                  ),
                ),
                //field
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                  child: ReusableText(
                    text: " Email ",
                    style: appstyle(16, Color(0xffF6F0F0), FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                  child: CustomTextField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    //  hintText: "Email or mobile number",
                    validator: (email) {
                      if (email!.isEmpty || !email.contains("@")) {
                        return "Ẹnter a valid email";
                      } else {
                        return null;
                      }
                    },
                    heightBox: 40,
                  ),
                ),
                //pass
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                  child: ReusableText(
                    text: "Password ",
                    style: appstyle(16, Color(0xffF6F0F0), FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                  child: CustomTextField(
                    controller: password,
                    keyboardType: TextInputType.text,
                    //   obscureText: loginNotifier.obscureText,
                    //   hintText: "Password",
                    validator: (password) {
                      if (password!.isEmpty || password.length < 8) {
                        return "Ẹnter a valid pass";
                      } else {
                        return null;
                      }
                    },
                    suffixIcon: GestureDetector(
                      onTap: () {
                        //     loginNotifier.obscureText = !loginNotifier.obscureText;
                      },
                      child: Icon(
                        // //    loginNotifier.obscureText
                        //         ? Icons.visibility :
                        Icons.visibility_off,
                        color: Color(kLight.value),
                      ),
                    ),
                    heightBox: 40,
                  ),
                ),

                //pass
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                  child: ReusableText(
                    text: "Confirm password ",
                    style: appstyle(16, Color(0xffF6F0F0), FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                  child: CustomTextField(
                    controller: password2,
                    keyboardType: TextInputType.text,
                    //   obscureText: loginNotifier.obscureText,
                    //   hintText: "Password",
                    validator: (password2) {
                      if (password2!.isEmpty || password2.length < 8) {
                        return "Ẹnter a valid pass";
                      } else {
                        return null;
                      }
                    },
                    suffixIcon: GestureDetector(
                      onTap: () {
                        //     loginNotifier.obscureText = !loginNotifier.obscureText;
                      },
                      child: Icon(
                        // //    loginNotifier.obscureText
                        //         ? Icons.visibility :
                        Icons.visibility_off,
                        color: Color(kLight.value),
                      ),
                    ),
                    heightBox: 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        //     Get.to(LoginWidget());
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(60, 8, 60, 8),
                        backgroundColor: Color(0xffEC4899),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text(
                        'Sign up ',
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

                // or countinue with picture
                Container(
                  width: width,
                  height: 60,
                  child: Image.asset(
                    "assets/images/ocw.png",
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/icons/google.png",
                      width: 48,
                    ),
                    Image.asset(
                      "assets/icons/github.png",
                      width: 48,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ReusableText(
                      text: "Already had account? ",
                      style: appstyle(16, Color(0xffF6F0F0), FontWeight.w400),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(LoginWidget());
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(60, 8, 60, 8),
                        backgroundColor: Color(0xff06B6D4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text(
                        'Log in',
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
