import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thought_stream/Components/GlobalComponents.dart';

class AuthComponents {
  GlobalComponents comp = GlobalComponents();

  //SignIn With Firebase
  FirebaseAuth auth = FirebaseAuth.instance;
  void signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    comp.loadingCircle(context);
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // pop Loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop Loading circle
      Navigator.pop(context);
      comp.displayMessage(message: e.code, context: context);
    }
  }

  //SignOut With Firebase
  void signOut() async {
    await auth.signOut();
  }

  //SignUp With Firebase
  void signUp(
      {required String email,
      required String password,
      required String confirmpassword,
      required BuildContext context}) async {
    //show loading circle
    comp.loadingCircle(context);
    //make sure pass match
    if (password != confirmpassword) {
      Navigator.pop(context);
      //show Error to User
      comp.displayMessage(message: "Passwords don't match!", context: context);
    } else {
      try {
        await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        comp.displayMessage(context: context, message: e.code);
      }
    }
  }
}
