import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thought_stream/Pages/Profile/profile_page.dart';

class HomePageComponents {
  final currentuser = FirebaseAuth.instance.currentUser;
  final userPost = FirebaseFirestore.instance.collection("User Post");
  void postMessage({required String postControllertxt}) {
    //only post IF there is something in field
    if (postControllertxt.isNotEmpty) {
      //store in firebase
      userPost.add({
        "useremail": currentuser?.email,
        "message": postControllertxt,
        "timestamp": Timestamp.now(),
        "likes": []
      });
    }
  }

  void gotoProfile(BuildContext context) {
    // pop menu drawer
    Navigator.pop(context);
    //new page
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ProfilePage()));
  }
}
