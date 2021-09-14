import 'dart:async';
import 'package:absensi_prodi/animation/fade_animation.dart';
import 'package:absensi_prodi/src/styles/light_color.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();

}

class _SplashPageState extends State<SplashPage>{

  bool isLogin ;
  SharedPreferences prefs;


  @override
  void initState() {
    getPrefs();
    super.initState();
  }

  getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogin = prefs.getBool("isLogin");
      print("ISLOGIN IN SPLASHPAGE $isLogin");
    });
    if(isLogin == true){
      Navigator.pushReplacementNamed(context, "main_page");
    } else {
      startTime();
    }
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacementNamed(context, 'login_page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FadeAnimation(
                  2.0,
                  Container(
                      height: 150,
                      child: Image.asset(
                          'assets/icons/logo.png')),
                ),
                SizedBox(height: 30),
                FadeAnimation(
                  2.2,
                  Text("Welcome",
                    style: TextStyle(
                        color: LightColor.purple, fontSize: 28),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}