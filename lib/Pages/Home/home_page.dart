import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thought_stream/Components/drawer.dart';
import 'package:thought_stream/Components/textfield.dart';
import 'package:thought_stream/Components/wall_post.dart';
import 'package:thought_stream/Pages/Home/homapage_components.dart';
import 'package:thought_stream/helper/helper_method.dart';

import '../Authentication/auth_components.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageComponents postComponents = HomePageComponents();
  AuthComponents authComponents = AuthComponents();
  final commentController = TextEditingController();
  final currentuser = FirebaseAuth.instance.currentUser;
  final poststream = FirebaseFirestore.instance
      .collection("userpost")
      .orderBy("timestamp", descending: true)
      .snapshots();
  TextEditingController postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Thoughts Stream"),

        elevation: 0,
        toolbarHeight: 80,
        centerTitle: true,
      ),
      drawer: CustomDrawer(
        onProfileTap: () {
          postComponents.gotoProfile(context);
        },
        onSignOutTap: () {
          authComponents.signOut();
        },
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
                          commentController: commentController,
                          user: post['useremail'],
                          message: post['message'],
                          postId: post.id,
                          likes: post['likes'],
                          time: formatDate(post['timestamp']),
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
