import 'package:absensi_prodi/src/styles/light_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';

class MyAnalogClockWidget extends StatefulWidget {
  const MyAnalogClockWidget({Key key}) : super(key: key);

  @override
  _MyAnalogClockWidgetState createState() => _MyAnalogClockWidgetState();
}

class _MyAnalogClockWidgetState extends State<MyAnalogClockWidget> {
  @override
  Widget build(BuildContext context) {
    return FlutterAnalogClock(
      hourHandColor: Colors.red,
      minuteHandColor: Colors.green,
      tickColor: Colors.green,
      numberColor: Colors.blue,
      borderColor: LightColor.purple,
      height: 100,
    );
  }
}
