import 'package:ad_brokers/UI/Pages/Advertisers/adv_chat_page.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/adv_home_page.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/adv_profile_page.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/my_ads_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdvNavigationBarTemplate extends StatefulWidget {
  const AdvNavigationBarTemplate({super.key});

  @override
  State<AdvNavigationBarTemplate> createState() =>
      _AdvNavigationBarTemplateState();
}

class _AdvNavigationBarTemplateState extends State<AdvNavigationBarTemplate> {
  int myIndex = 0;
  List<Widget> PageList = [
    const AdvHomePage(),
    const MyAdsPage(),
    const AdvChatPage(),
    const AdvProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: myIndex,
        children: PageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
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
    );
  }
}
