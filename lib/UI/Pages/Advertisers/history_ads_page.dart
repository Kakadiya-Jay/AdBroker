// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Models/advertisement_model.dart';
import 'package:ad_brokers/UI/Widgets/my_ads_template_card.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HistoryAdsPage extends StatefulWidget {
  final List<Advertisements> historyAds;
  const HistoryAdsPage({
    super.key,
    required this.historyAds,
  });

  @override
  State<HistoryAdsPage> createState() => _HistoryAdsPageState();
}

class _HistoryAdsPageState extends State<HistoryAdsPage> {
  String brandName = "";

  getUserData() async {
    await HelperFunctions.getAdvBrandNameSF().then((value) {
      setState(() {
        brandName = value!;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.historyAds.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        if (widget.historyAds.isEmpty && widget.historyAds == []) {
          return Center(
            child: Text(
              "No Data Available",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          );
        }
        return MyAdsTemplate(
          imagePath: widget.historyAds[index].adImageUrl,
          adTitle: widget.historyAds[index].adTitle,
          remainViews: widget.historyAds[index].remainViews,
          noOfPlatforms: 0,
          adStatus: widget.historyAds[index].adStatus,
          noOfDaysLeft: 0,
          adCategory: widget.historyAds[index].adCategory,
          brandName: brandName,
          animationKey: widget.historyAds[index].id,
          price: "499",
        );
      },
    ).pSymmetric(v: 6);
  }
}
