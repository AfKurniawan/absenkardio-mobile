import 'dart:convert';

import 'package:absensi_prodi/src/configs/constants.dart';
import 'package:absensi_prodi/src/register/models/user_model.dart';
import 'package:absensi_prodi/src/utilities/localization.dart';
import 'package:absensi_prodi/src/widgets/dialog_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterProvider extends ChangeNotifier {

  String userid, fullname, alamat, hp, periode, mail, sPeriode;
  bool isLogin ;

  void register(BuildContext context, String fullname, String nim, String email, String password) {
    registerAction(Constants.REGISTER_URL, {
      'full_name' : fullname,
      'nim': nim,
      'email': email,
      'password': password,
      'status': 'active'
    }).then((response)  {
      if (response.error == false) {
        userid = response.user.id;
        fullname = "${response.user.firstname} ${response.user.lastname}";
        mail = response.user.emailaddress;
        isLogin = true;
        notifyListeners();
        setLoginState();
        Navigator.pushReplacementNamed(context, "main_page");
      } else {
        failedDialog(context);
      }
    });
  }

  Future<UserModel> registerAction(String url, var body) async {
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

  setLoginState() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', isLogin);
    prefs.setString('uid', userid);
    return true;
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

  failedDialogExist(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogError(
        title: AppLocalizations.of(context)
            .translate("title_register_dialog_error"),
        description: AppLocalizations.of(context)
            .translate("description_register_dialog_user_exist"),
        buttonText: AppLocalizations.of(context)
            .translate("button_register_dialog_error"),
      ),
    );
  }

}