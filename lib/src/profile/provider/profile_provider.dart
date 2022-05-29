import 'dart:convert';

import 'package:absensi_prodi/src/configs/constants.dart';
import 'package:absensi_prodi/src/register/models/user_model.dart';
import 'package:absensi_prodi/src/styles/light_color.dart';
import 'package:absensi_prodi/src/widgets/dialog_error_widget.dart';
import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileProvider extends ChangeNotifier {

  IconButton iconpass = new IconButton(icon: Icon(Icons.lock_outline, color: LightColor.purpleLight));

  Color iconColor = LightColor.grey;
  bool obscure = true;
  TextEditingController emailTextEditControlller = new TextEditingController();
  TextEditingController noHpTextEditController = new TextEditingController();
  TextEditingController addressTextEditController = new TextEditingController();
  TextEditingController passwordTextEditController = new TextEditingController();

  checkoutAction(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isCheckin');
    showSuccess(context);

  }

  logoutAction(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isLogin');
    Navigator.of(context).pushReplacementNamed("/");
  }

  String checkinTime = "";
  String dateIn = "" ;
  String currentLocation = "" ;
  String reason = "" ;
  String status = "" ;
  String selfie = "" ;

  getCheckinData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    checkinTime = prefs.getString('chekinTime');
    currentLocation = prefs.getString('location');
    dateIn = prefs.getString('dateId');
    reason = prefs.getString('reason');
    status = prefs.getString('statusIn');
    selfie = prefs.getString('selfie');
    notifyListeners();

  }

  String userid, fullname, avatar, mail, prodi, nim, statusMhs, type, phone, address;
  getUseData(BuildContext contest) async {
    print("===========GET USER DATA===============");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('uid');
    fullname = prefs.getString('fullName');
    mail = prefs.getString('mail');
    prodi = prefs.getString('prodi');
    avatar = prefs.getString('avatar');
    nim = prefs.getString('nim');
    statusMhs = prefs.getString('statusMhs');
    type = prefs.getString('tipe');
    phone = prefs.getString('phone');
    address = prefs.getString('address');

    emailTextEditControlller.text = prefs.getString('mail');
    noHpTextEditController.text = prefs.getString('phone');
    addressTextEditController.text = prefs.getString('address');

    print("===== FULLNAME $userid, $fullname, $avatar, $mail, $prodi, $nim, $statusMhs, $type, $phone, $address} ======");

    notifyListeners();
  }



  void showPass(){
    obscure = !obscure;
    if(obscure){
      iconpass = new IconButton(icon: Icon(Icons.lock_outline, color: LightColor.purpleLight));
    } else {
      iconpass = new IconButton(icon: Icon(Icons.lock_open_outlined, color: LightColor.green));
    }
    notifyListeners();
  }

  Future<UserModel> updateProfile(BuildContext context, String email, String phone, String address, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Constants.UPDATE_PROFILE_URL ;
    print("PASSWORD $password");

    var body = {
      'uid': prefs.getString('uid'),
      'nim': prefs.getString('nim'),
      'email': email,
      'phone': phone,
      'address': address,
      'password': password

    };

    var bodynoPass = {
      'uid': prefs.getString('uid'),
      'nim': prefs.getString('nim'),
      'email': email,
      'phone': phone,
      'address': address

    };

    print("YOUR BODY REQUEST IS ${json.encode(body)}");

    Map<String, String> headers = {
      "Accept": "application/json",
      'Content-type': 'application/json'
    };
    var response = await http.post(Uri.parse(url), body: json.encode(passwordTextEditController.text.isEmpty? bodynoPass: body), headers: headers);
    print("RESPONSE BODY ==> ${response.body}");
    final model = UserModel.fromJson(json.decode(response.body));
    if(response.statusCode == 200){
    prefs.setString('mail', model.user.emailaddress);
    prefs.setString('phone', model.user.mobileno);
    prefs.setString('address', model.user.homeaddress);
    showSuccess(context);
    } else {
      failedDialog(context, "Update Profil Gagal", "Silahkan coba kembali nanti");
    }
    return model;
  }

  failedDialog(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogError(
          title: "$title",
          description: "$description",
          buttonText: "Oke"),
    );
  }

  void showSuccess(BuildContext context) {
    AchievementView(
      context,
      title: "Berhasil",
      subTitle: "Perubahan data berhasil disimpan   ",
      isCircle: true,
      alignment: Alignment.bottomCenter,
      duration: Duration(milliseconds: 2000),
      icon: Icon(Icons.assignment_turned_in, color: Colors.white),
      listener: (status) {
        //if(status == ach)
        print(status);
        if (status == AchievementState.closing) {
          Navigator.of(context).pushReplacementNamed("main_page", arguments: 1);
        } else if(status == AchievementState.closed){
          getUseData(context);
        }
      },
    )..show();
  }

}