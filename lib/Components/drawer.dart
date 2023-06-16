import 'package:flutter/material.dart';
import 'package:thought_stream/Components/custom_list_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key,required this.onProfileTap,required this.onSignOutTap});
  final void Function() onProfileTap;
  final void Function() onSignOutTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        children: [
          //header
          const DrawerHeader(
              child: Icon(
            Icons.person,
            color: Colors.white,
            size: 64,
          )),
          //Home List Tile
          CustomListTile(
            onTap: () {
              Navigator.pop(context);
            },
            icon: Icons.home,
            text: "H O M E",
          ),
          //profile list tile
          CustomListTile(
            onTap: onProfileTap,
            icon: Icons.home,
            text: "P R O F I L E",
          ),
          // logout
          CustomListTile(
            onTap: onSignOutTap,
            icon: Icons.home,
            text: "L O G O U T",
          ),
        ],
      ),
    );
  }
}
