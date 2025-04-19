import 'package:grad_app/core/api/auth/auth.dart';

class AuthService {
  static late final AuthService instance;
   final AuthApi authApi;
  static Future<void> init() async {
    instance = AuthService( authApi: AuthApi());
  }
}
