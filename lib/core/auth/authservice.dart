
import 'package:grad_app/core/auth/auth.dart';

class AuthService {
  static late final AuthService instance;
  final AuthApi authApi;

  AuthService._({required this.authApi});

  static Future<void> init() async {
    instance = AuthService._(authApi: AuthApi());
  }
}