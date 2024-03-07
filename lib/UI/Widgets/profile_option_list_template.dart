import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileOptionListTemplate extends StatelessWidget {
  final IconData icon;
  final String menuName;
  final Function callbackFunction;

  const ProfileOptionListTemplate({
    super.key,
    required this.icon,
    required this.menuName,
    required this.callbackFunction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callbackFunction;
      },
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).shadowColor,
        ).scale(scaleValue: 1.1),
        title: Text(
          menuName,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
        ),
        trailing:  Icon(
          CupertinoIcons.right_chevron,
          color: Theme.of(context).shadowColor,
        ),
      ).pSymmetric(v: 4),
    );
  }
}