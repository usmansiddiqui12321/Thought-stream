import 'package:flutter/material.dart';

import '../../Components/custom_button.dart';
import '../../Components/textfield.dart';
import '../../../Backend/Components/auth_components.dart';

class RegisterPage extends StatefulWidget {
  final Function()? ontap;

  const RegisterPage({super.key, this.ontap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  AuthComponents authComponents = AuthComponents();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // * Logo
                const Icon(Icons.lock, size: 100, color: Colors.black),
                const SizedBox(height: 50),

                // * Welcome Back Message
                Text(
                  "Lets Create an Account for you!",
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
                // * Confirm Password TextField
                CustomTextField(
                    controller: confirmpassController,
                    hinttext: "Confirm Password",
                    obscuretext: true),
                const SizedBox(height: 10),
                // * Sign in Button
                CustomButton(
                    text: "Sign Up",
                    ontap: () {
                      authComponents.signUp(
                          confirmpassword: confirmpassController.text,
                          context: context,
                          email: emailController.text,
                          password: passController.text);
                    }),
                const SizedBox(height: 25),

                // * Goto Register Page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an Account?",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.ontap,
                      child: const Text("Login here",
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
