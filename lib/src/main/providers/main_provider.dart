
import 'package:absensi_prodi/src/checkin/pages/new_checkin_page.dart';
import 'package:absensi_prodi/src/login/providers/login_provider.dart';
import 'package:absensi_prodi/src/profile/pages/new_profile_page.dart';
import 'package:absensi_prodi/src/checkout/pages/daily_info_page.dart';
import 'package:absensi_prodi/src/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider extends ChangeNotifier {

  Widget currenPage = new NewCheckinPage();
   int currentTab;
   String currentTitle;

  void selectTab(BuildContext context, int tabItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isCheckin = prefs.getBool('isCheckin');
    currentTab = tabItem;


    switch (tabItem) {
      case 0 :
        currentTitle = "Beranda" ;
        currenPage = isCheckin == true ? DailyInfoPage() : NewCheckinPage();
        Provider.of<ProfileProvider>(context, listen: false).getUseData(context);
        break;

      case 1 :
        currentTitle = "Informasi";
        currenPage = NewProfilePage();
        Provider.of<ProfileProvider>(context, listen: false).getUseData(context);
        break;
    }


  }


}