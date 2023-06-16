import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text("Profile Page"),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 80,
      ),
    body: Column(children: [
       //profile pic
       
       //user email
       
       //userDetail

       //username

       // Bio

       //userPosts

       
    ],),
    );
  }
}
