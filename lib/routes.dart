import 'package:absensi_prodi/src/checkout/pages/checkout_page_new_rakanggo.dart';
import 'package:absensi_prodi/src/checkout/pages/daily_info_page.dart';
import 'package:absensi_prodi/src/checkout/pages/new_checkout_page.dart';
import 'package:absensi_prodi/src/login/pages/login_page.dart';
import 'package:absensi_prodi/src/main/pages/main_page.dart';
import 'package:absensi_prodi/src/profile/pages/edit_profile_page.dart';
import 'package:absensi_prodi/src/register/pages/register_page.dart';
import 'package:absensi_prodi/src/splash/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Routing {
  static Map<String, WidgetBuilder> getRoute(){
    return <String, WidgetBuilder>{
      '/':  (_) => SplashPage(),
      // 'login_page':(_) => LoginPage(),
      // 'register_page' :(_) => RegisterPage(),
      // 'main_page': (_) => MainPage(currentTab: settings.arguments),
      // 'checkout_page':(_) => CheckoutPage(),
      // 'edit_profile_page': (_) => EditProfilePage()
    };
  }

  static Route onGenerateRoute(RouteSettings settings){

    switch(settings.name){

        case "login_page" :
          return PageTransition(child: LoginPage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;
        case "register_page" :
          return PageTransition(child: RegisterPage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;
        case 'main_page' :
          return PageTransition(child: MainPage(currentTab: settings.arguments), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;
        case 'checkout_page' :
          return PageTransition(child: NewCheckoutPage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;
        case 'edit_profile_page' :
          return PageTransition(child: EditProfilePage(), type: PageTransitionType.fade, duration: Duration(milliseconds: 350));
        break;



    }
    //
    // final List<String> pathElements = settings.name.split('/');
    // if(pathElements[0] != '' || pathElements.length == 1){
    //   return null;
    // }


  }
}