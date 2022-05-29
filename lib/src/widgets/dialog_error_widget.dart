
import 'package:absensi_prodi/src/configs/app_config.dart';
import 'package:absensi_prodi/src/styles/light_color.dart';
import 'package:absensi_prodi/src/styles/theme/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDialogError extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;
  final VoidCallback btnOkeAction;

  CustomDialogError({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
    this.btnOkeAction
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, tm, _){
        return Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: 54,
                bottom: 14,
                left: 14,
                right: 14,
              ),
              margin: EdgeInsets.only(top: Consts.avatarRadius),
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(Consts.padding),
                boxShadow: [
                  BoxShadow(
                    // color: Theme.of(context).primaryColorDark,
                    color: Colors.transparent,
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,// To make the card compact
                children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black45
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: btnOkeAction,
                      child: Text(buttonText, style: TextStyle(color: Colors.blueAccent)),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              left: 14,
              right: 14,
              top: 0,
              child: CircleAvatar(
                child: Image.asset(
                  'assets/icons/icon_failed.png',
                  width: 70,
                  color: Colors.white54,
                ),
                backgroundColor: LightColor.purpleLight,
                radius: 50,
              ),
            ),
          ],
        );
      }
    );
  }
}