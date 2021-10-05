import 'package:absensi_prodi/src/configs/constants.dart';
import 'package:absensi_prodi/src/login/providers/login_provider.dart';
import 'package:absensi_prodi/src/profile/provider/profile_provider.dart';
import 'package:absensi_prodi/src/profile/widgets/custom_elevated_button.dart';
import 'package:absensi_prodi/src/register/models/user_model.dart';
import 'package:absensi_prodi/src/styles/light_color.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';

class NewProfilePage extends StatefulWidget {
  UserModel user;
  NewProfilePage({Key key, this.user}) : super(key: key);

  @override
  _NewProfilePageState createState() => _NewProfilePageState();
}

class _NewProfilePageState extends State<NewProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profilku",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        elevation: 2,
        backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        child: Consumer<LoginProvider>(
          builder: (child, prov, _) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        // Align(
                        //   alignment: Alignment.topRight,
                        //   child: Padding(
                        //     padding:
                        //     const EdgeInsets.symmetric(horizontal: 10),
                        //     child: IconButton(
                        //       icon: const Icon(FeatherIcons.settings),
                        //       color: Colors.black,
                        //       onPressed: () {
                        //
                        //       },
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 10),
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
                        buildProfileItem(context,
                            title: "Email", trailing: '${prov.mail}'),
                        const SizedBox(height: 5),
                        Divider(),
                        const SizedBox(height: 5),
                        buildProfileItem(context,
                            title: "NIM", trailing: '${prov.nim}'),
                        const SizedBox(height: 5),
                        Divider(),
                        const SizedBox(height: 5),
                        buildProfileItem(context,
                            title: "Tipe", trailing: '${prov.type}'),
                        const SizedBox(height: 5),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      const SizedBox(height: 15),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                // Padding(
                //   padding: const EdgeInsets.all(30),
                //   child: CustomElevatedButton(
                //       label: "Logout",
                //       onTap: () {
                //         showDialog<dynamic>(
                //           context: context,
                //           builder: (context) {
                //             return AlertDialog(
                //                 backgroundColor: Colors.white,
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(15),
                //                 ),
                //                 content: Padding(
                //                   padding: const EdgeInsets.all(10.0),
                //                   child: Text("Yakin akan keluar dari apikasi ?",
                //                       textAlign: TextAlign.center),
                //                 ),
                //                 actions: [
                //                   TextButton(
                //                     onPressed: () {
                //                       Provider.of<ProfileProvider>(context, listen: false).logoutAction(context);
                //                     },
                //                     child: Text("Oke"),
                //                   ),
                //                   TextButton(
                //                     onPressed: (){
                //                       Navigator.of(context).pop();
                //                     },
                //                     child: Text("Batal",
                //                       style: TextStyle(color: Colors.grey),
                //                     ),
                //                   ),
                //                 ]);
                //           },
                //         );
                //       }),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: InkWell(
                    onTap: () {
                      showDialog<dynamic>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              backgroundColor: Colors.white,
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
                                  child: Text("Oke"),
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
                )
              ],
            );
          },
        ),
      ),
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

  Widget buildInfoDetail() {
    return Padding(
      padding:
          EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0, bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Maldives - 12 Days',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    fontSize: 15.0),
              ),
              SizedBox(height: 7.0),
              Row(
                children: <Widget>[
                  Text(
                    'Teresa Soto',
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontFamily: 'Montserrat',
                        fontSize: 11.0),
                  ),
                  SizedBox(width: 4.0),
                  Icon(
                    Icons.timer,
                    size: 4.0,
                    color: Colors.black,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    '3 Videos',
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontFamily: 'Montserrat',
                        fontSize: 11.0),
                  )
                ],
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 7.0),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 20.0,
                  width: 20.0,
                  child: Image.asset('assets/navarrow.png'),
                ),
              ),
              SizedBox(width: 7.0),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 20.0,
                  width: 20.0,
                  child: Image.asset('assets/chatbubble.png'),
                ),
              ),
              SizedBox(width: 7.0),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 22.0,
                  width: 22.0,
                  child: Image.asset('assets/fav.png'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
