import 'package:flutter/material.dart';
import 'package:thought_stream/Pages/login_screen.dart';
import 'package:thought_stream/Pages/regiester_screen.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // ! Initially Show login Page
  bool showLoginPage = true;
  // toggle between pages
  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        ontap: togglePage,
      );
    } else {
      return RegisterPage(
        ontap: togglePage,
      );
    }
  }
}
