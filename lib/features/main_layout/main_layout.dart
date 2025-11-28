import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'appointment/appointment_screen.dart';
import 'home/home_screen.dart';
import 'messages/messages_screen.dart';
import 'profile/profile_screen.dart';
import 'settings/settings_screen.dart';

class MainLayout extends StatefulWidget {
  static const String routeName = "MainLayout";

  final int selectedIndex;
  const MainLayout({super.key, this.selectedIndex = 0});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int currentIndex;

  final List<Widget> tabs = [
    const HomeScreen(),
    const MessagesScreen(),
    const AppointmentScreen(),
    const SettingsScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.selectedIndex;
  }

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
              unselectedItemColor: const Color.fromRGBO(51, 51, 51, 1),
              showSelectedLabels: false,
              showUnselectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/images/home_icon.svg",
                      height: 24,
                      width: 24,
                      color: currentIndex == 0 ? Colors.blueAccent : Color.fromRGBO(51, 51, 51, 1),
                    ),
                    label: '',
                  ),

                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/images/message-text_icon.svg",
                      height: 24,
                      width: 24,
                      color: currentIndex == 1 ? Colors.blueAccent :Color.fromRGBO(51, 51, 51, 1)
                    ),
                    label: '',
                  ),

                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/images/calendar_icon.svg",
                      height: 24,
                      width: 24,
                      color: currentIndex == 2 ? Colors.blueAccent : Color.fromRGBO(51, 51, 51, 1)
                    ),
                    label: '',
                  ),

                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/images/settings_icon.svg",
                      height: 24,
                      width: 24,
                      color: currentIndex == 3 ? Colors.blueAccent : Color.fromRGBO(51, 51, 51, 1)
                    ),
                    label: '',
                  ),

                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                      color: currentIndex == 4 ? Colors.blueAccent : Color.fromRGBO(51, 51, 51, 1)
                    ),
                    label: '',
                  ),
                ]

            ),
          ),
        ),
      ),
    );
  }
}
