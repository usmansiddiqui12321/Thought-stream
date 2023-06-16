import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thought_stream/Components/like_button.dart';
import 'package:thought_stream/Providers/wall_provider.dart';

class WallPost extends StatefulWidget {
  final String user, message, postId;
  final List<dynamic> likes;

  const WallPost({
    Key? key,
    required this.user,
    required this.message,
    required this.postId,
    required this.likes,
  }) : super(key: key);

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<WallProvider>(context, listen: false).setLikeStatus(
          widget.postId, widget.likes.contains(currentUser!.email));
    });
  }

  @override
  Widget build(BuildContext context) {
    // final wallProvider = Provider.of<WallProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Column(
            children: [
              // profile picture
              // Container(
              // decoration:
              // BoxDecoration(shape: BoxShape.circle, color: Colors.grey[400]),
              // padding: const EdgeInsets.all(10),
              // child: const Icon(Icons.person),
              // ),
              // *Liked Button with counter
              Consumer<WallProvider>(
                builder: (context, value, child) {
                  final isLiked = value.isPostLiked(widget.postId);
                  return LikeButton(
                    isliked: isLiked,
                    ontap: () {
                      value.toggleLike(postID: widget.postId);
                    },
                  );
                },
              ),
              const SizedBox(height: 5),
              Text(widget.likes.length.toString()), // Like count
            ],
          ),
          const SizedBox(width: 20),
          //  *Post data
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user,
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
              const SizedBox(height: 10),
              Text(widget.message),
            ],
          )
        ],
      ),
    );
  }
}
