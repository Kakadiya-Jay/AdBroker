// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Models/advertisement_model.dart';
import 'package:ad_brokers/UI/Widgets/my_ads_template_card.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PendingAdsPage extends StatefulWidget {
  final List<Advertisements> pendingAds;
  const PendingAdsPage({
    super.key,
    required this.pendingAds,
  });

  @override
  State<PendingAdsPage> createState() => _PendingAdsPageState();
}

class _PendingAdsPageState extends State<PendingAdsPage> {
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
      itemCount: widget.pendingAds.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        if (widget.pendingAds.isEmpty && widget.pendingAds == []) {
          return Center(
            child: Text(
              "No Data Available",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          );
        }
        return MyAdsTemplate(
          imagePath: widget.pendingAds[index].adImageUrl,
          adTitle: widget.pendingAds[index].adTitle,
          remainViwes: widget.pendingAds[index].remainViews,
          noOfPlateforms: 0,
          adStatus: widget.pendingAds[index].adStatus,
          noOfDaysLeft: 0,
          adCategory: widget.pendingAds[index].adCategory,
          brandName: brandName,
          animationKey: widget.pendingAds[index].id,
          price: "499",
        );
      },
    ).pSymmetric(v: 6);
  }
}
