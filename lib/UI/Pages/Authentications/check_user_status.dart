import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/UI/Pages/Authentications/loginpage.dart';
import 'package:ad_brokers/UI/Widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

class CheckUserLoginStatus extends StatefulWidget {
  const CheckUserLoginStatus({super.key});

  @override
  State<CheckUserLoginStatus> createState() => _CheckUserLoginStatusState();
}

class _CheckUserLoginStatusState extends State<CheckUserLoginStatus> {
  bool isUserLoggedin = false;

  getLoginStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          isUserLoggedin = value;
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
      body: isUserLoggedin ? const NavigationBarTemplate() : const LoginPage(),
    );
  }
}
