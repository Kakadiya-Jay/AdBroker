import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ShowPlatformTemplateCard extends StatelessWidget {
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

  const ShowPlatformTemplateCard({
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
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(
            width: 1,
            color: Theme.of(context).shadowColor,
          ),
        ),
        child: SizedBox(
          height: 245,
          width: 275,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              const SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Api Key :-",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    id,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
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
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Views : $totalViews",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            "Clicks : $totalClicks",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Text(
                            "$totalEarning₹",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Total Earning",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: Colors.green),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ).pSymmetric(v: 4, h: 8),
            ],
          ),
        ),
      ),
    );
  }
}
