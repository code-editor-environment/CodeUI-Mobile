import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/login_page.dart';
import 'package:mobile/view/widget/payment_widget.dart';
import 'package:mobile/view/widget/profile_page.dart';
import 'package:mobile/view/widget/responsive_chat_page.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:mobile/view/widget/view_specific_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/models/response/functionals/create_sandbox_payment_test.dart';
import '../../common/models/response/functionals/get_package_to_show.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/reusable_text.dart';
import '../../components/reusable_text_long.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/models/response/functionals/profile_res_model.dart';
import '../../common/models/response/functionals/temp_creator_model.dart';
import '../../services/helpers/creator_helper.dart';
import '../../services/helpers/payment_helper.dart';
import '../../services/helpers/profile_helper.dart';

class MembershipWidget extends StatefulWidget {
  const MembershipWidget({super.key});

  @override
  State<MembershipWidget> createState() => _MembershipWidgetState();
}

class _MembershipWidgetState extends State<MembershipWidget>
    with TickerProviderStateMixin {
  Future<PackageToShowToUser> _getData() async {
    try {
      final items = await PaymentService().getPackageToShow();
      return items;
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    PaymentService paymentService = PaymentService();
    TabController _tabController = TabController(length: 2, vsync: this);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomLoggedInUserAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back),
                      color: Color(0xffEC4899),
                    ),
                  ),
                  ReusableText(
                    text: "Unleash your creativity to Soar",
                    style: appstyle(18, Color(0xfff5f0f0), FontWeight.w700),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ReusableText(
                        text: "Among the Universe!",
                        style: appstyle(18, Color(0xfff5f0f0), FontWeight.w700),
                      ),
                      Image.asset(
                        "assets/images/rocket-ae8889ff.png",
                        width: 20,
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                  child: TabBar(
                      controller: _tabController,
                      labelColor: Color(0xffEC4899),
                      unselectedLabelColor: Color(0xfff5f0f0),
                      indicator: CircleTabIndicator(
                          color: Color(0xffA855F7), radius: 5.5),
                      tabs: [
                    Tab(
                      text: "Pro",
                    ),
                    Tab(
                      text: "Pro+",
                    ),
                  ])),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SizedBox(
                  height: height * 0.8,
                  child: TabBarView(controller: _tabController, children: [
                    FutureBuilder(
                      future: _getData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child:
                                  CircularProgressIndicator()); // Show a loading indicator while waiting for data.
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          ); // Handle the error.
                        } else if (!snapshot.hasData) {
                          return Center(
                            child: Text(
                                'No data available'), // Handle no data case.
                          );
                        } else if (snapshot.data!.data!.isEmpty) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      // Get.off(() =>
                                      //     const CodeUIHomeScreenForLoggedInUser());
                                      Get.back();
                                    },
                                    icon: Icon(Icons.arrow_back),
                                    color: Color(0xffEC4899),
                                  ),
                                ],
                              ),
                              Container(
                                height: 200,
                                child: Center(
                                    child: ReusableText(
                                        text: "Nothing here to be shown",
                                        style: appstyle(
                                            14, Colors.amber, FontWeight.w400))
                                    // Handle no data case.
                                    ),
                              ),
                            ],
                          );
                        } else {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 6, 6, 0),
                                        child: ReusableText(
                                          text:
                                              "${snapshot.data!.data?[0].price?.toStringAsFixed(0)} đ",
                                          style: appstyle(18, Color(0xfff5f0f0),
                                              FontWeight.w800),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 6, 0, 0),
                                        child: ReusableText(
                                          text: "/month",
                                          style: appstyle(16, Color(0xfff5f0f0),
                                              FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // brief description about the package name
                                Container(
                                  width: width * 0.95,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 0, 0, 0),
                                    child: ReusableText(
                                      text:
                                          "With this plan, you'll gain access to advanced extra features.",
                                      style: appstyle(16, Color(0xfff5f0f0),
                                          FontWeight.w500),
                                    ),
                                  ),
                                ),
                                // content
                                Container(
                                  width: double.maxFinite,
                                  height: height * 0.4,
                                  child: ListView.builder(
                                    itemCount:
                                        snapshot.data!.data![0].totalFeature,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            12, 8, 0, 0),
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.check,
                                                color: Color(0xff818cf8),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ReusableText(
                                                    text:
                                                        "${snapshot.data!.data![0].features?[index].name}",
                                                    style: appstyle(
                                                        18,
                                                        Color(0xfff5f0f0),
                                                        FontWeight.w600),
                                                  ),
                                                  Container(
                                                    width: width * 0.8,
                                                    child: ReusableText(
                                                      text:
                                                          "${snapshot.data!.data![0].features?[index].description}",
                                                      style: appstyle(
                                                          14,
                                                          Color(0xfff5f0f0),
                                                          FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ]),
                                      );
                                    },
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12, 12, 12, 0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        // var urlToPay = response[];
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 8),
                                        backgroundColor: Color(0xffc026d3),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        'Get started ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(kLight.value),
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]);
                        }
                      },
                    ),
                    //content1
                    FutureBuilder(
                      future: _getData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child:
                                  CircularProgressIndicator()); // Show a loading indicator while waiting for data.
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          ); // Handle the error.
                        } else if (!snapshot.hasData) {
                          return Center(
                            child: Text(
                                'No data available'), // Handle no data case.
                          );
                        } else if (snapshot.data!.data!.isEmpty) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      // Get.off(() =>
                                      //     const CodeUIHomeScreenForLoggedInUser());
                                      Get.back();
                                    },
                                    icon: Icon(Icons.arrow_back),
                                    color: Color(0xffEC4899),
                                  ),
                                ],
                              ),
                              Container(
                                height: 200,
                                child: Center(
                                    child: ReusableText(
                                        text: "Nothing here to be shown",
                                        style: appstyle(
                                            14, Colors.amber, FontWeight.w400))
                                    // Handle no data case.
                                    ),
                              ),
                            ],
                          );
                        } else {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 6, 6, 0),
                                        child: ReusableText(
                                          text:
                                              "${snapshot.data!.data![1].price?.toStringAsFixed(0)} đ",
                                          style: appstyle(18, Color(0xfff5f0f0),
                                              FontWeight.w800),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 6, 0, 0),
                                        child: ReusableText(
                                          text: "/month",
                                          style: appstyle(16, Color(0xfff5f0f0),
                                              FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // brief description about the package name
                                Container(
                                  width: width * 0.95,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 0, 0, 0),
                                    child: ReusableText(
                                      text:
                                          "With this plan, you'll gain access to advanced extra features.",
                                      style: appstyle(16, Color(0xfff5f0f0),
                                          FontWeight.w500),
                                    ),
                                  ),
                                ),
                                // content
                                Container(
                                  width: double.maxFinite,
                                  height: height * 0.4,
                                  child: ListView.builder(
                                    itemCount:
                                        snapshot.data!.data![1].totalFeature,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            12, 8, 0, 0),
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.check,
                                                color: Color(0xff818cf8),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ReusableText(
                                                    text:
                                                        "${snapshot.data!.data![1].features?[index].name}",
                                                    style: appstyle(
                                                        18,
                                                        Color(0xfff5f0f0),
                                                        FontWeight.w600),
                                                  ),
                                                  Container(
                                                    width: width * 0.8,
                                                    child: ReusableText(
                                                      text:
                                                          "${snapshot.data!.data![1].features?[index].description}",
                                                      style: appstyle(
                                                          14,
                                                          Color(0xfff5f0f0),
                                                          FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ]),
                                      );
                                    },
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12, 12, 12, 0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        // var urlToPay = response[];
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 8),
                                        backgroundColor: Color(0xffc026d3),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        'Get started ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(kLight.value),
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]);
                        }
                      },
                    ),
                    //content1
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;
  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
