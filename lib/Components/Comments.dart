import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String comment, user, time;
  const Comment(
      {super.key,
      required this.comment,
      required this.user,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).colorScheme.secondary,
      ),
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Comment
          Text(comment),
          const SizedBox(height: 5),
          //User , Time
          Row(
            children: [
              Text(
                user,
                style: TextStyle(color: Colors.grey[600]),
              ),
              const Text(" . "),
              Text(
                time,
                style: TextStyle(color: Colors.grey[600]),
              )
            ],
          )
        ],
      ),
    );
  }
}
