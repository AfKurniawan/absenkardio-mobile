import 'dart:async';

import 'package:absensi_prodi/src/checkin/widgets/timer_widget.dart';
import 'package:absensi_prodi/src/configs/app_config.dart';
import 'package:absensi_prodi/src/configs/constants.dart';
import 'package:absensi_prodi/src/profile/provider/profile_provider.dart';
import 'package:absensi_prodi/src/login/providers/login_provider.dart';
import 'package:absensi_prodi/src/styles/light_color.dart';
import 'package:absensi_prodi/src/styles/theme/theme_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DailyInfoPage extends StatefulWidget {
  @override
  _DailyInfoPageState createState() => _DailyInfoPageState();
}

class _DailyInfoPageState extends State<DailyInfoPage> {
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

        if (_timeString == "15:45:00") {
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

  String _dateFilename(DateTime namaFile) {
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
    context.read<LoginProvider>().getCheckinData();
    Provider.of<LoginProvider>(context, listen: false).getLoginState(context);
    Timer.periodic(Duration(seconds: 1), (Timer t) async => _getTime());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, user, _) {
        return Consumer<ThemeModel>(
          builder: (context, tm, _){
            return Scaffold(
              backgroundColor: tm.isDark ? Colors.grey[400] : Colors.white,
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "Absensi Hari Ini",
                  style: TextStyle(color: LightColor.unsBlue, fontSize: 20),
                ),
                elevation: 2,
                backgroundColor: tm.isDark? Colors.grey[900]: Colors.white,
                actions: <Widget>[
                ],
              ),
              body: buildScrollBody(user, context),
            );
          },
        );
      },
    );
  }

  Widget buildScrollBody(LoginProvider user, BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, tm, _){
        return SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: 1000,
            child: Stack(
              children: [
                Consumer<LoginProvider>(
                  builder: (child, prov, _) {
                    return Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 320,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50)),
                            color: tm.isDark? Colors.black : Colors.grey[300],
                            // gradient: LinearGradient(
                            //     begin: Alignment(-1, -1),
                            //     end: Alignment(1.0, 1.0),
                            //     colors: [
                            //       LightColor.unsBlue,
                            //       Color.fromRGBO(9,121,91,0.53125),
                            //     ])
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 30),
                              SizedBox(height: 10),
                              CircleAvatar(
                                backgroundColor: prov.selfie == "" || prov.selfie == null ? Colors.transparent : Colors.white,
                                radius: 69,
                                child: CircleAvatar(
                                  radius: 66.0,
                                  backgroundImage: prov.selfie == "" || prov.selfie == null ? AssetImage("assets/icons/logo.png")
                                      :CachedNetworkImageProvider(
                                      '${Constants.IMG_URL}${prov.selfie}'),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                '${prov.fullname}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${prov.prodi}',
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                Positioned(
                  top: 230,
                  left: 20.0,
                  right: 20.0,
                  child: Container(
                      margin: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                      width: MediaQuery.of(context).size.width - 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: tm.isDark ? Colors.grey[900] : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
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
                            Text(
                              "Detail Absensi",
                              style: TextStyle(
                                fontSize: 17.0,
                                color: tm.isDark ? Colors.white : LightColor.unsBlue,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 10),
                            Divider(color: tm.isDark ? Colors.grey : Colors.grey),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.access_alarm,
                                  color: Colors.blueAccent[400],
                                  size: 35,
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Text("${user.checkinTime}",
                                    style: TextStyle(
                                        fontSize: 16.0, color: tm.isDark ? Colors.white : LightColor.unsBlue)),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_box_outlined,
                                  color: user.status == "Hadir"
                                      ? Colors.green
                                      : Colors.yellowAccent[400],
                                  size: 35,
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Text("${user.status}",
                                    style: TextStyle(
                                        fontSize: 16.0, color: tm.isDark ? Colors.white : LightColor.unsBlue)),
                              ],
                            ),
                            SizedBox(height: 20),
                            Divider(color: tm.isDark? Colors.grey : Colors.grey),
                            SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, 'checkout_page');
                              },
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
                                      child: Text(
                                        "Check-Out",
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
                      )),
                ),
              ],

            ),
          ),
        );
      },
    );
  }

  Widget buildStackBody(LoginProvider user, BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 360,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.white70),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50)),
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
                        SizedBox(
                          height: 65.0,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 60,
                          child: CircleAvatar(
                            radius: 58.0,
                            backgroundImage: NetworkImage(
                                '${Constants.IMG_URL}${user.selfie}'),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('${user.fullname}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.w300)),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('${user.prodi}',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13.0,
                            )),
                        SizedBox(height: 10),
                      ]),
                ),
              ),
            ),
          ],
        ),
        Positioned(
            top: 260,
            left: 20.0,
            right: 20.0,
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  margin: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                  width: MediaQuery.of(context).size.width - 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
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
                        Text(
                          "Absensi Hari Ini",
                          style: TextStyle(
                            fontSize: 17.0,
                            color: LightColor.unsBlue,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
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
                            SizedBox(
                              width: 20.0,
                            ),
                            Text("${user.checkinTime}",
                                style: TextStyle(
                                    fontSize: 16.0, color: LightColor.unsBlue)),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_box_outlined,
                              color: user.status == "Hadir"
                                  ? Colors.green
                                  : Colors.yellowAccent[400],
                              size: 35,
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text("${user.status}",
                                style: TextStyle(
                                    fontSize: 16.0, color: LightColor.unsBlue)),
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
                                  child: Text(
                                    "Check-Out",
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
                  )),
            ))),
      ],
    );
  }
}
