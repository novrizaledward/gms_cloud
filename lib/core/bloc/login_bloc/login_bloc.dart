import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gms_cloud/core/utils/sharedpref.dart';
import 'package:gms_cloud/repository/endpoint.dart';
import 'package:gms_cloud/repository/request/modelLoginRequest.dart';
import 'package:gms_cloud/repository/respone/modelLoginRespone.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiProvider apiProvider;
  LoginBloc(this.apiProvider) : super(LoginInitial()) {
    on<LoginAksi>((event, emit) async {
      emit(LoginWaiting("waitingMsg"));
      final data = await apiProvider.login(event.loginRequest);
      if (data?.status == true) {
        await StorageManager.setLoginModel(data?.data);
        emit(LoginSucces(data));
      } else if (data?.status == null) {
        emit(LoginError('login gagal'));
      } else {
        emit(LoginWaiting("waitingMsg"));
      }
    });
  }
}

// _loginState(LoginRequest request) async {
//   ApiProvider apiProvider = ApiProvider();

//   final data = await apiProvider.login(request);
//   print(data);
//   // await StorageManager.setLoginModel(data.toJson());
//   return LoginSucces(data);
// }
