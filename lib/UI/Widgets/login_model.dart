import 'package:ad_brokers/UI/Pages/Authentications/adv_loginpage.dart';
import 'package:ad_brokers/UI/Pages/Authentications/pub_loginpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginModel extends StatelessWidget {
  const LoginModel({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          builder: (context) {
            return Wrap(
              children: [
                ListTile(
                  leading: Icon(
                    CupertinoIcons.person,
                    color: Theme.of(context).shadowColor,
                  ),
                  title: Text(
                    "Login As Advertiser",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdvLoginPage(
                          userRole: "Advertisers",
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    CupertinoIcons.globe,
                    color: Theme.of(context).shadowColor,
                  ),
                  title: Text(
                    "Login As Publisher",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PubLoginPage(
                          userRole: "Publishers",
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFF3C096C),
        ),
        child: const Text(
          "Login",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ).centered(),
      ),
    );
  }
}
