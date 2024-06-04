import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required TextEditingController controller,
    required this.borderRadius,
    required this.borderWidth,
    required this.borderColor,
  }) : _controller = controller;

  final TextEditingController _controller;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
              width: borderWidth, color: borderColor, style: BorderStyle.solid),
        ),
        hintText: 'Masukkan Title Baru',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
              width: 2.0, color: Colors.blue, style: BorderStyle.solid),
        ),
      ),
    );
  }
}
