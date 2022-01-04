// ignore_for_file: file_names,, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gms_cloud/core/utils/sharedpref.dart';
import 'package:gms_cloud/views/homepage.dart';
import 'package:gms_cloud/views/loginpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 2)).then((value) async {
        bool isLogin = await StorageManager.isLogin;
        var data = await StorageManager.getLoginModel();
        if (isLogin) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                        nama: data?.nama,
                      )));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        }
      });
      // print(StorageManager.getLoginModel());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff029C40)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
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
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
