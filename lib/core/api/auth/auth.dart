import 'package:dio/dio.dart';
import 'package:grad_app/core/api/api.dart';

class AuthApi extends API {
  Future<Response> login(String email, String password) async {
      const  String url = "http//localhost:8000 ";
      final Map<String, dynamic> body = {'email': email, 'password': password};
      final Response response = await post(url, body: body);
      return response;
}
}
