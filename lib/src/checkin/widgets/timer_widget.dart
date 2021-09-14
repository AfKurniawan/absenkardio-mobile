
import 'package:absensi_prodi/src/styles/light_color.dart';
import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({
    Key key,
    @required String dateString,
    @required String timeString,
  }) : _dateString = dateString, _timeString = timeString, super(key: key);

  final String _dateString;
  final String _timeString;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [
            LightColor.unsBlue,
            Color.fromRGBO(143, 148, 251, .6),
          ])),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("$_dateString",
                style: TextStyle(
                    fontSize: 20, color: Colors.white)),
            Text("$_timeString",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))
          ],
        ),
      ),
    );
  }
}