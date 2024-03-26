import 'package:ad_brokers/UI/Pages/Advertisers/show_ads_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AdsTemplateCard extends StatelessWidget {
  final String imagePath;
  final num remainViews;
  final String brandName;
  final String brandURL;
  final String adTitle;
  final String adCategory;
  final String adType;
  final num noOfPlatforms;
  final String adsStatus;
  final num price;
  final String animationKey;

  const AdsTemplateCard({
    super.key,
    required this.imagePath,
    required this.remainViews,
    required this.brandName,
    required this.brandURL,
    required this.adsStatus,
    required this.price,
    required this.adTitle,
    required this.adCategory,
    required this.adType,
    required this.animationKey,
    required this.noOfPlatforms,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowAdsDetailsPage(
              brandName: brandName,
              adTitle: adTitle,
              adCategory: adCategory,
              adType: adType,
              brandURL: brandURL,
              noOfPlatforms: noOfPlatforms,
              remainViews: remainViews,
              imagePath: imagePath,
              adsStatus: adsStatus,
              price: price,
              animationTag: animationKey,
            ),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shadowColor: adsStatus == "pending"
            ? Colors.redAccent
            : adsStatus == "ongoing"
                ? Colors.green
                : Colors.blue,
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2.0),
        color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            width: 1,
            color: adsStatus == "pending"
                ? Colors.redAccent
                : adsStatus == "ongoing"
                    ? Colors.green
                    : Colors.blue,
          ),
        ),
        child: SizedBox(
          height: 320,
          width: 275,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: animationKey,
                    child: SizedBox(
                      width: 275,
                      height: 210,
                      child: Image.network(
                        imagePath,
                        fit: BoxFit.fill,
                        filterQuality: FilterQuality.high,
                        width: 275,
                        height: 210,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).shadowColor,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
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
                              adCategory,
                              style: const TextStyle(
                                color: Color(0xFFF9F9F9),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ).pSymmetric(h: 8, v: 4),
                          ),
                          const Spacer(),
                          const Icon(
                            CupertinoIcons.eye,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                  blurRadius: 4.0,
                                  offset: Offset(1, 1),
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
                            style: adsStatus == "pending"
                                ? Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: Colors.redAccent)
                                : adsStatus == "ongoing"
                                    ? Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: Colors.green)
                                    : Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: Colors.blue),
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
                            remainViews.toString(),
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Text(
                            "Remain Views",
                            style: Theme.of(context).textTheme.displaySmall,
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
