import 'package:flutter/material.dart';
 

class CustomElevatedButton extends StatelessWidget {
  final void Function() onTap;
  final String label;
  final double height;
  final double width;
  final Color color;
  final Color labelColor;

  const CustomElevatedButton({
    Key key,
     this.onTap,
    this.label,
    this.width = double.infinity,
    this.height = 45.0,
    this.color = Colors.blueAccent,
    this.labelColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: width,
      height: height,
      // Raised Button Deprecated
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
        child: Text(
          label,
          style: theme.textTheme.button.copyWith(color: labelColor),
        ),
      ),
    );
  }
}
