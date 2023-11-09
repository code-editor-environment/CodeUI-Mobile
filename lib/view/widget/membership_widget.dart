import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/view/widget/login_page.dart';
import 'package:mobile/view/widget/profile_page.dart';
import 'package:mobile/view/widget/responsive_chat_page.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:mobile/view/widget/view_specific_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/reusable_text.dart';
import '../../components/reusable_text_long.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/models/response/functionals/profile_res_model.dart';
import '../../common/models/response/functionals/temp_creator_model.dart';
import '../../services/helpers/creator_helper.dart';
import '../../services/helpers/profile_helper.dart';

class MembershipWidget extends StatefulWidget {
  const MembershipWidget({super.key});

  @override
  State<MembershipWidget> createState() => _MembershipWidgetState();
}

class _MembershipWidgetState extends State<MembershipWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
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
          indicatorColor: Color(0xff181818),
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
                    color: Color(0xffEC4899).withOpacity(0.4),
                  ),
                  label: ""),
            ),
            NavigationDestination(
                icon: IconButton(
                  icon: Icon(Icons.search),
                  color: Color(0xffEC4899).withOpacity(0.4),
                  onPressed: () {
                    Get.to(SearchWidget());
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
                icon: Icon(
                  Icons.bookmarks_outlined,
                  color: Color(0xffEC4899).withOpacity(0.4),
                ),
                label: ""),
            NavigationDestination(
                icon: IconButton(
                  icon: Icon(Icons.shopping_cart_outlined),
                  color: Color(0xffEC4899).withOpacity(0.4),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Get.off(() => const LoginWidget());
                  },
                ),
                label: ""),
          ],
        ),
      ),
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
                    Tab(
                      text: "Pro++",
                    ),
                  ])),
              Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      height: height * 0.8,
                      child: TabBarView(controller: _tabController, children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 12, 12, 0),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      backgroundColor: Color(0xff4f46e5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      'Pro ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color(kLight.value),
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          12, 6, 6, 0),
                                      child: ReusableText(
                                        text: "\$4.99",
                                        style: appstyle(18, Color(0xfff5f0f0),
                                            FontWeight.w800),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 6, 0, 0),
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
                                    style: appstyle(
                                        16, Color(0xfff5f0f0), FontWeight.w500),
                                  ),
                                ),
                              ),
                              // content
                              Container(
                                width: double.maxFinite,
                                height: height * 0.4,
                                child: ListView.builder(
                                  itemCount: 6,
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
                                                  text: "Special Pro Badge",
                                                  style: appstyle(
                                                      18,
                                                      Color(0xfff5f0f0),
                                                      FontWeight.w600),
                                                ),
                                                Container(
                                                  width: width * 0.8,
                                                  child: ReusableText(
                                                    text:
                                                        "Stand out in the community with a unique Pro badge.",
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
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 12, 12, 0),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      backgroundColor: Color(0xffc026d3),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
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
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 12, 12, 0),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      backgroundColor: Color(0xff4f46e5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      'Pro ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color(kLight.value),
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          12, 6, 6, 0),
                                      child: ReusableText(
                                        text: "\$4.99",
                                        style: appstyle(18, Color(0xfff5f0f0),
                                            FontWeight.w800),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 6, 0, 0),
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
                                    style: appstyle(
                                        16, Color(0xfff5f0f0), FontWeight.w500),
                                  ),
                                ),
                              ),
                              // content
                              Container(
                                width: double.maxFinite,
                                height: height * 0.4,
                                child: ListView.builder(
                                  itemCount: 6,
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
                                                  text: "Special Pro Badge",
                                                  style: appstyle(
                                                      18,
                                                      Color(0xfff5f0f0),
                                                      FontWeight.w600),
                                                ),
                                                Container(
                                                  width: width * 0.8,
                                                  child: ReusableText(
                                                    text:
                                                        "Stand out in the community with a unique Pro badge.",
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
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 12, 12, 0),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      backgroundColor: Color(0xffc026d3),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
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
                            ]),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 12, 12, 0),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      backgroundColor: Color(0xff4f46e5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      'Pro ',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color(kLight.value),
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          12, 6, 6, 0),
                                      child: ReusableText(
                                        text: "\$4.99",
                                        style: appstyle(18, Color(0xfff5f0f0),
                                            FontWeight.w800),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 6, 0, 0),
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
                                    style: appstyle(
                                        16, Color(0xfff5f0f0), FontWeight.w500),
                                  ),
                                ),
                              ),
                              // content
                              Container(
                                width: double.maxFinite,
                                height: height * 0.4,
                                child: ListView.builder(
                                  itemCount: 6,
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
                                                  text: "Special Pro Badge",
                                                  style: appstyle(
                                                      18,
                                                      Color(0xfff5f0f0),
                                                      FontWeight.w600),
                                                ),
                                                Container(
                                                  width: width * 0.8,
                                                  child: ReusableText(
                                                    text:
                                                        "Stand out in the community with a unique Pro badge.",
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
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 12, 12, 0),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      backgroundColor: Color(0xffc026d3),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
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
                            ]),
                      ]),
                    ),
                  ),
                ],
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
