import 'package:dio/dio.dart';
import 'package:grad_app/core/api/api.dart';

class AuthApi extends API {
  Future<Response> login(String email, String password) async {
    const url = "/auth/login";
    final body = {"email": email, "password": password};
    return await post(url, body: body);
  }
}