import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key,
      required this.textStyle,
      required this.text,
      required this.onPressed});

  final TextStyle textStyle;
  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(0),
      height: 0,
      minWidth: 0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
