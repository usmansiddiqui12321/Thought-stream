import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thought_stream/Components/Comments.dart';
import 'package:thought_stream/Components/comment_button.dart';
import 'package:thought_stream/Components/delete_button.dart';
import 'package:thought_stream/Components/like_button.dart';
import 'package:thought_stream/Pages/Home/homapage_components.dart';
import 'package:thought_stream/Providers/wall_provider.dart';
import 'package:thought_stream/helper/helper_method.dart';

class WallPost extends StatefulWidget {
  final String user, message, postId, time;
  final List<dynamic> likes;
  final TextEditingController commentController;
  const WallPost({
    Key? key,
    required this.user,
    required this.message,
    required this.postId,
    required this.likes,
    required this.commentController,
    required this.time,
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
    HomePageComponents homecomp = HomePageComponents();
    final commentsStream = FirebaseFirestore.instance
        .collection('userpost')
        .doc(widget.postId)
        .collection('comments')
        .orderBy("commenttime", descending: true)
        .snapshots();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  *Post data
          // wall post
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Group of text ("message + userEmail")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // message
                  Text(widget.message),
                  const SizedBox(height: 5),

                  //user
                  Row(
                    children: [
                      Text(
                        widget.user,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const Text(" . "),
                      Text(
                        widget.time,
                        style: TextStyle(color: Colors.grey[600]),
                      )
                    ],
                  )
                ],
              ),
              // Delete Button
              if (widget.user == currentUser!.email)
                DeleteButton(
                  onTap: () {
                    homecomp.deletePost(
                        context: context, postID: widget.postId);
                  },
                )
            ],
          ),
          const SizedBox(height: 20),

          //Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Like
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
                  Text(
                    widget.likes.length.toString(),
                    style: const TextStyle(color: Colors.grey),
                  ), // Like count
                ],
              ),
              const SizedBox(width: 10),
              //comment
              Column(
                children: [
                  //CommentButton here
                  CommentButton(onTap: () {
                    homecomp.showCommentDialogBox(
                        context: context,
                        postID: widget.postId,
                        commentController: widget.commentController);
                  }),

                  const SizedBox(height: 5),
                  // Comment count
                  const Text(
                    '0',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
// comments under post

          StreamBuilder<QuerySnapshot>(
            stream: commentsStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final commentDocs = snapshot.data!.docs;
              final commentWidgets = commentDocs.map((doc) {
                final commentData = doc.data() as Map<String, dynamic>;
                return Comment(
                  comment: commentData['commenttext'],
                  user: commentData['commentby'],
                  time: formatDate(commentData['commenttime']),
                );
              }).toList();

              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: commentWidgets,
              );
            },
          ),
        ],
      ),
    );
  }
}
