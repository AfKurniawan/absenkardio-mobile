import 'package:absensi_prodi/src/styles/light_color.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {

  final VoidCallback btnAction;
  final String btnText;
  final Icon myIcon;

  ButtonWidget({
    @required this.btnAction,
    @required this.btnText,
    this.myIcon
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: btnAction,
      splashColor: Color.fromRGBO(143, 148, 251, 1),
      child: Container(
        height: 60,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  btnText,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
