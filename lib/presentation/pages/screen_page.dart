import 'package:fic4_flutter_auth/data/shared/theme.dart';
import 'package:fic4_flutter_auth/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'info_page.dart';

class ScreenPage extends StatefulWidget {
  const ScreenPage({super.key});

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    InfoPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    // _checkAccount();

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: kGreenColor,
        elevation: 5,
        animationDuration: const Duration(milliseconds: 500),
        // labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_filled),
            label: 'Home',
            selectedIcon: Icon(Icons.home_filled, color: kWhiteColor),
          ),
          NavigationDestination(
            icon: const Icon(Icons.info_outline),
            label: 'Info',
            selectedIcon: Icon(Icons.info, color: kWhiteColor),
          ),
          NavigationDestination(
            icon: const Icon(Icons.person),
            label: 'Profile',
            selectedIcon: Icon(Icons.person, color: kWhiteColor),
          ),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
