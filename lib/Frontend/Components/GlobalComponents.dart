import 'package:flutter/material.dart';

class GlobalComponents {
  void displayMessage(
      {required String message, required BuildContext context}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(message),
            ));
  }

  void loadingCircle(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
