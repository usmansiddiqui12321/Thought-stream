import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thought_stream/Components/text_box.dart';
import 'package:thought_stream/Pages/Profile/profilepage_components.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    ProfilePageComponents profileComp = ProfilePageComponents();
    final currentuser = FirebaseAuth.instance.currentUser;
    final profileDataStream = FirebaseFirestore.instance
        .collection('users')
        .doc(currentuser!.email)
        .snapshots();
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text("Profile Page"),
          centerTitle: true,
          toolbarHeight: 80,
        ),
        body: StreamBuilder(
          stream: profileDataStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //get user Data
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              return ListView(
                children: [
                  //profile pic
                  const SizedBox(height: 50),
                  const Icon(Icons.person, size: 72),
                  //user email
                  const SizedBox(height: 10),

                  Text(
                    currentuser.email.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 50),

                  //userDetail
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      "My Details",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  //username
                  UserTextBox(
                      text: userData["username"],
                      sectionName: "username",
                      ontap: () => profileComp.editField(
                          field: 'username', context: context)),
                  // Bio
                  UserTextBox(
                      text: userData['bio'],
                      sectionName: "bio",
                      ontap: () => profileComp.editField(
                          field: 'bio', context: context)),
                  //userPosts
                  const SizedBox(height: 50),

                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      "Posts",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
