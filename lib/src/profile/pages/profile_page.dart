import 'dart:async';

import 'package:absensi_prodi/src/checkin/widgets/timer_widget.dart';
import 'package:absensi_prodi/src/configs/app_config.dart';
import 'package:absensi_prodi/src/configs/constants.dart';
import 'package:absensi_prodi/src/profile/provider/profile_provider.dart';
import 'package:absensi_prodi/src/login/providers/login_provider.dart';
import 'package:absensi_prodi/src/styles/light_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String _timeString;
  String _dateString;
  String _fileString;
  String _dateStringSend;

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDate = _formatDate(now);
    final String formmattedTime = _formatTime(now);
    final String formattedFilename = _dateFilename(now);
    final String fomratedDateSend = _formatDateSend(now);
    if (mounted) {
      setState(() {
        _dateString = formattedDate;
        _timeString = formmattedTime;
        _fileString = formattedFilename;
        _dateStringSend = fomratedDateSend;

        if(_timeString == "15:45:00"){
          print("THIS TIME");
        }
      });
    }
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('dd MMMM yyyy', "id_ID").format(dateTime.toLocal());
  }

  String _formatDateSend(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd', "id_ID").format(dateTime.toLocal());
  }

  String _dateFilename(DateTime namaFile){
    return DateFormat('ddMMyyhhmmss').format(namaFile.toLocal());
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss', "id_ID").format(dateTime.toLocal());
  }

  int counter = 0;

  @override
  void initState() {
    _dateString = _formatDate(DateTime.now());
    _timeString = _formatTime(DateTime.now());
    _dateStringSend = _formatDateSend(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) async => _getTime());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, user, _){
        return Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 360,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white70
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50)
                          ),
                          gradient: LinearGradient(
                              begin: Alignment(-1, -1),
                              end: Alignment(1.0, 1.0),
                              colors: [
                                LightColor.unsBlue,
                                Color.fromRGBO(143, 148, 251, .6),
                              ])),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 65.0,),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 50,
                                child: CircleAvatar(
                                  radius: 45.0,
                                  backgroundImage: NetworkImage('${Constants.IMG_URL}${user.avatar}'),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              Text('${user.fullname}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w300
                                  )),
                              SizedBox(height: 10.0,),
                              Text('${user.prodi}',
                                  style: TextStyle(
                                    color:Colors.black54,
                                    fontSize: 13.0,
                                  )),

                              SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("$_dateString",
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.white)),
                                      Text("$_timeString",
                                          style: TextStyle(
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white))
                                    ],
                                  ),
                                ),
                              )
                            ]
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 20,
                right: 0,
                left: MediaQuery.of(context).size.width -110,
                child: Material(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)
                  )),
                  child: InkWell(
                    onTap: (){
                      print("Logout");
                      Provider.of<BerandaProvider>(context, listen: false).logoutAction(context);
                    },
                    splashColor: Colors.black54.withOpacity(0.1),
                    child: Ink(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20)
                          )),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
                          child: Row(
                            children: [
                              Text("Logout", style: TextStyle(fontWeight: FontWeight.w600)),
                              SizedBox(width: 10),
                              Icon(Icons.exit_to_app_outlined, size: 25),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 280,
                  left: 20.0,
                  right: 20.0,
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            margin: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                            width: MediaQuery.of(context).size.width -10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2 ),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(1, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Absensi Hari Ini",
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: LightColor.unsBlue,
                                      fontWeight: FontWeight.w800,
                                    ),),
                                  SizedBox(height: 10),
                                  Divider(),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.access_alarm,
                                        color: Colors.blueAccent[400],
                                        size: 35,
                                      ),
                                      SizedBox(width: 20.0,),
                                      Text("00:00:00",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: LightColor.unsBlue
                                        )),

                                    ],
                                  ),
                                  SizedBox(height: 20.0,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.check_box_outlined,
                                        color: Colors.yellowAccent[400],
                                        size: 35,
                                      ),
                                      SizedBox(width: 20.0,),
                                      Text("Hadir",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: LightColor.unsBlue
                                        )),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Divider(),
                                  SizedBox(height: 20),
                                  InkWell(
                                    onTap: () {},
                                    splashColor: Color.fromRGBO(143, 148, 251, 1),
                                    child: Container(
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          gradient: LinearGradient(colors: [
                                            LightColor.unsBlue,
                                            Color.fromRGBO(143, 148, 251, .6),
                                          ])),
                                      child: Center(
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Check-Out",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 18),
                                            )),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            )
                        ),
                      )
                  )
              ),

            ],

          ),
        );
      },
    );
  }
}