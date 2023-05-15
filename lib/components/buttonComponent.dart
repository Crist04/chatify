import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ButtonComponent extends StatelessWidget {
  ButtonComponent(
      {super.key,
      required this.buttonColor,
      required this.buttonText,
      required this.onPressed});
  Color buttonColor;
  String buttonText;
 Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: buttonColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            buttonText.toString(),
          ),
        ),
      ),
    );
  }
}
