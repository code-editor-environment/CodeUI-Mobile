import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile/common/constants/app_style.dart';
import 'package:mobile/components/reusable_text.dart';
import 'package:mobile/components/vnpay_package_refactored_for_flutter/src/vnpay_screen.dart';
import 'package:mobile/view/widget/login_page.dart';
import 'package:mobile/view/widget/membership_widget.dart';
import 'package:mobile/view/widget/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/constants/app_constants.dart';
import '../common/models/response/functionals/create_sandbox_payment_test.dart';
import '../common/models/response/functionals/profile_res_model.dart';
import '../services/helpers/payment_helper.dart';
import '../services/helpers/profile_helper.dart';
import '../view/widget/home_page_guest.dart';
import '../view/widget/home_page_user_logged_in.dart';
import '../view/widget/notification_widget.dart';
import '../view/widget/payment_widget.dart';

class CustomLoggedInUserAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  const CustomLoggedInUserAppBar({super.key});
  @override
  Size get preferredSize => Size(
        double.maxFinite,
        100,
      );
  @override
  State<CustomLoggedInUserAppBar> createState() =>
      _CustomLoggedInUserAppBarState();
}

class _CustomLoggedInUserAppBarState extends State<CustomLoggedInUserAppBar> {
  String title1 = "Profile";
  String title3 = "Log out";
  String title2 = "Subscription";
  String title0 = "Home";
  late Future<ViewProfileResponse> _profileFuture;
  Future<ViewProfileResponse> _getData() async {
    try {
      final items = await GetProfileService().getAll();
      return items;
    } catch (e) {
      throw e;
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize your future here, for example:
    _profileFuture = _getData(); // You need to implement this function
  }

  final paymentUrl = 'example';

  void _onPaymentSuccess(data) {}

  void _onPaymentFailure(error) {}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            Row(
              // row chưa nguyên cái app bar
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 133,
                  height: 96,
                ),
                //row chứa 2 cái icon button
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
                  child: FutureBuilder(
                    future: _profileFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child:
                                CircularProgressIndicator()); // Show a loading indicator while waiting for data.
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Icon(Icons.close),
                        ); // Handle the error.
                      } else if (!snapshot.hasData) {
                        return Center(
                          child:
                              Text('No data available'), // Handle no data case.
                        );
                      } else {
                        return ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => MyDialog1(

                                  //elementsNameToReport: '$tempName',
                                  ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            backgroundColor: Color(0xffa855f7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            ' ${snapshot.data!.data!.profileResponse!.wallet!.toInt()} đ',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(kLight.value),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                        child: IconButton(
                          onPressed: () {
                            Get.to(() => const NotificationWidget());
                          },
                          icon: Icon(
                            Icons.notifications_none_outlined,
                            color: Color(0xffA855F7),
                            size: 24,
                          ),
                        ),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) async {
                          // handle menu item selection here
                          if (value == title0) {
                            //get to profile page
                            Get.to(() => CodeUIHomeScreenForLoggedInUser());
                          } else if (value == title1) {
                            //get to profile page
                            Get.to(() => ProfileWidget());
                          } else if (value == title2) {
                            //get to membership page4
                            Get.to(() => MembershipWidget());
                          } else if (value == title3) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            prefs.remove("accessToken");
                            var token = prefs.getString("accessToken");
                            print(token);
                            final GoogleSignIn googleSignIn = GoogleSignIn();
                            final FirebaseAuth auth = FirebaseAuth.instance;
                            await googleSignIn
                                .signOut(); // Sign out from Google
                            await auth.signOut(); // Sign out from Firebase

                            // if (token == null) {
                            //   Get.to(() => const CodeUIHomeScreenForGuest());
                            // } else {
                            //   Get.to(() => CodeUIHomeScreenForLoggedInUser());
                            // }
                            // FirebaseAuth.instance.signOut();
                            print(FirebaseAuth.instance.currentUser);
                            Get.off(() => const CodeUIHomeScreenForGuest());
                          }
                        },
                        itemBuilder: (context) => <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: title0,
                            child: Row(
                              children: [
                                Icon(Icons.home),
                                Text(title0),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: title1,
                            child: Row(
                              children: [
                                Icon(Icons.person),
                                Text(title1),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: title2,
                            child: Row(
                              children: [
                                Icon(Icons.card_membership),
                                Text(title2),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: title3,
                            child: Row(
                              children: [
                                Icon(Icons.logout),
                                Text(title3),
                              ],
                            ),
                          ),
                        ],
                        child: FutureBuilder(
                          future: _profileFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child:
                                      CircularProgressIndicator()); // Show a loading indicator while waiting for data.
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Icon(Icons.close),
                              ); // Handle the error.
                            } else if (!snapshot.hasData) {
                              return Center(
                                child: Text(
                                    'No data available'), // Handle no data case.
                              );
                            } else {
                              return CircleAvatar(
                                radius: 18,
                                backgroundColor: Color(0xffA855F7),
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundImage: NetworkImage(
                                      "${snapshot.data!.data!.profileResponse!.imageUrl}"),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyDialog1 extends StatefulWidget {
  @override
  _MyDialog1State createState() => _MyDialog1State();
}

class _MyDialog1State extends State<MyDialog1> {
  // Uint8List? _image;
  // void selectImage() async {
  //   Uint8List img = await pickImage(ImageSource.gallery);
  //   setState(() {
  //     _image = img;
  //   });
  // }

  TextEditingController money = TextEditingController();
  TextEditingController reason = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  final paymentUrl = 'example';

  void _onPaymentSuccess(data) {
    Get.to(() => const ProfileWidget());
  }

  void _onPaymentFailure(error) {
    Get.to(() => const CodeUIHomeScreenForLoggedInUser());
  }

  @override
  Widget build(BuildContext context) {
    PaymentService paymentService = PaymentService();
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text("Add cash to account "),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                    text: "Amount(VND)",
                    style: appstyle(14, Color(0xffec4899), FontWeight.w500)),
                TextField(
                  controller: money,
                  decoration: InputDecoration(
                    hintText: "Enter your amount",
                    border: OutlineInputBorder(),
                  ),
                ),
                // ReusableText(
                //     text: "Description",
                //     style: appstyle(14, Color(0xffec4899), FontWeight.w500)),
                // TextField(
                //   controller: reason,
                //   decoration: InputDecoration(
                //     hintText: "Enter your description",
                //     border: OutlineInputBorder(),
                //   ),
                // ),
                Center(
                    child: ElevatedButton(
                        onPressed: () async {
                          int money1 = int.parse(money.text);
                          CreateSandBoxPaymentTest model = CreateSandBoxPaymentTest(
                              money: money1,
                              orderType: "billpayment",
                              orderDescription: "Add cash to balance",
                              returnUrl:
                                  "https://dev.codeui-api.io.vn/api/payment/confirmPayment");
                          print(model.toJson());

                          dynamic response =
                              await paymentService.createSandboxPayment(model);
                          print(response);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          var url123456 = prefs.getString("urltoPay");
                          Get.to(() => PaymentWidget(url: url123456!));
                        },
                        child: Text("Submit"))),
              ],
            ),
          ),
        );
      },
    );
  }
}
