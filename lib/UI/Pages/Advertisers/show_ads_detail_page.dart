import 'package:ad_brokers/UI/Widgets/uihelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ShowAdsDetailsPage extends StatefulWidget {
  final String brandName;
  final num noOfPlatforms;
  final num noOfDaysLeft;
  final num noOfViews;
  final String imagePath;
  final String adsStatus;
  final num price;
  const ShowAdsDetailsPage(
      {super.key,
      required this.brandName,
      required this.noOfPlatforms,
      required this.noOfDaysLeft,
      required this.noOfViews,
      required this.imagePath,
      required this.adsStatus,
      required this.price});

  @override
  State<ShowAdsDetailsPage> createState() => _ShowAdsDetailsPageState();
}

class _ShowAdsDetailsPageState extends State<ShowAdsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          widget.brandName,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: "id of Advertisement",
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.imagePath),
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${widget.noOfDaysLeft.toString()} days left",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium,
            ).centered(),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Views Count :- ${widget.noOfViews.toString()}",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Total Platforms :- ${widget.noOfPlatforms.toString()}",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.adsStatus,
              style: widget.adsStatus == "Pending"
                  ? Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.redAccent)
                  : widget.adsStatus == "OnGoing"
                      ? Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.green)
                      : Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.blue),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              color: Colors.grey,
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(width: 1, color: Colors.black)),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ListTile(
                      leading: Icon(Icons.currency_rupee_rounded),
                      title: Text("Plans"),
                      trailing: Icon(CupertinoIcons.right_chevron),
                    ),
                    Text(
                      "${widget.price.toString()}₹",
                      style: Theme.of(context).textTheme.titleLarge,
                    ).pSymmetric(h: 20).pOnly(bottom: 8)
                  ],
                ).pSymmetric(v: 6),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: CupertinoButton(
                onPressed: () {
                  UiHelper.customSnackBar(
                    context,
                    "Analaysis Page Coming soon..",
                  );
                },
                color: Colors.purple,
                child: const Text(
                  "Show Analysis",
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ).p16(),
      ),
    );
  }
}
