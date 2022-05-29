import 'dart:async';
import 'dart:convert';

import 'package:absensi_prodi/src/configs/constants.dart';
import 'package:absensi_prodi/src/splash/models/check_last_checkin_model.dart';
import 'package:absensi_prodi/src/widgets/dialog_error_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SplashProvider with ChangeNotifier {

  bool isLogin;

  getPrefs(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      isLogin = prefs.getBool("isLogin");
      print("ISLOGIN IN SPLASHPAGE $isLogin");
    var duration = new Duration(seconds: 3);
    if(isLogin == null || isLogin == false){
      Timer(duration, (){
        Navigator.of(context).pushReplacementNamed("login_page");
      });
    } else {

      checkingLastCheckin(context);
      // Timer(duration, (){
      //   //Navigator.of(context).pushReplacementNamed("main_page", arguments: 0);
      //
      // });
    }
  }


  Future<CheckLastCheckinModel>checkingLastCheckin(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Constants.CHECK_LAST_CHECKIN;
    var body = {
      'uid': prefs.getString('uid'),
    };

    Map<String, String> headers = {
      "Accept": "application/json",
      'Content-type': 'application/json'
    };

    var duration = new Duration(seconds: 2);
    var response = await http.post(Uri.parse(url), body: json.encode(body), headers: headers);
      print("RESPONSE BODY ==> ${response.body}");
      final lastcheckin = CheckLastCheckinModel.fromJson(json.decode(response.body));

      if(lastcheckin.messages == "AllReadyCheckin"){
        Timer(duration, (){
          Navigator.of(context).pushReplacementNamed("main_page", arguments: 0);
         // failedDialog(context, "Anda Belum Checkout kemarin", "Silahkan melakukan Chekout untuk bisa Checkin kembali hari ini");
        });

      } else {
        Timer(duration, (){
          Navigator.of(context).pushReplacementNamed("main_page", arguments: 0);
        });
      }
  }

  failedDialog(BuildContext context, String title, String description)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogError(
          title: "$title", description: "$description", buttonText: "Oke", btnOkeAction: (){
          Navigator.of(context).pushReplacementNamed("main_page", arguments: 0);
          //prefs.setBool("isCheckin", true);
      }),
    );
  }

}