import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile/common/models/response/functionals/create_request_without_image.dart';
import 'package:mobile/components/app_bar_guest.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/services/helpers/element_helper.dart';
import 'package:mobile/view/widget/login_page.dart';
import 'package:mobile/view/widget/payment_widget.dart';
import 'package:mobile/view/widget/profile_page.dart';
import 'package:mobile/view/widget/publicly_request_widget_details.dart';
import 'package:mobile/view/widget/responsive_chat_page.dart';
import 'package:mobile/view/widget/save_favourite.dart';
import 'package:mobile/view/widget/search_page.dart';
import 'package:mobile/view/widget/view_specific_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../common/models/request/functional/send_reports_for_elements_without_images.dart';
import '../../common/models/response/functionals/create_sandbox_payment_test.dart';
import '../../common/models/response/functionals/get_all_requests_to_show.dart';
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
import '../../services/helpers/report_helper.dart';
import 'add_image_data.dart';
import 'chat_front_page.dart';
import 'image_utils.dart';
import 'owned_request_widget.dart';

class RequestWidget extends StatefulWidget {
  const RequestWidget({super.key});

  @override
  State<RequestWidget> createState() => _RequestWidgetState();
}

class _RequestWidgetState extends State<RequestWidget> {
  Future<RequestToShowToUser> _getData() async {
    try {
      final items = await GetElementService().getAllRequests();
      return items;
    } catch (e) {
      throw e;
    }
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
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomLoggedInUserAppBar(),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(indicatorColor: Colors.black),
        child: NavigationBar(
          height: 50,
          backgroundColor: Color(0xff181818),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          indicatorColor: Color(0xff292929),
          selectedIndex: 4,
          indicatorShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          // onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: [
            NavigationDestination(
                icon: Icon(
                  Icons.home_outlined,
                  color: Color(0xffEC4899).withOpacity(0.4),
                ),
                label: ""),
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
                  color: Color(0xffEC4899),
                  onPressed: () {
                    //   Get.to(RequestWidget());
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
          width: width,
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                          text: "Request",
                          style:
                              appstyle(16, Color(0xffEC4899), FontWeight.w600)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                    child: PopupMenuButton<String>(
                      onSelected: (value) {
                        // Handle the selected value here
                        if (value == 'settings1') {
                          Get.to(OwnedRequestWidget());
                          // Perform the action for the settings option
                        } else if (value == 'settings2') {
                          showDialog(
                            context: context,
                            builder: (context) => MyDialog(),
                          );
                          // Perform the action for the settings option
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'settings1',
                          child: Row(
                            children: [
                              Icon(Icons.account_circle_outlined,
                                  color: Color(0xffEC4899)),
                              Text(' My request'),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'settings2',
                          child: Row(
                            children: [
                              Icon(MdiIcons.accountPlusOutline,
                                  color: Color(0xffEC4899)),
                              Text('Create request'),
                            ],
                          ),
                        ),
                      ],
                      child: Icon(
                        Icons.settings,
                        color: Color(0xffEC4899),
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),

              /// content
              Expanded(
                flex: 1,
                child: FutureBuilder(
                  future: _getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error loading data'));
                    } else if (!snapshot.hasData) {
                      return Center(child: Text('No data available'));
                    } else {
                      var items = snapshot.data;
                      return  SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          height: height * 0.65,
                          child: ListView.builder(
                            itemCount: items!.metadata!.total,
                            itemBuilder: (context, index) {
                              return  Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 4, 0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    var idRequestToBeSeen =
                                        items.data![index].id;
                                    print("IdRequest:$idRequestToBeSeen");
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setInt("idRequestToBeSeen",
                                        idRequestToBeSeen!);
                                    Get.to(PubliclyRequestWidget());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .transparent, // Set the button background color to transparent
                                    elevation: 0, // Remove the button shadow
                                    padding: EdgeInsets
                                        .zero, // Remove default button padding
                                    // Reduce the button's tap target size
                                  ),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          12), // Adjust the border radius as needed
                                    ),
                                    color: Color.fromARGB(105, 106, 106, 114),
                                    child: SizedBox(
                                      width: 340,
                                      height: 150,
                                      child: Column(children: [
                                        ListTile(
                                          leading: Image.network(
                                            "${items.data![index].avatar}",
                                            cacheHeight: 48,
                                            cacheWidth: 48,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              // Handle the error and return a placeholder image or error message widget
                                              return Icon(
                                                Icons.close,
                                                color: Colors.red,
                                                size: 48.0,
                                              );
                                            },
                                          ),
                                          title: Container(
                                            width: width * 0.75,
                                            child: Text(
                                              '${items.data![index].name}',
                                              style: appstyle(
                                                  14,
                                                  Color(0xffEC4899),
                                                  FontWeight.w600),
                                            ),
                                          ),
                                          subtitle: Text(
                                            '${items.data![index].requestDescription}',
                                            style: appstyle(
                                                12,
                                                Color(0xffab55f7),
                                                FontWeight.w400),
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Status: ${items.data![index].status}',
                                              style: appstyle(
                                                  14,
                                                  Color(0xfff0f0f0),
                                                  FontWeight.w600),
                                            )),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '${DateFormat('dd/MM/yyyy').format(DateTime.parse(items.data![index].startDate!))}',
                                              style: appstyle(
                                                  14,
                                                  Color.fromARGB(
                                                      255, 240, 240, 240),
                                                  FontWeight.w600),
                                            ),
                                            Text(
                                              'Reward:${items.data![index].reward!.toStringAsFixed(0)}',
                                              style: appstyle(
                                                  14,
                                                  Color(0xffEC4899),
                                                  FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  Uint8List? _image;
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  String selectedValue = "Button";
  String selectedValue1 = "Mixed";
  TextEditingController categoryName = TextEditingController();
  TextEditingController reward = TextEditingController();
  TextEditingController requestName = TextEditingController();
  TextEditingController deadline = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(105, 106, 106, 114),
          title: Text("Create Request",
              style: appstyle(18, Color(0xfff0f0f0), FontWeight.w500)),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                    text: "Category name",
                    style: appstyle(14, Color(0xfff0f0f0), FontWeight.w500)),
                DropdownButton<String>(
                  dropdownColor: Colors.grey,
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value!;
                    });
                  },
                  items: <String>[
                    "Button",
                    "Card",
                    "Checkbox",
                    "Input",
                    "Loaders",
                    "Toggle switch",
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style:
                              appstyle(14, Color(0xfff0f0f0), FontWeight.w500)),
                    );
                  }).toList(),
                ),
                ReusableText(
                    text: "Reward",
                    style: appstyle(14, Color(0xfff0f0f0), FontWeight.w500)),
                TextField(
                  style: appstyle(14, Color(0xfff0f0f0), FontWeight.w500),
                  controller: reward,
                  decoration: InputDecoration(
                    hintText: "Enter the price",
                    hintStyle: appstyle(14, Color(0xfff0f0f0), FontWeight.w500),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                ReusableText(
                    text: "Request name",
                    style: appstyle(14, Color(0xfff0f0f0), FontWeight.w500)),
                TextField(
                  style: appstyle(14, Color(0xfff0f0f0), FontWeight.w500),
                  controller: requestName,
                  decoration: InputDecoration(
                    hintText: "Enter the name of the request",
                    hintStyle: appstyle(14, Color(0xfff0f0f0), FontWeight.w500),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                ReusableText(
                    text: "Deadline",
                    style: appstyle(14, Color(0xfff0f0f0), FontWeight.w500)),
                TextField(
                  style: appstyle(14, Color(0xfff0f0f0), FontWeight.w500),
                  controller: deadline,
                  decoration: InputDecoration(
                    hintText: "Enter the deadline",
                    hintStyle: appstyle(14, Color(0xfff0f0f0), FontWeight.w500),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                ReusableText(
                    text: "Type of css",
                    style: appstyle(14, Color(0xfff0f0f0), FontWeight.w500)),
                DropdownButton<String>(
                  dropdownColor: Colors.grey,
                  value: selectedValue1,
                  onChanged: (value) {
                    setState(() {
                      selectedValue1 = value!;
                    });
                  },
                  items: <String>[
                    "Mixed",
                    "CSS",
                    "Tailwind CSS",
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style:
                              appstyle(14, Color(0xfff0f0f0), FontWeight.w500)),
                    );
                  }).toList(),
                ),
                ReusableText(
                    text: "Description",
                    style: appstyle(14, Color(0xfff0f0f0), FontWeight.w500)),
                TextField(
                  style: appstyle(14, Color(0xfff0f0f0), FontWeight.w500),
                  controller: description,
                  decoration: InputDecoration(
                    hintText: "Enter your description",
                    hintStyle: appstyle(14, Color(0xfff0f0f0), FontWeight.w500),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: selectImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors
                            .transparent, // Set the button background color to transparent
                        shadowColor:
                            Color(0xff292929), // Set the shadow color to grey
                        elevation:
                            2, // Set the elevation to create a shadow effect
                        padding: EdgeInsets.all(4),
                      ),
                      child: _image != null
                          ? CircleAvatar(
                              radius: 32,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : CircleAvatar(
                              radius: 32,
                              backgroundImage: AssetImage(
                                  "assets/images/element_lambda_icon.png"),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: ReusableText(
                          text: "Upload Image",
                          style:
                              appstyle(14, Color(0xffab55f7), FontWeight.w400)),
                    )
                  ],
                ),
                ElevatedButton(
                    onPressed: () async {
                      double? parsedReward = double.tryParse(reward.text);
                      int? parsedDeadline = int.tryParse(deadline.text);

                      if (_image != null &&
                          categoryName.text != null &&
                          parsedDeadline != null &&
                          requestName.text != null &&
                          description.text != null &&
                          parsedReward != null) {
                        var uuid = Uuid();
                        String imageToUpload = await StoreData()
                            .uploadImageToStorage("${uuid.v4()}.png", _image!);

                        // ReportImages image =
                        //     ReportImages(imageUrl: imageToUpload);
                        // List<ReportImages> imagesList = [image];
                        // SendReportForElements model = SendReportForElements(
                        //   reportContent: reason.text,
                        //   reportImages: imagesList,
                        // );

                        CreateRequestWithoutImage model =
                            CreateRequestWithoutImage(
                                avatar: imageToUpload,
                                categoryName: selectedValue,
                                deadline: parsedDeadline,
                                name: requestName.text,
                                requestDescription: description.text,
                                reward: parsedReward,
                                typeCss: selectedValue1);
                        print("14122023 + ${model.toJson()}");
                        GetElementService().createRequestWithoutImage(model);
                        // FocusScope.of(context).unfocus();
                        // reportService.sendElementReportsWithImage(
                        //     model, reasonId);
                        Navigator.pop(context);
                      } else if (_image == null && categoryName.text != null) {
                        // SendReportForElementsWithoutImages model =
                        //     SendReportForElementsWithoutImages(
                        //   reportContent: reason.text,
                        // );
                        // print("vietnamkhongcohinh + ${model.toJson()}");
                        // ReportService reportService = ReportService();
                        // reportService.sendElementReportsWithoutImage(
                        //     model, reasonId);
                        Navigator.pop(context);
                      }
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
