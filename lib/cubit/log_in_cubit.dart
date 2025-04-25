import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void login(String email, String password) async {
    emit(LoginLoading()); 

    await Future.delayed(const Duration(seconds: 2)); 

    if (email.trim() == 'test@example.com' && password.trim() == '123456') {
      emit(LoginSuccess());
    } else {
      emit(LoginFailure('Invalid email or password'));
    }
  }
}


abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {} 


class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure(this.message);
}
