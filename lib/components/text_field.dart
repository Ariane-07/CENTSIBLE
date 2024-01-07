import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.black // Text color in dark mode
            : Colors.black, // Text color in light mode
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white54 // Hint text color in dark mode
              : Colors.grey[600], // Hint text color in light mode
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white // Border color in dark mode
                : Colors.grey[400]!, // Border color in light mode
          ),
        ),
      ),
    );
  }
}