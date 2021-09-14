
import 'package:absensi_prodi/animation/fade_animation.dart';
import 'package:absensi_prodi/src/checkin/pages/checkin_page.dart';
import 'package:absensi_prodi/src/kehadiran/pages/kehadiran_page.dart';
import 'package:absensi_prodi/src/login/providers/login_provider.dart';
import 'package:absensi_prodi/src/main/providers/main_provider.dart';
import 'package:absensi_prodi/src/styles/icon_badge.dart';
import 'package:absensi_prodi/src/styles/light_color.dart';
import 'package:flashy_tab_bar/flashy_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:provider/provider.dart';
import 'package:absensi_prodi/src/styles/extention.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {

  int currentTab;
  Widget currenPage = new CheckinPage();
  String currentTitle;


  MainPage({Key key, this.currentTab}){
    currentTab = currentTab != null ? currentTab : 0 ;
  }

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    context.read<MainProvider>().selectTab(context, widget.currentTab);
    getcheckinState();
    super.initState();
  }

  @override
  void didUpdateWidget(MainPage oldWidget){
    Provider.of<MainProvider>(context, listen: false).selectTab(context, widget.currentTab);
    getcheckinState();
    super.didUpdateWidget(oldWidget);
  }

  bool isCheckin = false ;
  getcheckinState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isCheckin = prefs.getBool('isCheckin');
    });

  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MainProvider>(context);
    var loginProv = Provider.of<LoginProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
      centerTitle: true,
      title: Text(
        "${provider.currentTitle}",
        style: TextStyle(color: Colors.black),
      ),
      elevation: 1,
      backgroundColor: Theme.of(context).backgroundColor,
      // leading: IconButton(
      //     icon: Icon(
      //       Icons.short_text,
      //       size: 30,
      //       color: Colors.black,
      //     ),
      //     onPressed: () {
      //       _scaffoldKey.currentState.openDrawer();
      //     }
      // ),
      actions: <Widget>[
        // FadeAnimation(
        //   2,
        //   ClipRRect(
        //     borderRadius: BorderRadius.all(Radius.circular(13)),
        //     child: Container(
        //       // height: 40,
        //       // width: 40,
        //       decoration: BoxDecoration(
        //         color: Theme.of(context).backgroundColor,
        //       ),
        //       child: Image.asset("assets/icons/user.png", fit: BoxFit.fill),
        //     ),
        //   ).p(8),
        // ),
      ],
    ),
      body: provider.currenPage,
      bottomNavigationBar: flashyTabBar(context),
    );
  }


  Widget flashyTabBar(BuildContext context){
    var provider = Provider.of<MainProvider>(context);
    return FlashyTabBar(
      selectedIndex: provider.currentTab,
      showElevation: true,
      onItemSelected: (index){
        setState(() {
          context.read<MainProvider>().selectTab(context, index);
        });
      },
      items: [
        FlashyTabBarItem(
          icon:Icon(LineariconsFree.clock_2,
            size: 20,
            color: Colors.green,
          ),
          title: isCheckin == true
              ? Text("Beranda")
              : Text("Check-In"),
        ),
        FlashyTabBarItem(
          icon:Icon(LineariconsFree.pie_chart,
            size: 20,
          ),
          title: Text("Profil"),
        ),
      ],
    );
  }
}
