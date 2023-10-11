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
        textStyle: MaterialStatePropertyAll(TextStyle(
          color: Colors.white,
        )),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey; // Disabled color
            }
            return Color(0xffA855F7); // Enabled color
          },
        ),
      ),
      child: Text(text),
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Disable-able Text Button'),
        ),
        body: Center(
          child: DisableableTextButton(
            text: 'Click Me',
            onPressed: () {
              // Handle button click
              print('Button Clicked');
            },
          ),
        ),
      ),
    );
  }
}
