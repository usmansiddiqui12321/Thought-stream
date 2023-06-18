import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePageComponents {
  //Current User
  final currentUser = FirebaseAuth.instance.currentUser;
  //All Users
  final usersCollection = FirebaseFirestore.instance.collection('users');
  Future<void> editField(
      {required String field, required BuildContext context}) async {
    String newvalue = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Edit $field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newvalue = value;
          },
        ),
        actions: [
          //Cancel Button
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),

          //Save Button
          TextButton(
              onPressed: () => Navigator.of(context).pop(newvalue),
              child: const Text("save")),
        ],
      ),
    );
    //Update FireStore
    if (newvalue.trim().length > 0) {
      //only update if something in Textfield
      await usersCollection.doc(currentUser!.email).update({field: newvalue});
    }
  }
}
