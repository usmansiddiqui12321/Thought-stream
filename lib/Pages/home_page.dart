import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thought_stream/Components/textfield.dart';

import '../Components/GlobalComponents.dart';
import 'Authentication/auth_components.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthComponents authComponents = AuthComponents();
  final currentuser = FirebaseAuth.instance.currentUser;
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
                      onPressed: () {}, icon: const Icon(Icons.send_outlined))
                ],
              ),
            ),
            // logged in as current user
            Text("Logged in as: ${currentuser?.email}!")
          ],
        ),
      ),
    );
  }
}
