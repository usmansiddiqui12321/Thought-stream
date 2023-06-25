import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thought_stream/Database/Components/homapage_components.dart';


class WallProvider extends ChangeNotifier {
  HomePageComponents postcomp = HomePageComponents();

  final Map<String, bool> _likedPosts =
      {}; // Map to store like status for each post

  Map<String, bool> get likedPosts => _likedPosts;

  void setLikeStatus(String postID, bool isLiked) {
    _likedPosts[postID] = isLiked;
    notifyListeners();
  }

  bool isPostLiked(String postID) {
    return _likedPosts[postID] ?? false;
  }

  void toggleLike({required String postID}) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final isLiked = isPostLiked(postID);
    setLikeStatus(postID, !isLiked);

    DocumentReference postRef =
        FirebaseFirestore.instance.collection('userpost').doc(postID);
    if (!isLiked) {
      // If post is not liked, add user's email to likes array field
      postRef.update({
        'likes': FieldValue.arrayUnion([currentUser?.email]),
      });
    } else {
      // If it is liked, remove user's email from likes array field
      postRef.update({
        'likes': FieldValue.arrayRemove([currentUser?.email]),
      });
    }
  }
}
