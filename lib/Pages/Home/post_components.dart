import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostComponents {
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
  
}
