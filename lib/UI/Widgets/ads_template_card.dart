import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AdsTemplateCard extends StatelessWidget {
  final num noOfDaysLeft;
  final IconData icon;
  final String imagePath;
  final num? noOfViews;
  final String brandName;
  final num? noOfPlatforms;
  final String adsStatus;
  final num? price;

  const AdsTemplateCard(
      {super.key,
      this.noOfDaysLeft = 0,
      required this.icon,
      required this.imagePath,
      this.noOfViews = 0,
      required this.brandName,
      this.noOfPlatforms = 0,
      this.adsStatus = "Pending",
      this.price = 0});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: adsStatus == "Pending"
          ? Colors.redAccent
          : adsStatus == "OnGoing"
              ? Colors.greenAccent
              : Colors.yellowAccent,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2.0),
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        height: 335,
        width: 275,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: 275,
                  height: 210,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(imagePath),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: const ShapeDecoration(
                            color: Color(0xFF633A89),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                          ),
                          child: Text(
                            "$noOfDaysLeft Days Left",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ).pSymmetric(h: 8, v: 4),
                        ),
                        const Spacer(),
                        Icon(
                          icon,
                          color: Colors.white,
                          shadows: const [
                            Shadow(
                                blurRadius: 4.0,
                                offset: Offset(1, 2),
                                color: Colors.grey)
                          ],
                        ).pSymmetric(h: 16),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  brandName,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Your Ad Runs on $noOfPlatforms platforms",
                  style: Theme.of(context).textTheme.titleSmall,
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
                          adsStatus,
                          style: adsStatus == "Pending"
                              ? Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: Colors.redAccent)
                              : adsStatus == "OnGoing"
                                  ? Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.greenAccent)
                                  : Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.yellowAccent),
                        ),
                        Text(
                          "$price ₹",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text(
                          noOfViews.toString(),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        Text(
                          "Total Views",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ).p(8),
          ],
        ),
      ),
    );
  }
}
