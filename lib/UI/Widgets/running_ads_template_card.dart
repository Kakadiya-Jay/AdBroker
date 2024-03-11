import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class RunningAdsTemplateCard extends StatelessWidget {
  final String imagePath;
  final String brandName;
  final num noOfViews;
  final String adsCategory;
  final num totalClicks;
  final num profitAmount;

  const RunningAdsTemplateCard({
    super.key,
    required this.imagePath,
    required this.brandName,
    required this.noOfViews,
    required this.adsCategory,
    required this.totalClicks,
    required this.profitAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SizedBox(
        height: 320,
        width: 275,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.asset(
                imagePath,
                width: 275,
                height: 210,
                fit: BoxFit.fill,
                filterQuality: FilterQuality.high,
              ),
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
                  "Category : $adsCategory",
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
                          "Views : $noOfViews",
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
                          profitAmount.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Total Profit",
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
    );
  }
}
