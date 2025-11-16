import 'package:flutter/material.dart';
import 'package:health_care_project/features/main_layout/profile/profile_screen.dart';
import 'package:health_care_project/features/main_layout/settings/settings_screen.dart';
import 'appointment/appointment_screen.dart';
import 'home/home_screen.dart';
import 'messages/messages_screen.dart';

class MainLayout extends StatefulWidget {
  static const String routeName="MainLayout";
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;

  final List<Widget> tabs = [
    const HomeScreen(),
    const MessagesScreen(),
    const AppointmentScreen(),
    const SettingsScreen(),
    const ProfileScreen(),
  ];

  void changeSelectedIndex(int selectedIndex) {
    setState(() {
      currentIndex = selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: changeSelectedIndex,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.blueAccent,
              unselectedItemColor: Color.fromRGBO(51, 51, 51, 1),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/images/home_icon.png")),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/images/message-text_icon.png")),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/images/calendar_icon.png")),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage("assets/images/settings_icon.png")),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
