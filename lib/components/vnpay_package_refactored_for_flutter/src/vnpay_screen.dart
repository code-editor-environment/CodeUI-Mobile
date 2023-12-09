import 'package:flutter/material.dart';
import 'package:mobile/components/vnpay_package_refactored_for_flutter/src/vnpay_view.dart';

class VNPayScreen extends StatelessWidget {
  const VNPayScreen({
    required this.paymentUrl,
    super.key,
    this.onPaymentSuccess,
    this.onPaymentError,
  });
  final String paymentUrl;
  final void Function(Map<String, dynamic> value)? onPaymentSuccess;
  final void Function(Map<String, dynamic> error)? onPaymentError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VNPayView(
        paymentUrl: paymentUrl,
        onPaymentSuccess: onPaymentSuccess,
        onPaymentError: onPaymentError,
        key: key,
      ),
    );
  }
}

Future<void> showVNPayScreen(
  BuildContext context, {
  required String paymentUrl,
  void Function(Map<String, dynamic> data)? onPaymentSuccess,
  void Function(Map<String, dynamic> error)? onPaymentError,
  GlobalKey<VNPayViewState>? key,
}) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => VNPayScreen(
        paymentUrl: paymentUrl,
        onPaymentSuccess: onPaymentSuccess,
        onPaymentError: onPaymentError,
      ),
    ),
  );
}
