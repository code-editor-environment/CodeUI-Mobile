import 'dart:convert';

class LoginByGoogleModel {
  final String idToken;

  LoginByGoogleModel({required this.idToken});

  factory LoginByGoogleModel.fromJson(Map<String, dynamic> json) {
    return LoginByGoogleModel(idToken: json['idToken']);
  }

  Map<String, dynamic> toJson() {
    return {'idToken': idToken};
  }
}
