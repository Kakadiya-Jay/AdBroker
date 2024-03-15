import 'package:ad_brokers/UI/Pages/Advertisers/show_ads_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyAdsTemplate extends StatelessWidget {
  final String imagePath;
  final String adTitle;
  final num remainViwes;
  final num noOfPlateforms;
  final String adStatus;
  final num noOfDaysLeft;
  final String brandName;
  final String adCategory;
  final String price;
  final String animationKey;

  const MyAdsTemplate({
    super.key,
    required this.imagePath,
    required this.adTitle,
    required this.remainViwes,
    required this.noOfPlateforms,
    required this.adStatus,
    required this.noOfDaysLeft,
    required this.brandName,
    required this.adCategory,
    required this.price,
    required this.animationKey,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: 4.0,
      child: SizedBox(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width / 2,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1.7,
                    color: adStatus == "ongoing"
                        ? Colors.green
                        : adStatus == "pending"
                            ? Colors.red
                            : Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  imagePath,
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
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
            ).px(8),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      adTitle,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Viwes: $remainViwes",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      adCategory,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      adStatus,
                      style: adStatus == "ongoing"
                          ? Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.green)
                          : adStatus == "pending"
                              ? Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: Colors.red)
                              : Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: Colors.blue),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowAdsDetailsPage(
                              brandName: brandName,
                              adTitle: adTitle,
                              adCategory: adCategory,
                              noOfPlatforms: noOfPlateforms,
                              noOfDaysLeft: noOfDaysLeft,
                              remainViews: remainViwes,
                              imagePath: imagePath,
                              adsStatus: adStatus,
                              price: price,
                              animationTag: animationKey,
                            ),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            "View ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            CupertinoIcons.arrow_right,
                            color: Colors.white,
                            size: 14,
                          ),
                        ],
                      ),
                    ).pOnly(left: 16, right: 0, top: 4, bottom: 4),
                  ],
                ),
              ],
            ).pSymmetric(h: 8, v: 6),
          ],
        ),
      ),
    ).pSymmetric(h: 8, v: 2);
  }
}
