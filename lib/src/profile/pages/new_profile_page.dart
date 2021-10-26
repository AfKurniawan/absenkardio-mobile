import 'package:absensi_prodi/src/configs/constants.dart';
import 'package:absensi_prodi/src/login/providers/login_provider.dart';
import 'package:absensi_prodi/src/profile/provider/profile_provider.dart';
import 'package:absensi_prodi/src/profile/widgets/custom_elevated_button.dart';
import 'package:absensi_prodi/src/register/models/user_model.dart';
import 'package:absensi_prodi/src/styles/light_color.dart';
import 'package:absensi_prodi/src/styles/theme/theme_model.dart';
import 'package:absensi_prodi/src/widgets/form_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:provider/provider.dart';

class NewProfilePage extends StatefulWidget {
  UserModel user;
  NewProfilePage({Key key, this.user}) : super(key: key);

  @override
  _NewProfilePageState createState() => _NewProfilePageState();
}

class _NewProfilePageState extends State<NewProfilePage> {

  bool obscure = true;


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    return Consumer<ThemeModel>(
      builder: (context, tm, _){
        return Scaffold(
          backgroundColor: tm.isDark ? Colors.grey[700] : Colors.grey[200],
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              "Profilku",
              style: TextStyle(color: tm.isDark? Colors.blueAccent : Colors.black, fontSize: 20),
            ),
            elevation: 2,
            backgroundColor: tm.isDark? Colors.grey[900]: Colors.white,
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
          body: Consumer<ThemeModel>(
            builder: (context, tm, _){
              return SingleChildScrollView(
                child: Consumer<ProfileProvider>(
                  builder: (child, prov, _) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: tm.isDark ? Colors.black : Colors.white
                              // gradient: LinearGradient(
                              //     begin: Alignment(-1, -1),
                              //     end: Alignment(1.0, 1.0),
                              //     colors: [
                              //       LightColor.unsBlue,
                              //       Color.fromRGBO(9,121,91,0.53125),
                              //     ])
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                      child: IconButton(
                                        icon: const Icon(FeatherIcons.edit),
                                        color: tm.isDark ? Colors.blueAccent : Colors.black,
                                        onPressed: () {
                                          Navigator.pushNamed(context, "edit_profile_page");
                                        },
                                      ),
                                    ),
                                  ),
                                  //SizedBox(height: 10),
                                  CircleAvatar(
                                    backgroundColor: Colors.white10,
                                    radius: 69,
                                    child: CircleAvatar(
                                      radius: 66.0,
                                      backgroundImage: CachedNetworkImageProvider(
                                          '${Constants.IMG_URL}${prov.avatar}'),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Text(
                                    '${prov.fullname}',
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${prov.prodi}',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(height: 50),
                                  buildProfileItem(context, title: "Email", trailing: '${prov.mail}'),
                                  const SizedBox(height: 5),
                                  Divider(),
                                  const SizedBox(height: 5),
                                  buildProfileItem(context, title: "NIM", trailing: '${prov.nim}'),
                                  const SizedBox(height: 5),
                                  Divider(),
                                  const SizedBox(height: 5),
                                  buildProfileItem(context, title: "Tipe", trailing: '${prov.type}'),
                                  const SizedBox(height: 5),
                                  Divider(),
                                  const SizedBox(height: 5),
                                  buildProfileItem(context, title: "No. HP", trailing: '${prov.phone}'),
                                  const SizedBox(height: 5),
                                  Divider(),
                                  const SizedBox(height: 5),
                                  buildProfileItem(context, title: "Alamat", trailing: '${prov.address}'),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              const SizedBox(height: 5),
                              const SizedBox(height: 15),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),

                      ],
                    );
                  },
                ),
              );
            },
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: InkWell(
              onTap: () {
                showDialog<dynamic>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        backgroundColor: tm.isDark ? Colors.grey[800] : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        content: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Yakin akan keluar dari apikasi ?",
                              textAlign: TextAlign.center),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Provider.of<ProfileProvider>(context,
                                  listen: false)
                                  .logoutAction(context);
                            },
                            child: Text("Oke", style: TextStyle(color: Colors.lightBlueAccent)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Batal",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ]);
                  },
                );
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
                        "Logout",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 18),
                      )),
                ),
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
      }
    );
  }

  Container buildProfileItem(
    BuildContext context, {
    String title,
    String trailing,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(title, style: theme.textTheme.subtitle2),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(trailing, style: theme.textTheme.bodyText1),
          ),
        ],
      ),
    );
  }
}
