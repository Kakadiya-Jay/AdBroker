import 'package:ad_brokers/UI/Pages/Authentications/adv_signuppage.dart';
import 'package:ad_brokers/UI/Pages/Authentications/pub_signuppage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpDialog extends StatelessWidget {
  const SignUpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) {
            return SimpleDialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0.0,
              title: Text(
                "Register As",
                style: Theme.of(context).textTheme.titleLarge,
              ).centered(),
              children: [
                Text(
                  "Choose your role",
                  style: Theme.of(context).textTheme.displayMedium,
                ).centered(),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdvSignUpPage(
                          userRole: "Advertisers",
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Icon(
                      CupertinoIcons.person,
                      color: Theme.of(context).shadowColor,
                    ),
                    title: Text(
                      "Advertiser",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    subtitle: Text(
                      "You can create Ads",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ).pSymmetric(h: 16),
                const Divider().pSymmetric(h: 16),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PubSignUpPage(
                          userRole: "Publishers",
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Icon(
                      CupertinoIcons.globe,
                      color: Theme.of(context).shadowColor,
                    ),
                    title: Text(
                      "Publisher",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    subtitle: Text("You can publish Ads",
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                ).pSymmetric(h: 16),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: Colors.red,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text(
                      "Close",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ).pOnly(left: 16, right: 16, top: 2, bottom: 4),
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
          "Sign up",
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
