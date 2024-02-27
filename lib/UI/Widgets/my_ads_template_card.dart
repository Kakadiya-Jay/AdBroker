import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyAdsTemplate extends StatelessWidget {
  final String imagePath;
  final num noOfDays;
  final num noOfViwes;
  final num noOfPlateforms;
  final String adStatus;

  const MyAdsTemplate({
    super.key,
    required this.imagePath,
    required this.noOfDays,
    required this.noOfViwes,
    required this.noOfPlateforms,
    required this.adStatus,
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
                          : adStatus == "upcoming"
                              ? Colors.blue
                              : Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ).px(8),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Days Left: $noOfDays",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Viwes: $noOfViwes",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Plateforms: $noOfPlateforms",
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
                            : adStatus == "upcoming"
                                ? Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: Colors.blue)
                                : Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: Colors.red),
                      ),
                      TextButton(
                        onPressed: () {},
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
                ),
              ],
            ).pSymmetric(h: 8, v: 6),
          ],
        ),
      ),
    ).p(8);
  }
}
