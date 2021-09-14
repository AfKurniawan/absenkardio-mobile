import 'package:absensi_prodi/src/beranda_page/pages/pulang_page.dart';
import 'package:absensi_prodi/src/checkin/pages/checkin_page.dart';
import 'package:absensi_prodi/src/login/providers/login_provider.dart';
import 'package:absensi_prodi/src/profile/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider extends ChangeNotifier {

  Widget currenPage = new CheckinPage();
  int currentTab;
  String currentTitle;

  void selectTab(BuildContext context, int tabItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isCheckin = prefs.getBool('isCheckin');
    currentTab = tabItem;


    switch (tabItem) {
      case 0 :
        currentTitle = isCheckin == true ? "Beranda" : "Check-In";
        currenPage = CheckinPage();
        break;


      case 1 :
        currentTitle = "Informasi";
        currenPage = ProfilePage();
        Provider.of<LoginProvider>(context, listen: false).getLoginState(context);
        break;
    }


  }


}