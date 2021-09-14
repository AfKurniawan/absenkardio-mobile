import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BerandaProvider extends ChangeNotifier {

  checkoutAction(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isCheckin');
    showSuccess(context);

  }

  logoutAction(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context).pushReplacementNamed("/");
  }

  void showSuccess(BuildContext context) {
    AchievementView(
      context,
      title: "Terima kasih",
      subTitle: "Anda sudah checkout hari ini   ",
      isCircle: true,
      alignment: Alignment.bottomCenter,
      duration: Duration(milliseconds: 2000),
      icon: Icon(Icons.assignment_turned_in, color: Colors.white),
      listener: (status) {
        //if(status == ach)
        print(status);
        if (status == AchievementState.closing) {
          Navigator.of(context).pushReplacementNamed("main_page", arguments: 0);
        }
      },
    )..show();
  }
}