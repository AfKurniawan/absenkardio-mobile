import 'package:absensi_prodi/src/login/pages/login_page.dart';
import 'package:absensi_prodi/src/main/pages/main_page.dart';
import 'package:absensi_prodi/src/register/pages/register_page.dart';
import 'package:absensi_prodi/src/splash/pages/splash_page.dart';
import 'package:flutter/material.dart';

class MyRoute {
  static Map<String, WidgetBuilder> getRoute(){
    return <String, WidgetBuilder>{
      '/':  (_) => SplashPage(),
      'login_page':(_) => LoginPage(),
      'register_page' :(_) => RegisterPage(),
      'main_page': (_) => MainPage()
    };
  }

  static Route onGenerateRoute(RouteSettings settings){
    final List<String> pathElements = settings.name.split('/');
    if(pathElements[0] != '' || pathElements.length == 1){
      return null;
    }


  }
}