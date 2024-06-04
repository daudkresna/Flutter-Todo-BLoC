import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color? color;
  final String text;
  final void Function()? onPressed;
  const MyButton({super.key, this.color, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      color: color,
    );
  }
}
