import 'dart:ui';

import 'package:absensi_prodi/src/styles/light_color.dart';
import 'package:absensi_prodi/src/styles/theme/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ErrorDialog extends StatelessWidget {
  final String title, description, filledButtonText, outlineButtonText;
  final VoidCallback filledButtonaction;
  final VoidCallback outlineButtonAction;
  final Color outlineTextColor;

  ErrorDialog({
    @required this.title,
    this.description,
    @required this.filledButtonText,
    this.outlineButtonText,
    this.filledButtonaction,
    this.outlineButtonAction,
    this.outlineTextColor
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Consumer<ThemeModel>(
      builder: (context, tm, _){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.only(
                bottom: 16,
                left: 16,
                right: 16,
              ),
              decoration: new BoxDecoration(
                color: tm.isDark? Colors.grey[600] : Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // To make the card compact
                children: <Widget>[
                  SizedBox(height: 30),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: tm.isDark? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14.0,
                        color: tm.isDark? Colors.white :Colors.black54,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(height: 16.0),
                  InkWell(
                    onTap: filledButtonaction,
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            LightColor.unsBlue,
                            Color.fromRGBO(143, 148, 251, .6),
                          ])),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                filledButtonText,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}