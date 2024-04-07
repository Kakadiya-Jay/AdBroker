import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class FilterdPlatformTemplate extends StatelessWidget {
  final String id;
  final String imagePath;
  final String appName;
  final String bundleId;
  final String appCategory;
  final String redirectUrl;
  final num totalViews;
  final num totalClicks;
  final num totalEarning;
  final Function onClickAction;

  const FilterdPlatformTemplate({
    super.key,
    required this.id,
    required this.imagePath,
    required this.appName,
    required this.bundleId,
    required this.appCategory,
    required this.redirectUrl,
    required this.totalViews,
    required this.totalClicks,
    required this.totalEarning,
    required this.onClickAction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClickAction();
      },
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(
            width: 1,
            color: Theme.of(context).shadowColor,
          ),
        ),
        child: SizedBox(
          height: 170,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              ListTile(
                leading: Image.asset(
                  "assets/icons/default-app-icon.png",
                  height: 65,
                  width: 65,
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                ),
                title: Text(
                  appName,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                subtitle: Text(
                  appCategory,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bundleId,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    redirectUrl,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Earning : $totalEarning",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ],
          ).p8(),
        ),
      ).pSymmetric(h: 8, v: 4),
    );
  }
}
