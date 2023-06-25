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
        title: Text(
          "Edit $field",
        ),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Enter new $field",
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
    if (newvalue.trim().isNotEmpty) {
      //only update if something in Textfield
      await usersCollection.doc(currentUser!.email).update({field: newvalue});
    }
  }
}
