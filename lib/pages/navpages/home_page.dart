import 'package:flutter/material.dart';
import 'package:zipaquira_2/pages/navpages/Profile_page.dart';
import 'package:zipaquira_2/pages/navpages/bumf_page.dart';
import 'package:zipaquira_2/pages/navpages/main_page.dart';
import 'package:zipaquira_2/pages/navpages/notifications_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List pages = [MainPage(), BumfPage(), NotificationsPage(), ProfilePage()];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          unselectedFontSize: 13,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: "Bumf", icon: Icon(Icons.date_range_sharp)),
            BottomNavigationBarItem(label: "Notifications",icon: Icon(Icons.notification_add_rounded)),
            BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.person_2_sharp)),
          ]),
    );
  }
}
