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
import 'package:webview_flutter/webview_flutter.dart';
import '../../common/models/response/functionals/create_sandbox_payment_test.dart';
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
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PaymentWidget extends StatefulWidget {
   final String url;
  const PaymentWidget({super.key, required this.url});

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

final MyInAppBrowser browser = new MyInAppBrowser();
var options = InAppBrowserClassOptions(
    crossPlatform: InAppBrowserOptions(hideUrlBar: false),
    inAppWebViewGroupOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(javaScriptEnabled: true)));

class MyInAppBrowser extends InAppBrowser {
  @override
  Future onBrowserCreated() async {
    print("Browser Created!");
  }

  @override
  Future onLoadStart(url) async {
    print("Started $url");
  }

  @override
  Future onLoadStop(url) async {
    print("Stopped $url");
  }

  @override
  void onLoadError(url, code, message) {
    print("Can't load $url.. Error: $message");
  }

  @override
  void onProgressChanged(progress) {
    print("Progress: $progress");
  }

  @override
  void onExit() {
    print("Browser closed!");
  }
}

class _PaymentWidgetState extends State<PaymentWidget> {

  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var url1 = prefs.getString("urltoPay");
      print("url:$url1");

    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      //  extendBodyBehindAppBar: true,
      appBar: CustomLoggedInUserAppBar(),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: 2500,
          width: width,
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            children: [
              SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    width: 320,
                    height: 1200,
                    child: Card(
                      child: InAppWebView(
                        key: webViewKey,
                        initialUrlRequest: URLRequest(url: Uri.parse("${widget.url}")),
                        initialOptions: options,
                        //    pullToRefreshController: pullToRefreshController,
                        onWebViewCreated: (controller) {
                          webViewController = controller;
                        },
                        // onLoadStart: (controller, url) {
                        //   setState(() {
                        //     this.url = url.toString();
                        //     urlController.text = this.url;
                        //   });
                        // },
                        androidOnPermissionRequest:
                            (controller, origin, resources) async {
                          return PermissionRequestResponse(
                              resources: resources,
                              action: PermissionRequestResponseAction.GRANT);
                        },
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
