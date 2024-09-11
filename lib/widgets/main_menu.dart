import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timer_app/auth/auth_service.dart';
import 'package:timer_app/pages/toggle_page.dart';
import 'package:timer_app/utils/clamp_text.dart';
import 'package:timer_app/widgets/menu_item.dart';

// This is the type used by the popup menu below.
enum SampleItem { stats, settings, logout }

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  SampleItem? selectedItem;
  bool isOpened = false;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SampleItem>(
      //icon: const Icon(Icons.menu_open),
      onOpened: () {
        setState(() {
          isOpened = true;
        });
      },
      onCanceled: () {
        setState(() {
          isOpened = false;
        });
      },
      icon: Container(
        //width: 180,
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
        decoration: BoxDecoration(
            color: Colors.white.withAlpha(255),
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage(""),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              clampText(
                  Supabase.instance.client.auth.currentUser
                          ?.userMetadata?['display_name'] ??
                      "",
                  15),
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87),
            ),
            const SizedBox(width: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                isOpened ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: Colors.black54,
                size: 22,
              ),
            )
          ],
        ),
      ),

      offset: const Offset(0, 50),
      color: Colors.white,
      iconColor: Colors.white70,
      iconSize: 30,

      //initialValue: selectedItem,
      onSelected: (SampleItem item) {
        setState(() {
          selectedItem = item;
        });
        switch (item) {
          case SampleItem.stats:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TogglePage(
                          page: 0,
                        )));
          case SampleItem.settings:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TogglePage(page: 1)));
          case SampleItem.logout:
            var authSevice = AuthService();
            authSevice.signOut();
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
        const PopupMenuItem<SampleItem>(
          value: SampleItem.stats,
          child: MenuItem(text: "Stats", icon: Icons.bar_chart),
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.settings,
          child: MenuItem(icon: Icons.settings, text: "Settings"),
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.logout,
          child: MenuItem(icon: Icons.logout, text: "Logout"),
        ),
      ],
    );
  }
}
