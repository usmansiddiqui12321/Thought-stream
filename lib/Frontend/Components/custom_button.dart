import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? ontap;
  final String text;
  const CustomButton({super.key, this.ontap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Text(
          text,
          style: TextStyle(color: Colors.grey[200]),
        )),
      ),
    );
  }
}
