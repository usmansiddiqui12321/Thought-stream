import 'package:flutter/material.dart';
import 'package:thought_stream/Frontend/Components/custom_button.dart';
import 'package:thought_stream/Frontend/Components/textfield.dart';
import 'package:thought_stream/Backend/Components/auth_components.dart';

import '../../Components/GlobalComponents.dart';

class LoginPage extends StatefulWidget {
  final Function()? ontap;
  const LoginPage({super.key, this.ontap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  GlobalComponents comp = GlobalComponents();

  AuthComponents authComponents = AuthComponents();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // * Logo
                const Icon(Icons.lock, size: 100),
                const SizedBox(height: 50),

                // * Welcome Back Message
                Text(
                  "Welcome Back, you've been missed!",
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(height: 25),

                // * email TextField
                CustomTextField(
                    controller: emailController,
                    hinttext: "email",
                    obscuretext: false),
                const SizedBox(height: 10),

                // * Password TextField
                CustomTextField(
                    controller: passController,
                    hinttext: "Password",
                    obscuretext: true),
                const SizedBox(height: 10),

                // * Sign in Button
                CustomButton(
                    text: "Login",
                    ontap: () {
                      authComponents.signIn(
                          email: emailController.text,
                          password: passController.text,
                          context: context);
                    }),
                const SizedBox(height: 25),

                // * Goto Register Page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a Member?",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.ontap,
                      child: const Text("Register Now",
                          style: TextStyle(color: Colors.blue)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
