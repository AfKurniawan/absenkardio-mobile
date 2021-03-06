import 'dart:convert';

import 'package:absensi_prodi/src/configs/constants.dart';
import 'package:absensi_prodi/src/register/models/user_model.dart';
import 'package:absensi_prodi/src/styles/light_color.dart';
import 'package:absensi_prodi/src/utilities/localization.dart';
import 'package:absensi_prodi/src/widgets/dialog_error_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginProvider extends ChangeNotifier {

  IconButton iconpass = new IconButton(icon: Icon(Icons.lock_outline, color: LightColor.purpleLight));
  IconButton iconuser = new IconButton(icon: Icon(Icons.person_outline, color: LightColor.purpleLight));
  IconButton iconEmail = new IconButton(icon: Icon(Icons.email_outlined, color: LightColor.purpleLight));
  Color iconColor = LightColor.grey;
  bool obscure = true;

  String userid, fullname, avatar, mail, prodi, nim, statusMhs, type;
  bool isLogin ;



  void showPass(){
    obscure = !obscure;
    iconuser = new IconButton(icon:Icon(Icons.person_outline, color: LightColor.purpleLight));
    if(obscure){
      iconpass = new IconButton(icon: Icon(Icons.lock_outline, color: LightColor.purpleLight));
    } else {
      iconpass = new IconButton(icon: Icon(Icons.lock_open, color: LightColor.green));
    }
    notifyListeners();
  }

  void clearPrefs(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
    Navigator.pushReplacementNamed(context, "/");
  }


  // void login(BuildContext context, String email, String password) {
  //   loginAction(Constants.LOGIN_URL, {
  //     'nim': email,
  //     'password': password
  //   }).then((response)  {
  //     if (response.error == false) {
  //       isLogin = true ;
  //       setLoginState(response);
  //       Navigator.pushReplacementNamed(context, "main_page");
  //       getLoginState(context);
  //     } else {
  //       failedDialog(context, "Login gagal", "Periksa kembali NIM dan Password anda");
  //     }
  //   });
  // }
  //
  // Future<UserModel> loginAction(String url, var body) async {
  //   return await http.post(Uri.parse(url),
  //       body: body,
  //       headers: {"Accept": "application/json"}).then((http.Response response) {
  //     final int statusCode = response.statusCode;
  //     var users = UserModel.fromJson(json.decode(response.body));
  //     print(response.body);
  //
  //     if (statusCode < 200 || statusCode > 400 || json == null) {
  //       throw new Exception("Error while fetching data");
  //     }
  //     return users;
  //   });
  // }

  Future<UserModel> newLoginAction(BuildContext context, String email, String password) async {
    print("======== EXECUTE LOGIN ==========");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var body = {
      'nim': email,
      'password': password
    };
    var response = await http.post(Uri.parse(Constants.LOGIN_URL), body: body);
    final responseJson = UserModel.fromJson(json.decode(response.body));

    print("======== RESPONSE BODY ${response.body}");
    if(response.statusCode == 200 && responseJson.messages == "success"){
      prefs.setBool('isLogin', true);
      prefs.setString('uid', "${responseJson.user.id}");
      prefs.setString('fullName', "${responseJson.user.firstname} ${responseJson.user.lastname}");
      prefs.setString('avatar', responseJson.user.avatar == null ? "" : "${responseJson.user.avatar}");
      prefs.setString('prodi', "${responseJson.user.company}");
      prefs.setString('mail', "${responseJson.user.emailaddress}");
      prefs.setString('nim', "${responseJson.user.idno}");
      prefs.setString('statusMhs', "${responseJson.user.employmentstatus}");
      prefs.setString('tipe', "${responseJson.user.employmenttype}");
      prefs.setString('phone', "${responseJson.user.mobileno}");
      prefs.setString('address', "${responseJson.user.homeaddress}");

      Navigator.pushReplacementNamed(context, "main_page");

    } else {
      failedDialog(context, "Login gagal", "Periksa kembali NIM dan Password anda");
    }
  }



  getLoginState(BuildContext contest) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('uid');
    fullname = prefs.getString('fullName');
    mail = prefs.getString('mail');
    prodi = prefs.getString('prodi');
    avatar = prefs.getString('avatar');
    nim = prefs.getString('nim');
    statusMhs = prefs.getString('statusMhs');
    type = prefs.getString('tipe');
    notifyListeners();
  }

  failedDialog(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogError(
        title: title,
        description: description,
        buttonText: AppLocalizations.of(context)
            .translate("button_register_dialog_error"),
        btnOkeAction: (){
          Navigator.of(context).pop();
        },
      ),
    );
  }

  String checkinTime = "";
  String dateIn = "" ;
  String currentLocation = "" ;
  String reason = "" ;
  String status = "" ;
  String selfie = "" ;

  getCheckinData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("GET CHECKIN DATA===>");
    checkinTime = prefs.getString('chekinTime');
    currentLocation = prefs.getString('location');
    dateIn = prefs.getString('dateId');
    reason = prefs.getString('reason');
    status = prefs.getString('statusin');
    selfie = prefs.getString('selfie');
    notifyListeners();

  }


}