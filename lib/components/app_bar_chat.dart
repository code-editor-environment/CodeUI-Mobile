import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/components/reusable_text.dart';
import 'package:mobile/components/reusable_text_long.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/constants/app_constants.dart';
import '../common/constants/app_style.dart';
import '../common/models/request/functional/send_reports_for_accounts_without_images.dart';
import '../common/models/response/functionals/view_profile_res_model.dart';
import '../services/helpers/profile_helper.dart';
import '../services/helpers/report_helper.dart';

class ChatAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ChatAppBar({Key? key}) : super(key: key);

  @override
  _ChatAppBarState createState() => _ChatAppBarState();

  @override
  Size get preferredSize => const Size(double.infinity, 60);
}

class _ChatAppBarState extends State<ChatAppBar> {
  String recieverId = "";
  Future<ViewSpecificProfileResponse> _getData() async {
    final items = await GetProfileService().getOneById(recieverId);
    return items;
  }

  late Future<ViewSpecificProfileResponse> _profileFuture;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("accessToken");
      var _currentLoggedInUsername =
          prefs.getString("currentLoggedInUsername")!;
      var accountIdToBeViewedInElements =
          prefs.getString("accountIdToBeViewed");
      var accountIdToViewNotifications = prefs.getString("accountId");
      var chatViewId1 = prefs.getString("chatViewId");
      var senderId1 = prefs.getString("senderId");
      var recieverId1 = prefs.getString("recieverId");
      print("ChatView Id:$chatViewId1");
      print("Sender Id:$senderId1");
      print("Reciever Id:$recieverId1");
      print(_currentLoggedInUsername);
      print("Notification check: $accountIdToViewNotifications");
      setState(() {
        recieverId = recieverId1!;
        _profileFuture = _getData();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black,
        child: Column(
          children: [
            Row(
              // row chứa các phần của app bar
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: const Color(0xFFAB55F7),
                  ),
                ),
                // Add more widgets as needed for your app bar
                FutureBuilder(
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
                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Color(0xff292929),
                            child: Card(
                              color: Color(0xff292929),
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Stack(
                                children: [
                                  Ink.image(
                                    image: NetworkImage(
                                        "${snapshot.data!.data!.imageUrl}"),
                                    height: 64,
                                    width: 64,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 24, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: width! * 0.5,
                                  child: ReusableText(
                                    text: "${snapshot.data!.data!.username}",
                                    style: appstyle(16, Color(kLight.value),
                                        FontWeight.w800),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            alignment: Alignment.topRight,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => MyDialog1(
                                  accountNametoReport:
                                      '${snapshot.data!.data!.username}',
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
                      );
                    }
                  },
                )
              ],
            ),
            // Add more children widgets for your app bar
          ],
        ),
      ),
    );
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
