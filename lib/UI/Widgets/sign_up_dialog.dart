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
                    Navigator.pushNamed(context, "/signupPage");
                  },
                  child: ListTile(
                    leading: const Icon(CupertinoIcons.person),
                    title: Text(
                      "Advertiser",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    subtitle: Text(
                      "You can create Ads",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
                const Divider(),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pushNamed(context, "/signupPage");
                  },
                  child: ListTile(
                    leading: const Icon(CupertinoIcons.globe),
                    title: Text(
                      "Publisher",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    subtitle: Text("You can publish Ads",
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.red,
                  child: const Text("Close"),
                )
              ],
            );
          },
        );
      },
      child: Container(
          width: MediaQuery.of(context).size.width / 2.5,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Text(
            "Sign up",
            style: Theme.of(context).textTheme.displayMedium,
          ).centered()),
    );
  }
}
