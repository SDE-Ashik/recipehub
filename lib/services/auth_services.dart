import 'package:flutter/material.dart';
import 'package:recepies_app/models/user_model.dart';
import 'package:recepies_app/services/http_service.dart';

class AuthService {
  static final AuthService _singleton = AuthService._internal();
  final _httpService = HTTPService();
  UserModel? user;

  factory AuthService() {
    return _singleton;
  }
  AuthService._internal();

  Future<bool> login(String username, String password) async {
    try {
      var response = await _httpService
          .post('auth/login', {"username": username, "password": password});
      print(response.toString());
      if (response?.statusCode == 200 && response?.data != null) {
        user = UserModel.fromJson(response!.data);
        HTTPService().setUp(bearerToken: user!.token);
        return true;
      }
    } catch (e) {
      print(e);
    }

    return false;
  }
}
