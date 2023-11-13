import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:saur_customer/screens/profile/profile_screen.dart';
import 'package:saur_customer/screens/request/requests_screen.dart';
import 'package:saur_customer/screens/warrenty/warrenty_screen.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({super.key});
  static const String routePath = '/homeContainer';

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  int _selectedIndex = 0;

  switchTabs(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: getBody(),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => switchTabs(index),
        items: [
          FlashyTabBarItem(
            icon: const Icon(
              Icons.shield_outlined,
            ),
            title: const Text('Guarantee'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.history),
            title: const Text('Request'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.person_outline_outlined),
            title: const Text('Profile'),
          ),
        ],
      ),
    );
  }

  Widget getBody() {
    switch (_selectedIndex) {
      case 0:
        return WarrentyScreen(switchTabs: switchTabs);
      case 1:
        return RequestScreen(switchTabs: switchTabs);
      case 2:
        return const ProfileScreen();
      default:
        return WarrentyScreen(switchTabs: switchTabs);
    }
  }
}
