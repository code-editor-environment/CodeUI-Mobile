import 'package:flutter/material.dart';

class DisableableTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const DisableableTextButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey; // Disabled color
            }
            return Color(0xffA855F7); // Enabled color
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.black; // Disabled color
            }
            return Colors.white; // Enabled color
          },
        ),
      ),
      child: Text(text),
    );
  }
}
