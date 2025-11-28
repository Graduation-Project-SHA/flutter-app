import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../patient/main_layout/messages/messages_screen.dart';
import 'doctor_appointment/doctor_appointment_screen.dart';
import 'doctor_home/doctor_home_screen.dart';
import 'doctor_messages/doctor_messages_screen.dart';
import 'doctor_profile/doctor_profile_screen.dart';
import 'doctor_settings/doctor_settings_screen.dart';


class DoctorMainLayout extends StatefulWidget {
  static const String routeName = "DoctorMainLayout";

  final int selectedIndex;
  const DoctorMainLayout({super.key, this.selectedIndex = 0});

  @override
  State<DoctorMainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<DoctorMainLayout> {
  late int currentIndex;

  final List<Widget> tabs = [
    const DoctorHomeScreen(),
    const DoctorMessagesScreen(),
    const DoctorAppointmentScreen(),
    const DoctorSettingsScreen(),
    const DoctorProfileScreen(),
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
