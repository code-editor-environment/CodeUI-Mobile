import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as https;

class VNPayView extends StatefulWidget {
  const VNPayView({
    required this.paymentUrl,
    super.key,
    this.onPaymentSuccess,
    this.onPaymentError,
  });
  final String paymentUrl;
  final void Function(Map<String, dynamic> value)? onPaymentSuccess;
  final void Function(Map<String, dynamic> error)? onPaymentError;

  @override
  State<VNPayView> createState() => VNPayViewState();
}

class VNPayViewState extends State<VNPayView> {
  final WebViewController controller = WebViewController();

  @override
  void initState() {
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) async {
            if (url.contains('vnp_ResponseCode')) {
              final params = Uri.parse(url).queryParameters;
              if (params['vnp_ResponseCode'] == '00') {
                // Perform the POST request here
                try {
                  var apiUrl =
                      'https://dev.codeui-api.io.vn/api/payment/confirmPayment';
                  var response = await https.post(
                    Uri.parse(apiUrl),
                    body: params, // Use the received parameters as the body
                  );
                     
                  if (response.statusCode == 200) {
                    print('POST request payment successful!');

                    print('Response: ${response.body}');
                    // Handle the success scenario here
                  } else {
                    print(
                        'POST request failed with status: ${response.statusCode}');
                    // Handle the error scenario here
                  }
                } catch (error) {
                  print('Error during POST request: $error');
                  // Handle the error scenario here
                }

                // Call the appropriate callback based on the response
                widget.onPaymentSuccess?.call(params);
              } else {
                widget.onPaymentError?.call(params);
              }
              Navigator.of(context).pop();
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}
