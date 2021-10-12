import 'package:absensi_prodi/src/configs/constants.dart';
import 'package:absensi_prodi/src/login/providers/login_provider.dart';
import 'package:absensi_prodi/src/profile/provider/profile_provider.dart';
import 'package:absensi_prodi/src/profile/widgets/custom_elevated_button.dart';
import 'package:absensi_prodi/src/register/models/user_model.dart';
import 'package:absensi_prodi/src/styles/light_color.dart';
import 'package:absensi_prodi/src/widgets/form_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  UserModel user;
  EditProfilePage({Key key, this.user}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool obscure = true;
  bool changePassword = false ;
  IconButton iconpass = new IconButton(icon: Icon(Icons.lock_outline, color: LightColor.purpleLight));
  Color changePasswordColor = Colors.blueAccent;
  bool visible = false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Ubah Profile",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
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
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          // Align(
                          //   alignment: Alignment.topRight,
                          //   child: Padding(
                          //     padding:
                          //         const EdgeInsets.symmetric(horizontal: 10),
                          //     child: IconButton(
                          //       icon: const Icon(FeatherIcons.settings,
                          //           color: Colors.blue),
                          //       color: Colors.black,
                          //       onPressed: () {
                          //         showModalBottomSheet(
                          //           context: context,
                          //           isScrollControlled: true,
                          //           backgroundColor: Colors.transparent,
                          //           builder: (context) => Container(
                          //             height:
                          //                 MediaQuery.of(context).size.height *
                          //                     0.75,
                          //             decoration: new BoxDecoration(
                          //               color: Colors.white,
                          //               borderRadius: new BorderRadius.only(
                          //                 topLeft: const Radius.circular(25.0),
                          //                 topRight: const Radius.circular(25.0),
                          //               ),
                          //             ),
                          //             child: Padding(
                          //               padding: const EdgeInsets.all(8.0),
                          //               child: Column(
                          //                 children: [
                          //                   Padding(
                          //                     padding: const EdgeInsets.only(
                          //                         right: 12.0),
                          //                     child: Row(
                          //                       mainAxisAlignment:
                          //                           MainAxisAlignment
                          //                               .spaceBetween,
                          //                       children: [
                          //                         IconButton(
                          //                             onPressed: () {
                          //                               Navigator.of(context)
                          //                                   .pop();
                          //                             },
                          //                             icon: Icon(Icons.close,
                          //                                 size: 20)),
                          //                         Row(
                          //                           children: [
                          //                             Text("Ganti Password"),
                          //                             SizedBox(width: 6),
                          //                           ],
                          //                         )
                          //                       ],
                          //                     ),
                          //                   ),
                          //                   Divider(
                          //                     thickness: 1,
                          //                   ),
                          //                   SizedBox(height: 8),
                          //                   FormWidget(
                          //                     hint: "Password",
                          //                     prefixIcon: Icon(
                          //                         LineariconsFree.lock_1,
                          //                         size: 20),
                          //                     obscure: obscure,
                          //                     textEditingController: prov
                          //                         .passwordTextEditController,
                          //                     color: Colors.black,
                          //                     keyboardType: TextInputType.text,
                          //                     maxline: 1,
                          //                     textInputAction:
                          //                         TextInputAction.next,
                          //                     icon: IconButton(
                          //                       icon: prov.iconpass,
                          //                       color: prov.iconColor,
                          //                       onPressed: () {
                          //                         obscure = !obscure;
                          //                         if(obscure){
                          //                           iconpass = new IconButton(icon: Icon(Icons.lock_outline, color: LightColor.purpleLight));
                          //                         } else {
                          //                           iconpass = new IconButton(icon: Icon(Icons.lock_open_outlined, color: LightColor.green));
                          //                         }
                          //                       },
                          //                     ),
                          //                   ),
                          //                   SizedBox(height: 40),
                          //                   Padding(
                          //                     padding: const EdgeInsets.only(left: 10.0, right: 10),
                          //                     child: InkWell(
                          //                       onTap: () {
                          //                         showDialog<dynamic>(
                          //                           context: context,
                          //                           builder: (context) {
                          //                             return AlertDialog(
                          //                                 backgroundColor: Colors.white,
                          //                                 shape: RoundedRectangleBorder(
                          //                                   borderRadius: BorderRadius.circular(15),
                          //                                 ),
                          //                                 content: Padding(
                          //                                   padding: const EdgeInsets.all(10.0),
                          //                                   child: Text(
                          //                                       "Yakin akan menyimpan perubahan data Anda?",
                          //                                       textAlign: TextAlign.center),
                          //                                 ),
                          //                                 actions: [
                          //                                   TextButton(
                          //                                     onPressed: () {
                          //                                       prov.updateProfile(
                          //                                           context,
                          //                                           prov.emailTextEditControlller.text,
                          //                                           prov.noHpTextEditController.text,
                          //                                           prov.addressTextEditController.text,
                          //                                           prov.passwordTextEditController.text);
                          //                                     },
                          //                                     child: Text("Oke"),
                          //                                   ),
                          //                                   TextButton(
                          //                                     onPressed: () {
                          //                                       Navigator.of(context).pop();
                          //                                     },
                          //                                     child: Text(
                          //                                       "Batal",
                          //                                       style: TextStyle(color: Colors.grey),
                          //                                     ),
                          //                                   ),
                          //                                 ]);
                          //                           },
                          //                         );
                          //                       },
                          //                       splashColor: Color.fromRGBO(143, 148, 251, 1),
                          //                       child: Container(
                          //                         height: 50,
                          //                         width: MediaQuery.of(context).size.width,
                          //                         decoration: BoxDecoration(
                          //                             borderRadius: BorderRadius.circular(10),
                          //                             gradient: LinearGradient(colors: [
                          //                               LightColor.unsBlue,
                          //                               Color.fromRGBO(143, 148, 251, .6),
                          //                             ])),
                          //                         child: Center(
                          //                           child: Padding(
                          //                               padding: const EdgeInsets.all(8.0),
                          //                               child: Text(
                          //                                 "Simpan",
                          //                                 style: TextStyle(
                          //                                     color: Colors.white,
                          //                                     fontWeight: FontWeight.w300,
                          //                                     fontSize: 18),
                          //                               )),
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   ),
                          //
                          //                 ],
                          //               ),
                          //             ),
                          //           ),
                          //         );
                          //       },
                          //     ),
                          //   ),
                          // ),
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
                          const SizedBox(height: 5),
                          Text(
                            'NIM: ${prov.nim}',
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 20),
                          FormWidget(
                            hint: "Email",
                            obscure: false,
                            color: Colors.black,
                            textEditingController:
                                prov.emailTextEditControlller,
                            prefixIcon:
                                Icon(LineariconsFree.envelope, size: 20),
                            keyboardType: TextInputType.emailAddress,
                            maxline: 1,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 8),
                          FormWidget(
                            hint: "No. Hp",
                            prefixIcon: Icon(
                              LineariconsFree.smartphone,
                              size: 20,
                            ),
                            obscure: false,
                            textEditingController: prov.noHpTextEditController,
                            color: Colors.black,
                            keyboardType: TextInputType.phone,
                            maxline: 1,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 8),
                          FormWidget(
                            hint: "Alamat",
                            textEditingController:
                                prov.addressTextEditController,
                            prefixIcon: Icon(LineariconsFree.home, size: 20),
                            obscure: false,
                            color: Colors.black,
                            keyboardType: TextInputType.text,
                            maxline: 1,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 10),
                          Divider(),
                          TextButton(
                              child: Text('Ganti password ?', style: TextStyle(color: changePassword == true ? Colors.green : Colors.blueAccent)),
                              onPressed: () {
                                changePassword = !changePassword;
                                print("CHANGE PASSWORD = $changePassword");
                                setState(() {
                                  visible = !visible ;
                                });
                              }
                          ),
                          SizedBox(height: 5),
                          Visibility(
                            visible: visible,
                            child: FormWidget(
                              hint: "Password",
                              prefixIcon: Icon(
                                  LineariconsFree.lock_1,
                                  size: 20),
                              obscure: obscure,
                              textEditingController: prov
                                  .passwordTextEditController,
                              color: Colors.black,
                              keyboardType: TextInputType.text,
                              maxline: 1,
                              textInputAction:
                              TextInputAction.next,
                              icon: IconButton(
                                icon: prov.iconpass,
                                color: prov.iconColor,
                                onPressed: () {
                                  obscure = !obscure;
                                  if(obscure){
                                    iconpass = new IconButton(icon: Icon(Icons.lock_outline, color: LightColor.purpleLight));
                                  } else {
                                    iconpass = new IconButton(icon: Icon(Icons.lock_open_outlined, color: LightColor.green));
                                  }
                                },
                              ),
                            ),
                          ),

                          SizedBox(height: 5)
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
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
                                child: Text(
                                    "Yakin akan menyimpan perubahan data Anda?",
                                    textAlign: TextAlign.center),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    prov.updateProfile(
                                        context,
                                        prov.emailTextEditControlller.text,
                                        prov.noHpTextEditController.text,
                                        prov.addressTextEditController.text,
                                        prov.passwordTextEditController.text);
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
                              "Simpan",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18),
                            )),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}
