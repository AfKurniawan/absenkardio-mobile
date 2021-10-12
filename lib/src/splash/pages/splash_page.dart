import 'dart:async';
import 'package:absensi_prodi/animation/fade_animation.dart';
import 'package:absensi_prodi/src/splash/providers/splash_provider.dart';
import 'package:absensi_prodi/src/styles/light_color.dart';
import 'package:absensi_prodi/src/utilities/localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    context.read<SplashProvider>().getPrefs(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
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
                  Text(
                    "Aplikasi kehadiran\nPPDS Jantung dan Pembuluh Darah\nFakultas Kedokteran Universitas Sebelas Maret",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: LightColor.unsBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}