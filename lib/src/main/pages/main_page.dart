
import 'package:absensi_prodi/src/checkin/pages/new_checkin_page.dart';
import 'package:absensi_prodi/src/login/providers/login_provider.dart';
import 'package:absensi_prodi/src/main/providers/main_provider.dart';
import 'package:absensi_prodi/src/profile/helpers/colors.dart';
import 'package:absensi_prodi/src/styles/theme/theme_model.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {

  int currentTab;
  String currentTitle;


  MainPage({Key key, this.currentTab}){
    currentTab = currentTab != null ? currentTab : 0 ;
  }

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _timeString;
  String _dateString;
  String _fileString;
  String _dateStringSend;
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


  Future _getTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final DateTime now = DateTime.now();
    final String formattedDate = _formatDate(now);
    final String formmattedTime = _formatTime(now);
    final String formattedFilename = _dateFilename(now);
    final String fomratedDateSend = _formatDateSend(now);

    String checkDate = prefs.getString("date_checkin");
    if (mounted) {
      setState(() {
        _dateString = formattedDate;
        _timeString = formmattedTime;
        _fileString = formattedFilename;
        _dateStringSend = fomratedDateSend;
        if (checkDate == _dateString){
          print("Semm THIS TIME CHECK DATE $checkDate");
        }
      });
    }
  }

  @override
  void initState() {
    context.read<MainProvider>().selectTab(context, widget.currentTab);
    context.read<LoginProvider>().getCheckinData();
    getcheckinState();
    //_getTime();
    super.initState();
  }

  @override
  void didUpdateWidget(MainPage oldWidget){
    Provider.of<MainProvider>(context, listen: false).selectTab(context, widget.currentTab);
    context.read<LoginProvider>().getCheckinData();
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

  final iconList = <IconData>[
    Icons.brightness_5,
    Icons.brightness_4,
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MainProvider>(context);
    var loginProv = Provider.of<LoginProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
    //   appBar: AppBar(
    //   centerTitle: true,
    //   title: Text(
    //     "${provider.currentTitle}",
    //     style: TextStyle(color: Colors.black),
    //   ),
    //   elevation: 1,
    //   backgroundColor: Theme.of(context).backgroundColor,
    //   // leading: IconButton(
    //   //     icon: Icon(
    //   //       Icons.short_text,
    //   //       size: 30,
    //   //       color: Colors.black,
    //   //     ),
    //   //     onPressed: () {
    //   //       _scaffoldKey.currentState.openDrawer();
    //   //     }
    //   // ),
    //   actions: <Widget>[
    //     // FadeAnimation(
    //     //   2,
    //     //   ClipRRect(
    //     //     borderRadius: BorderRadius.all(Radius.circular(13)),
    //     //     child: Container(
    //     //       // height: 40,
    //     //       // width: 40,
    //     //       decoration: BoxDecoration(
    //     //         color: Theme.of(context).backgroundColor,
    //     //       ),
    //     //       child: Image.asset("assets/icons/user.png", fit: BoxFit.fill),
    //     //     ),
    //     //   ).p(8),
    //     // ),
    //   ],
    // ),
      body: provider.currenPage,
      bottomNavigationBar: MyNavbar(context),
    );
  }

  Widget MyNavbar(BuildContext context){
    var provider = Provider.of<MainProvider>(context);
    final theme = Theme.of(context);
    return Consumer<ThemeModel>(
      builder: (context, tm, _){
        return BottomNavyBar(
          selectedIndex: provider.currentTab,
          backgroundColor: tm.isDark? Colors.grey[900]: Colors.white,
          onItemSelected: (index) {
            setState(() {
              context.read<MainProvider>().selectTab(context, index);
            });
          },
          items: [
            BottomNavyBarItem(
              icon:Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(LineariconsFree.clock_2,
                  size: 20,
                  color: Colors.green,
                ),
              ),
              title: isCheckin == true
                  ? Text("Beranda")
                  : Text("Check-In"),
              activeColor: Colors.blue,
            ),
            BottomNavyBarItem(
              icon:Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(LineariconsFree.user_1,
                  size: 20,
                  color: Colors.blueAccent,
                ),
              ),
              title: Text("Profil"),
              activeColor: Colors.blue,
            ),
          ],
        );
      },
    );
  }

  //
  // Widget flashyTabBar(BuildContext context){
  //   var provider = Provider.of<MainProvider>(context);
  //   return AnimatedBottomNavigationBar(
  //     icons: iconList,
  //     activeIndex: provider.currentTab,
  //     gapLocation: GapLocation.center,
  //     notchSmoothness: NotchSmoothness.verySmoothEdge,
  //     leftCornerRadius: 32,
  //     rightCornerRadius: 32,
  //     onTap: (index) {
  //       context.read<MainProvider>().selectTab(context, index);
  //     }
  //     //other params
  //   );
    // return FlashyTabBar(
    //   selectedIndex: provider.currentTab,
    //   showElevation: true,
    //   onItemSelected: (index){
    //     setState(() {
    //       context.read<MainProvider>().selectTab(context, index);
    //     });
    //   },
    //   items: [
    //     FlashyTabBarItem(
    //       icon:Icon(LineariconsFree.clock_2,
    //         size: 20,
    //         color: Colors.green,
    //       ),
    //       title: isCheckin == true
    //           ? Text("Beranda")
    //           : Text("Check-In"),
    //     ),
    //     FlashyTabBarItem(
    //       icon:Icon(LineariconsFree.pie_chart,
    //         size: 20,
    //       ),
    //       title: Text("Profil"),
    //     ),
    //   ],
    // );
 // }
}
