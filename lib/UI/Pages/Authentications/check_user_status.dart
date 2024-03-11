import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/UI/Pages/Visitors/visiters_home_page.dart';
import 'package:ad_brokers/UI/Widgets/adv_navigation_bar.dart';
import 'package:ad_brokers/UI/Widgets/pub_navigation_bar.dart';
import 'package:flutter/material.dart';

class CheckUserLoginStatus extends StatefulWidget {
  const CheckUserLoginStatus({super.key});

  @override
  State<CheckUserLoginStatus> createState() => _CheckUserLoginStatusState();
}

class _CheckUserLoginStatusState extends State<CheckUserLoginStatus> {
  bool isUserLoggedin = false;
  String userRole = "";

  getLoginStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          isUserLoggedin = value;
        });
      }
    });
    await HelperFunctions.getUserRoleFromSF().then((value) {
      if (value != null) {
        setState(() {
          userRole = value;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isUserLoggedin == true
          ? userRole == "Advertiser"
              ? const AdvNavigationBarTemplate()
              : const PubNavigationBarTemplate()
          : const VisitorSideHomePage(),
      // body: isUserLoggedin ? const NavigationBarTemplate() : const LoginPage(),
    );
  }
}
