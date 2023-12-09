import 'package:flutter/material.dart';

import 'vnpay_view.dart';

class VNPayWidget extends StatelessWidget {
  const VNPayWidget({
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
    return SizedBox(
      child: VNPayView(
        paymentUrl: paymentUrl,
        onPaymentSuccess: onPaymentSuccess,
        onPaymentError: onPaymentError,
        key: key,
      ),
    );
  }
}
