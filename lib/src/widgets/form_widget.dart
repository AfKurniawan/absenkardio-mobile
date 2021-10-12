import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {

  FocusNode focusNode = FocusNode();
  TextEditingController textEditingController;
  String hint;
  bool obscure;
  TextInputType keyboardType;
  ValueChanged<String> onsubmit;
  TextInputAction textInputAction;
  FormFieldValidator<String> validator;
  IconButton icon;
  Icon prefixIcon;
  int maxline;
  Color color;

  FormWidget({
    @required this.textEditingController,
    @required this.hint,
    this.color,
    this.obscure,
    this.keyboardType,
    this.focusNode,
    this.onsubmit,
    this.textInputAction,
    this.validator,
    this.icon,
    this.prefixIcon,
    this.maxline
  
  });
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: textEditingController,
      keyboardType: keyboardType,
      maxLines: maxline,
      textInputAction: TextInputAction.done,
      obscureText: obscure,
      focusNode: focusNode,
      style: TextStyle(color: color),
      onFieldSubmitted: onsubmit,
      decoration: InputDecoration(
        suffixIcon: icon,
          prefixIcon: prefixIcon,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[600], width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400], width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red[300], width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red[300], width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400])),
    );
  //formPhone(context);
  }
}
