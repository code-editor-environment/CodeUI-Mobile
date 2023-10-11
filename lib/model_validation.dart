import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/services/helpers/auth_helper.dart';
import 'constants/app_constants.dart';
import 'models/request/auth/login_model.dart';
import 'view/widget/home_page_user_logged_in.dart';

class ValidateNotifier extends ChangeNotifier {
  bool _obscureText = true;
  bool get obscureText => _obscureText;
  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool _firstTime = true;
  bool get firstTime => _firstTime;
  set firstTime(bool newState) {
    _firstTime = newState;
    notifyListeners();
  }

  bool? _entryPoint;
  bool get entryPoint => _entryPoint ?? false;

  set entryPoint(bool newState) {
    _entryPoint = newState;
    notifyListeners();
  }

  bool? _loggedIn;
  bool get loggedIn => _loggedIn ?? false;

  set loggedIn(bool newState) {
    _loggedIn = newState;
    notifyListeners();
  }

  // getPrefs() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   entryPoint = prefs.getBool('entryPoint') ?? false;
  // }

  bool validateAndSave() {
    final form = GlobalKey<FormState>().currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  // logout() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('loggedIn', false);
  //   _firstTime = false;
  // }

  bool passwordValidator(String password) {
    if (password.isEmpty) return false;
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  userLogin(LoginByGoogleModel model) {
    AuthHelper.login(model).then((response) {
      if (response && !firstTime) {
        Get.off(() => const CodeUIHomeScreenForLoggedInUser());
      } else if (response && firstTime) {
        Get.off(() => const CodeUIHomeScreenForLoggedInUser());
      } else if (!response) {
        Get.snackbar("Sign failed", "Please check your credentials",
            colorText: Color(kLight.value),
            backgroundColor: Colors.red,
            icon: Icon(Icons.add_alert));
      }
    });
  }
  
}
