import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thought_stream/Components/textfield.dart';
import 'package:thought_stream/Components/wall_post.dart';
import 'package:thought_stream/Pages/Home/post_components.dart';

import '../Authentication/auth_components.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PostComponents postComponents = PostComponents();
  AuthComponents authComponents = AuthComponents();
  final currentuser = FirebaseAuth.instance.currentUser;
  final poststream = FirebaseFirestore.instance
      .collection("User Post")
      .orderBy("timestamp", descending: false)
      .snapshots();
  TextEditingController postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Thoughts Stream"),
        backgroundColor: Colors.grey[900],
        elevation: 0,
        toolbarHeight: 80,
        actions: [
          IconButton(
              onPressed: () {
                authComponents.signOut();
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            //the wall
            Expanded(
              child: StreamBuilder(
                stream: poststream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        //get the message
                        final post = snapshot.data!.docs[index];
                        return WallPost(
                          user: post['useremail'],
                          message: post['message'],
                          postId: post.id,
                          likes: post['likes'],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text("Error ${snapshot.error.toString()}"));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            //postmessage
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Expanded(
                      child: CustomTextField(
                    controller: postController,
                    hinttext: "Write something on the Wall",
                    obscuretext: false,
                  )),
                  //postButton
                  IconButton(
                      onPressed: () {
                        postComponents.postMessage(
                            postControllertxt: postController.text);
                        postController.clear();
                      },
                      icon: const Icon(Icons.send_outlined))
                ],
              ),
            ),
            // logged in as current user
            Text(
              "Logged in as: ${currentuser?.email}!",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
