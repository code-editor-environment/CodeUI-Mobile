import 'package:flutter/material.dart';

import 'app_constants.dart';
import 'app_style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.keyboardType,
    this.validator,
    this.suffixIcon,
    this.obscureText,
    required this.heightBox,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool? obscureText;
  final double heightBox;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //  double height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.9,
      height: heightBox,
      color: Color(0xff292929),
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(10), // Set the border radius here
            borderSide: BorderSide(color: Color(kLightBlue.value), width: 0.5),
          ),
        ),
        controller: controller,
        cursorHeight: 20,
        style: appstyle(16, Color(0xffF6F0F0), FontWeight.w500),
        validator: validator,
        maxLines: 1,
        // onChanged: (text) {
        //   print('First text field: $text (${text.characters.length})');
        // },
      ),
    );
  }
}