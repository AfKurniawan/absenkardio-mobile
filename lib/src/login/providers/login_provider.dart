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


  void login(BuildContext context, String email, String password) {
    loginAction(Constants.LOGIN_URL, {
      'nim': email,
      'password': password
    }).then((response)  {
      if (response.error == false) {
        isLogin = true ;
        setLoginState(response);
        Navigator.pushReplacementNamed(context, "main_page");
        getLoginState(context);
      } else {
        failedDialog(context);
      }
    });
  }

  Future<UserModel> loginAction(String url, var body) async {
    return await http.post(Uri.parse(url),
        body: body,
        headers: {"Accept": "application/json"}).then((http.Response response) {
      final int statusCode = response.statusCode;
      var users = UserModel.fromJson(json.decode(response.body));
      print(response.body);

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return users;
    });
  }

  setLoginState(UserModel model) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    notifyListeners();
    prefs.setBool('isLogin', true);
    prefs.setString('uid', model.user.id);
    prefs.setString('fullName', "${model.user.firstname} ${model.user.lastname}");
    prefs.setString('avatar', model.user.avatar);
    prefs.setString('prodi', model.user.company);
    prefs.setString('mail', model.user.emailaddress);
    prefs.setString('nim', model.user.idno);
    prefs.setString('statusMhs', model.user.employmentstatus);
    prefs.setString('tipe', model.user.employmenttype);
    return true;
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

  failedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogError(
        title: AppLocalizations.of(context)
            .translate("title_register_dialog_error"),
        description: AppLocalizations.of(context)
            .translate("description_register_dialog_error"),
        buttonText: AppLocalizations.of(context)
            .translate("button_register_dialog_error"),
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
    status = prefs.getString('statusIn');
    selfie = prefs.getString('selfie');
    notifyListeners();

  }


}