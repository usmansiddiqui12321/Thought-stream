import 'package:flutter/material.dart';

class UserTextBox extends StatelessWidget {
  final String text, sectionName;
  final void Function()? ontap;
  const UserTextBox(
      {super.key, required this.text, required this.sectionName, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //section name
              Text(sectionName, style: TextStyle(color: Colors.grey[500])),
              IconButton(
                  onPressed: ontap,
                  icon: Icon(
                    Icons.settings,
                    color: Colors.grey[500],
                  ))
            ],
          ),
          //text
          Text(text)
        ],
      ),
    );
  }
}
