
import 'package:absensi_prodi/src/styles/light_color.dart';
import 'package:flutter/material.dart';

class IconBadge extends StatefulWidget {

  final IconData icon;
  final double size;
  final String count;

  IconBadge({Key key, @required this.icon, @required this.size, @required this.count})
      : super(key: key);


  @override
  _IconBadgeState createState() => _IconBadgeState();
}

class _IconBadgeState extends State<IconBadge> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Icon(
          widget.icon,
          size: widget.size,
        ),

        widget.count == null ? labelNull()
         : labelNotNull()

      ],
    );
  }

  Widget labelNull (){
    return Positioned(
      right: 0.0,
      child: Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: LightColor.purpleLight,
          borderRadius: BorderRadius.circular(6),
        ),
        constraints: BoxConstraints(
          minWidth: 13,
          minHeight: 13,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 1),

          child: Text(
            "0",
            style: TextStyle(
              color: Colors.white,
              fontSize: 8,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget labelNotNull (){
    return Positioned(
      right: 0.0,
      child: Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: LightColor.purpleLight,
          borderRadius: BorderRadius.circular(6),
        ),
        constraints: BoxConstraints(
          minWidth: 13,
          minHeight: 13,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 1),

          child: Text(
            widget.count,
            style: TextStyle(
              color: Colors.white,
              fontSize: 8,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
