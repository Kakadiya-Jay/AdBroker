import 'package:ad_brokers/UI/Pages/Advertisers/adv_home_page.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/adv_profile_page.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/adv_total_expense_page.dart';
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
  List<Widget> pageList = [
    const AdvHomePage(),
    const MyAdsPage(),
    const AdvTotalExpansePage(),
    const AdvProfilePage(),
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
            icon: ImageIcon(
              AssetImage("assets/icons/Expense.png"),
            ),
            label: "Expanse",
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
