import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/services/helpers/creator_helper.dart';
import 'package:mobile/services/helpers/profile_helper.dart';
import 'package:mobile/services/helpers/report_helper.dart';
import 'package:mobile/view/widget/responsive_chat_page.dart';
import 'package:mobile/view/widget/save_favourite.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:mobile/view/widget/view_others_approved_elements.dart';
import 'package:mobile/view/widget/view_others_draft_elements.dart';
import 'package:mobile/view/widget/view_others_rejected_elements.dart';
import 'package:mobile/view/widget/view_pending_approved_elements.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/models/request/functional/send_reports_for_accounts_without_images.dart';
import '../../common/models/response/functionals/get_elements_by_user_name_model.dart';
import '../../common/models/response/functionals/get_elements_by_user_name_model_1.dart';
import '../../common/models/response/functionals/get_elements_by_user_name_model_2.dart';
import '../../components/app_bar_logged_in_user.dart';
import '../../components/reusable_text.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/app_style.dart';
import '../../common/models/response/functionals/view_profile_res_model.dart';
import '../../services/helpers/element_helper.dart';
import 'Request_widget.dart';
import 'chat_front_page.dart';
import 'elements_detail.dart';
import 'home_page_user_logged_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewSpecificProfileWidget extends StatefulWidget {
  const ViewSpecificProfileWidget({super.key});

  @override
  State<ViewSpecificProfileWidget> createState() =>
      _ViewSpecificProfileWidgetState();
}

class _ViewSpecificProfileWidgetState extends State<ViewSpecificProfileWidget> {
  late Future<ViewSpecificProfileResponse> _profileFuture;
  RxBool isFollowed = false.obs;
  RxBool isFollowedTrue = false.obs;
  Future<ViewSpecificProfileResponse> _getData() async {
    final items = await GetProfileService().getOne();
    return items;
  }

  GetElementService getElementService = GetElementService();
  Future<GetElementsFromASpecificUser> _getElementData() async {
    final items1 = await getElementService.getAll();
    return items1;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("accessToken");
      var _currentLoggedInUsername =
          prefs.getString("currentLoggedInUsername")!;
      var accountIdToBeViewedInElements =
          prefs.getString("accountIdToBeViewed");

      print(_currentLoggedInUsername);
      print("viewspec:$accountIdToBeViewedInElements");
    }); // Wait for each asynchronous operation to complete before starting the next one
    _profileFuture = _getData();
    super.initState();
    // _profileFuture2 = _getElementData1();
    // _profileFuture3 = _getElementData2();
    // _profileFuture4 = _getElementData3();
  }

  final db = FirebaseFirestore.instance;

  int index = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print(height);
    print(width);
    return SafeArea(
        child: Scaffold(
      //  extendBodyBehindAppBar: true,
      appBar: CustomLoggedInUserAppBar(),
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
                  color: Color(0xffEC4899).withOpacity(0.4),
                  onPressed: () {
                    Get.to(SearchWidget());
                  },
                ),
                label: ""),
            NavigationDestination(
                icon: IconButton(
                  icon: Icon(Icons.message),
                  color: Color(0xffEC4899).withOpacity(0.4),
                  onPressed: () {
                    Get.to(ChatFrontPage());
                  },
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
                icon: IconButton(
                  icon: Icon(MdiIcons.codeJson),
                  color: Color(0xffEC4899).withOpacity(0.4),
                  onPressed: () {
                    Get.to(RequestWidget());
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
          color: Colors.black,
          child: Column(
            children: [
              FutureBuilder<ViewSpecificProfileResponse>(
                  future: _profileFuture,
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
                      // Build your UI using the items and controllers
                      var items = snapshot.data!;
                      final tempName = items.data!.username;
                      if (items.data!.isFollow = true) {
                        isFollowedTrue = true.obs;
                      }
                      if (items.data!.isFollow = false) {
                        isFollowed = true.obs;
                      }
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //lazy load pic in middle
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
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => MyDialog1(
                                          accountNametoReport: '$tempName',
                                          //elementsNameToReport: '$tempName',
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.report_problem_rounded,
                                      color: Color(0xffAB55F7),
                                      size: 22,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 48,
                                      backgroundColor: Color(0xffA855F7),
                                      child: CircleAvatar(
                                        radius: 48,
                                        backgroundImage: NetworkImage(
                                            "${items.data?.imageUrl}"),
                                        // backgroundImage:
                                        //     AssetImage("assets/images/123.png"),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 0, 0, 0),
                                          child: ReusableText(
                                            text:
                                                "${items.data?.firstName} ${items.data?.lastName}",
                                            style: appstyle(
                                                20,
                                                Color(0xffF6F0F0),
                                                FontWeight.w600),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 4, 0, 0),
                                          child: ReusableText(
                                            text: "@${items.data?.username}",
                                            style: appstyle(
                                                14,
                                                Color(0xffA0A0A0),
                                                FontWeight.w800),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Obx(
                                              () => Visibility(
                                                visible: isFollowed.value,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          16, 0, 0, 0),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      GetAllCreatorService()
                                                          .followCreator();
                                                      isFollowed.value =
                                                          !isFollowed.value;
                                                      isFollowedTrue.value =
                                                          !isFollowedTrue.value;
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 12,
                                                          vertical: 8),
                                                      backgroundColor:
                                                          Color(0xffEC4899),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      'Follow ',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(kLight.value),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Obx(
                                              () => Visibility(
                                                visible: isFollowedTrue.value,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          16, 0, 0, 0),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      GetAllCreatorService()
                                                          .followCreator();
                                                      isFollowed.value =
                                                          !isFollowed.value;
                                                      isFollowedTrue.value =
                                                          !isFollowedTrue.value;
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 12,
                                                          vertical: 8),
                                                      backgroundColor:
                                                          Color(0xffA855F7),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      'Followed',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(kLight.value),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // Align(
                              //   alignment: Alignment.center,
                              //   child: ReusableText(
                              //     text: "Username ",
                              //     style: appstyle(
                              //         14, Color(0xffF6F0F0), FontWeight.w400),
                              //   ),
                              // ),

                              SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                                child: ReusableText(
                                  text: "${items.data?.description}",
                                  style: appstyle(
                                      14, Color(0xffF6F0F0), FontWeight.w600),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_city,
                                          color: Color(0xffA855F7),
                                        ),
                                        ReusableText(
                                          text: "${items.data?.location}",
                                          style: appstyle(14, Color(0xffF6F0F0),
                                              FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          MdiIcons.genderTransgender,
                                          color: Color(0xffA855F7),
                                        ),
                                        ReusableText(
                                          text: "${items.data?.gender}",
                                          style: appstyle(14, Color(0xffF6F0F0),
                                              FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              //end of basic profiles
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 120,
                                      width: width * 0.3,
                                      child: Card(
                                        color: Color(0xff292929),
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: ReusableText(
                                                text:
                                                    "${items.data?.totalApprovedElement}",
                                                style: appstyle(
                                                    24,
                                                    Color(0xffF6F0F0),
                                                    FontWeight.w800),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: ReusableText(
                                                text: "Approved elements",
                                                style: appstyle(
                                                    16,
                                                    Color(0xffF6F0F0),
                                                    FontWeight.w800),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 120,
                                      width: width * 0.3,
                                      child: Card(
                                        color: Color(0xff292929),
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: ReusableText(
                                                text:
                                                    "${items.data?.totalFollower}",
                                                style: appstyle(
                                                    24,
                                                    Color(0xffF6F0F0),
                                                    FontWeight.w800),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: ReusableText(
                                                text: "Followers ",
                                                style: appstyle(
                                                    16,
                                                    Color(0xffF6F0F0),
                                                    FontWeight.w800),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 120,
                                      width: width * 0.3,
                                      child: Card(
                                        color: Color(0xff292929),
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: ReusableText(
                                                text:
                                                    "${items.data?.totalFollowing}",
                                                style: appstyle(
                                                    24,
                                                    Color(0xffF6F0F0),
                                                    FontWeight.w800),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: ReusableText(
                                                text: "Followings",
                                                style: appstyle(
                                                    16,
                                                    Color(0xffF6F0F0),
                                                    FontWeight.w800),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // start elements owned but will move it to another futurebuilder for viewing because im suck at this and people in my team are ds
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: width * 0.8,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            12, 12, 0, 0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Get.to(() =>
                                                const ViewOthersApprovedElements());
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 8),
                                            backgroundColor: Colors.grey,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(MdiIcons.check),
                                              Container(
                                                width: width * 0.55,
                                                child: Text(
                                                  "View this creator's approved element ",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Color(kLight.value),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    //   width: width * 0.8,
                                    //   child: Align(
                                    //     alignment: Alignment.center,
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.fromLTRB(
                                    //           12, 0, 0, 0),
                                    //       child: ElevatedButton(
                                    //         onPressed: () {
                                    //           Get.to(() =>
                                    //               const ViewOthersDraftElementsGuest());
                                    //         },
                                    //         style: ElevatedButton.styleFrom(
                                    //           padding:
                                    //               const EdgeInsets.symmetric(
                                    //                   horizontal: 8,
                                    //                   vertical: 8),
                                    //           backgroundColor: Colors.grey,
                                    //           shape: RoundedRectangleBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(8),
                                    //           ),
                                    //         ),
                                    //         child: Row(
                                    //           children: [
                                    //             Icon(
                                    //               MdiIcons.folder,
                                    //               color: Colors.blue,
                                    //             ),
                                    //             Text(
                                    //               "View this creator's draft element ",
                                    //               style: TextStyle(
                                    //                 fontSize: 14,
                                    //                 color: Color(kLight.value),
                                    //                 fontWeight: FontWeight.w400,
                                    //               ),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ]),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    ));
  }
}

class MyDialog1 extends StatefulWidget {
  final String accountNametoReport;

  MyDialog1({required this.accountNametoReport});
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

  String selectedValue = "Choose your reason";
  late String accountNametoReport1;
  TextEditingController reason = TextEditingController();
  @override
  void initState() {
    super.initState();
    accountNametoReport1 = widget.accountNametoReport;
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text("Report Account $accountNametoReport1"),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                DropdownButton<String>(
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value!;
                    });
                  },
                  items: <String>[
                    "Choose your reason",
                    "Spam or phising",
                    "Impersonation",
                    "Bullying",
                    "Hate speech",
                    "Other",
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                TextField(
                  controller: reason,
                  decoration: InputDecoration(
                    hintText: "Enter your reason",
                    border: OutlineInputBorder(),
                  ),
                ),
                Row(
                  children: [
                    // ElevatedButton(
                    //   onPressed: selectImage,
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors
                    //         .transparent, // Set the button background color to transparent
                    //     shadowColor:
                    //         Color(0xff292929), // Set the shadow color to grey
                    //     elevation:
                    //         2, // Set the elevation to create a shadow effect
                    //     padding: EdgeInsets.all(4),
                    //   ),
                    //   child: _image != null
                    //       ? CircleAvatar(
                    //           radius: 32,
                    //           backgroundImage: MemoryImage(_image!),
                    //         )
                    //       : CircleAvatar(
                    //           radius: 32,
                    //           backgroundImage: AssetImage(
                    //               "assets/images/element_lambda_icon.png"),
                    //         ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                    //   child: ReusableText(
                    //       text: "Upload Image\n(optional)",
                    //       style:
                    //           appstyle(14, Color(0xffab55f7), FontWeight.w400)),
                    // )
                  ],
                ),
                ElevatedButton(
                    onPressed: () async {
                      int reasonId = 0;
                      if (selectedValue == "Spam or phising") {
                        reasonId = 1;
                      } else if (selectedValue == "Impersonation") {
                        reasonId = 2;
                      } else if (selectedValue == "Bullying") {
                        reasonId = 3;
                      } else if (selectedValue == "Hate speech") {
                        reasonId = 4;
                      } else if (selectedValue == "other") {
                        reasonId = 5;
                      }
                      SendReportForAccountsWithoutImages model =
                          SendReportForAccountsWithoutImages(
                              reportContent: reason.text);
                      print(model.toJson());
                      ReportService reportService = ReportService();
                      reportService.sendAccountReportsWithoutImage(
                          model, reasonId);
                      Navigator.pop(context);
                      // if (_image != null &&
                      //     reason.text != null &&
                      //     selectedValue != "Choose your reason") {
                      //   var uuid = Uuid();
                      //   String imageToUpload = await StoreData()
                      //       .uploadImageToStorage("${uuid.v4()}.png", _image!);
                      //   ReportImages image =
                      //       ReportImages(imageUrl: imageToUpload);
                      //   List<ReportImages> imagesList = [image];
                      //   SendReportForElements model = SendReportForElements(
                      //     reportContent: reason.text,
                      //     reportImages: imagesList,
                      //   );
                      //   print("vietnam + ${model.toJson()}");
                      //   ReportService reportService = ReportService();

                      //   // FocusScope.of(context).unfocus();
                      //   reportService.sendElementReportsWithImage(
                      //       model, reasonId);
                      //   Navigator.pop(context);
                      // } else if (_image == null &&
                      //     reason.text != null &&
                      //     selectedValue != "Choose your reason") {
                      //   SendReportForElementsWithoutImages model =
                      //       SendReportForElementsWithoutImages(
                      //     reportContent: reason.text,
                      //   );
                      //   print("vietnamkhongcohinh + ${model.toJson()}");
                      //   ReportService reportService = ReportService();
                      //   reportService.sendElementReportsWithoutImage(
                      //       model, reasonId);
                      //   Navigator.pop(context);
                      // }
                    },
                    child: Text("Submit")),
              ],
            ),
          ),
        );
      },
    );
  }
}
