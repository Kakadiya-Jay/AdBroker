import 'package:ad_brokers/UI/Pages/Publishers/pub_chat_page.dart';
import 'package:ad_brokers/UI/Pages/Publishers/pub_home_page.dart';
import 'package:ad_brokers/UI/Pages/Publishers/pub_profile_page.dart';
import 'package:ad_brokers/UI/Pages/Publishers/pub_profit_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PubNavigationBarTemplate extends StatefulWidget {
  const PubNavigationBarTemplate({super.key});

  @override
  State<PubNavigationBarTemplate> createState() => _PubNavigationBarTemplateState();
}

class _PubNavigationBarTemplateState extends State<PubNavigationBarTemplate> {
  int myIndex = 0;
  List<Widget> pageList = [
    const PubHomePage(),
    const ProfitPage(),
    const PubChatPage(),
    const PubProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: myIndex,
        children: pageList,
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
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 134, 159, 173),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.money_dollar_circle),
            label: "Profit",
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
