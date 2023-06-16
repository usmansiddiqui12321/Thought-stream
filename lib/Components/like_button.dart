import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final bool isliked;
  final Function()? ontap;
  const LikeButton({super.key, this.ontap, required this.isliked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ontap,
        child: isliked
            ? const Icon(
                Icons.favorite,
                color: Colors.red,
              )
            : const Icon(
                Icons.favorite_border_outlined,
                color: Colors.black,
              ));
  }
}
