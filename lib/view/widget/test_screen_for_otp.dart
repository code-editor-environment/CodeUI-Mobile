import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile/view/widget/login_page.dart';

import '../../common/models/request/auth/login_model.dart';
import '../../services/helpers/auth_helper.dart';

void main() {
  runApp(OTPApp());
}

class OTPApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OTP Input',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: OTPScreen(),
    );
  }
}

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  Future<void> validateAndSubmit() async {
    if (_formKey.currentState!.validate()) {
      FirebaseAuth auth = FirebaseAuth.instance;

      // TODO: Implement your logic for validating the OTP here.
      String enteredOTP = otpController.text;
      print('Entered OTP: $enteredOTP');
      String smsCode = enteredOTP;

      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: LoginWidget.verify, smsCode: smsCode);

      // Sign the user in (or link) with the credential
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      String? token = await user?.getIdToken();
      // Flutter gioi han 1024 ky tu khi print chu tokenprint  nay bt :))
      var tokentoPrint = token;
      print(token);
      if (tokentoPrint!.length > 0) {
        int initLength =
            (tokentoPrint.length >= 500 ? 500 : tokentoPrint.length);
        print(tokentoPrint.substring(0, initLength));
        int endLength = tokentoPrint.length;
        tokentoPrint = tokentoPrint.substring(initLength, endLength);
      }
      print("Token : $tokentoPrint ");

      if (token != null) {
        AuthHelper.login(LoginByGoogleModel(idToken: token));
      }
      // Add your logic here to verify the OTP
      // For demo purposes, printing the OTP to the console
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter OTP'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Enter OTP',
                  hintText: 'Enter 6-digit OTP',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter OTP';
                  } else if (value.length != 6) {
                    return 'OTP must be 6 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: validateAndSubmit,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
