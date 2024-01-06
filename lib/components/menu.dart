import 'package:flutter/material.dart';
import 'package:groceryapp/components/my_list_tile.dart';
import 'package:groceryapp/pages/notepad_page.dart';


class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;

  const MyDrawer({
    Key? key,
    required this.onProfileTap,
    required this.onSignOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // header
              const DrawerHeader(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 64,
                ),
              ),

              // home list title
              MyListTile(
                icon: Icons.home,
                text: 'H O M E',
                onTap: () => Navigator.pop(context),
              ),

              // profile list tile
              MyListTile(
                icon: Icons.person,
                text: 'D E V E L O P E R',
                onTap: onProfileTap,
              ),

              // Notepad list tile
              MyListTile(
                icon: Icons.assignment,
                text: 'N O T E P A D',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotesPage(), // Navigate to NotepadScreen
                    ),
                  );
                },
              ),
            ],
          ),

          // logout list tile
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyListTile(
              icon: Icons.logout,
              text: 'L O G O U T',
              onTap: onSignOut,
            ),
          ),
        ],
      ),
    );
  }
}
