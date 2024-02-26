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
                      width: 1,
                      color: adStatus == "ongoing"
                          ? Colors.green
                          : adStatus == "upcoming"
                              ? Colors.blue
                              : Colors.red),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.fill,
                filterQuality: FilterQuality.high,
              ),
            ).px(8),
            Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "No of Days: $noOfDays",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "No of Viwes: $noOfViwes",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "No of Plateforms: $noOfPlateforms",
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
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "View Details",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ).p(8),
          ],
        ),
      ),
    ).p(8);
  }
}
