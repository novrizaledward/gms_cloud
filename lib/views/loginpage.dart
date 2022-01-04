// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gms_cloud/core/bloc/login_bloc/login_bloc.dart';
import 'package:gms_cloud/repository/request/modelLoginRequest.dart';
import 'package:gms_cloud/views/homepage.dart';
import 'package:gms_cloud/widget/widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController ctrlUsername = TextEditingController();
    TextEditingController ctrlPassword = TextEditingController();
    LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset('assets/png/logo.png'),
              ),
              Text(
                "DRIVER MOBILE",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xff9B9B9B)),
              ),
              Text(
                "by PT.Golden Island Group",
                style: TextStyle(color: Color(0xff9B9B9B)),
              ),
              SizedBox(height: 20),
              GmsTextField(
                controller: ctrlUsername,
                hintText: 'Username',
                suffixIcon: Icons.people,
                width: 250,
              ),
              GmsTextField(
                controller: ctrlPassword,
                hintText: 'Password',
                suffixIcon: Icons.lock,
                width: 250,
              ),
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginError) {
                    Fluttertoast.showToast(msg: "Login Gagal");
                  }
                  if (state is LoginSucces) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                  nama: state.loginRespone!.data.nama,
                                )));
                  }
                },
                child: BlocBuilder<LoginBloc, LoginState>(
                  bloc: loginBloc,
                  builder: (context, state) {
                    if (state is LoginWaiting) {
                      return ElevatedButton(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        onPressed: null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xff029C40),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(horizontal: 35)),
                        ),
                      );
                    }
                    if (state is LoginError) {
                      return _buttonLogin(
                          loginBloc, ctrlUsername, ctrlPassword);
                    }
                    if (state is LoginWaiting) {
                      return _buttonLogin(
                          loginBloc, ctrlUsername, ctrlPassword);
                    }
                    return _buttonLogin(loginBloc, ctrlUsername, ctrlPassword);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton _buttonLogin(LoginBloc loginBloc,
      TextEditingController ctrlUsername, TextEditingController ctrlPassword) {
    LoginRequest reqLogin;

    return ElevatedButton(
      onPressed: () => {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => HomePage()))
        // LoginRequest reqLogin;
        reqLogin = LoginRequest(
            username: ctrlUsername.text, password: ctrlPassword.text),
        loginBloc.add(LoginAksi(reqLogin)),
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          const Color(0xff029C40),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
        padding:
            MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 35)),
      ),
      child: const Text("Masuk"),
    );
  }
}
