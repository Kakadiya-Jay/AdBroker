// ignore_for_file: non_constant_identifier_names

import 'package:ad_brokers/UI/Pages/chat_page.dart';
import 'package:ad_brokers/UI/Pages/home_page.dart';
import 'package:ad_brokers/UI/Pages/profile_page.dart';
import 'package:ad_brokers/UI/Pages/my_ads_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationBarTemplate extends StatefulWidget {
  const NavigationBarTemplate({super.key});

  @override
  State<NavigationBarTemplate> createState() => _NavigationBarTemplateState();
}

class _NavigationBarTemplateState extends State<NavigationBarTemplate> {
  int myIndex = 0;
  List<Widget> PageList = [
    const HomePage(),
    const MyAdsPage(),
    const ChatPage(),
    const ProfilePage(),
  ];
  final gradient_background = const LinearGradient(
    begin: Alignment(0.00, -1.00),
    end: Alignment(0, 1),
    colors: [Color(0xFF163648), Color(0xFF155E6A), Color(0xFF158188)],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: myIndex,
        children: PageList,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFF163648), Color(0xFF155E6A), Color(0xFF158188)],
          ),
        ),
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          currentIndex: myIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF3C096C),
          // backgroundColor: const Color(0xff163648),
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color.fromARGB(255, 134, 159, 173),
          items: const [
            BottomNavigationBarItem(
              // icon: ImageIcon(
              //   AssetImage("assets/Images/P_Icon.png"),
              // ),
              icon: Icon(CupertinoIcons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/icons/ads_icon.png"),
              ),
              label: "My Ads",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: "Chat",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
