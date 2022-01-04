part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginWaiting extends LoginState {
  final String waitingMsg;

  LoginWaiting(this.waitingMsg);
}

class LoginError extends LoginState {
  final String errorMsg;

  LoginError(this.errorMsg);
}

class LoginSucces extends LoginState {
  final LoginRespone? loginRespone;

  LoginSucces(this.loginRespone);
}
