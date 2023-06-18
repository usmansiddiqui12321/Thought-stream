import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:thought_stream/Pages/Profile/profile_page.dart';

class HomePageComponents {
  final currentuser = FirebaseAuth.instance.currentUser;
  final userPost = FirebaseFirestore.instance.collection("userpost");
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

  //add a comment
  void addComment({
    required postID,
    required String commenttext,
  }) {
    //write the comment to Firestore under Comment Collection for post
    userPost.doc(postID).collection("comments").add({
      "commenttext": commenttext,
      "commentby": currentuser!.email,
      "commenttime": Timestamp.now(), // remember to format when display
    });
  }

  //Show Dialog Box for adding Comment
  void showCommentDialogBox(
      {required BuildContext context,
      required String postID,
      required TextEditingController commentController}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Comment"),
        content: TextField(
          controller: commentController,
          decoration: const InputDecoration(hintText: "Write a comment.."),
        ),
        actions: [
          //cancelbutton
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                commentController.clear();
              },
              child: const Text("cancle")),
          //savebutton
          TextButton(
              onPressed: () {
                addComment(postID: postID, commenttext: commentController.text);
                Navigator.pop(context);
                commentController.clear();
              },
              child: const Text("post")),
        ],
      ),
    );
  }
}
