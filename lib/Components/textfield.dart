import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  final bool obscuretext;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hinttext,
      required this.obscuretext});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscuretext,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        fillColor: Colors.grey.shade200,
        hintText: hinttext,
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[500]),
      ),
    );
  }
}
