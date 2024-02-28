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
                  leading: const Icon(CupertinoIcons.person),
                  title: Text(
                    "Login As Advertiser",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/adv/loginPage");
                  },
                ),
                ListTile(
                  leading: const Icon(CupertinoIcons.globe),
                  title: Text(
                    "Login As Publisher",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, "/adv/loginPage");
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
          color: Colors.deepPurple,
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
