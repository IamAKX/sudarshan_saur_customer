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
  int _selectedIndex = 1;

  switchTabs(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        elevation: 10,
        onTap: (index) => switchTabs(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shield_outlined,
            ),
            label: ('Guarantee'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: ('Request'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined),
              label: 'Profile'),
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
