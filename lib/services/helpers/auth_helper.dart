import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as https;
import 'package:mobile/constants/app_constants.dart';
import 'package:mobile/view/widget/home_page_user_logged_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/request/auth/login_model.dart';
import '../../models/response/auth/login_res_model.dart';

class AuthHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [],
  );

  static var client = https.Client();

  ///Google sign in
  Future<String?> handleSignin() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        //  print(googleAuth.accessToken);
        await Future.delayed(Duration(seconds: 3), () {
          //        print(googleAuth.idToken);
        });
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
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
        // if (_auth.currentUser != null) {
        //   final IdTokenResult? idTokenResult =
        //       await _auth.currentUser?.getIdTokenResult();
        //   print(idTokenResult?.token);
        // }
        if (token != null) {
          login(LoginByGoogleModel(idToken: token));
        }
      }
    } catch (e) {
      print("Error signing in with google $e");
    }
    ;
    return null;
  }

  //login to system
  //
  static Future<bool> login(LoginByGoogleModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.parse("http://13.212.54.225:44360/api/account/loginByMail");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );
    if (response.statusCode == 200) {
      jsonDecode(response.body);
      //   Get.off(() => const CodeUIHomeScreenForLoggedInUser());
      handleLoginResponse(
          LoginResponseModel.fromJson(jsonDecode(response.body)));

      // final accessToken = response.data.accessToken;
      // await prefs.setString("userId", userId);
      // await prefs.setBool("loggedIn", true);
      return true;
    } else {
      Get.snackbar("Sign failed", "Please check your credentials",
          colorText: Color(kLight.value),
          backgroundColor: Colors.red,
          icon: Icon(Icons.add_alert));
      return false;
    }
  }

  static Future<void> handleLoginResponse(LoginResponseModel response) async {
    // Get the access token from the response.
    final accessToken = response.data?.accessToken;
    final accountId = response.data!.account?.id;
    // Save the access token to SharedPreferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("accessToken", accessToken!);
    await prefs.setString("accountId", accountId!);
    print(accessToken);
    print(accountId);
    // Navigate to the next screen.
    Get.off(() => const CodeUIHomeScreenForLoggedInUser());
  }
  // static Future<bool> register(SignupModel model) async {
  //   Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
  //   var url = Uri.parse("https://exe201.onrender.com/api/register");
  //   var response = await client.post(
  //     url,
  //     headers: requestHeaders,
  //     body: jsonEncode(model),
  //   );
  //   if (response.statusCode == 201) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}