part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginAksi extends LoginEvent {
  final LoginRequest loginRequest;

  LoginAksi(this.loginRequest);
}
